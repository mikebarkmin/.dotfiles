#!/usr/bin/env bash
PRUSA_URL="${PRUSA_URL:-http://192.168.178.93}"
API_KEY="${PRUSA_API_KEY:-}"
RTSP_URL="${PRUSA_RTSP_URL:-rtsp://192.168.178.94/live}"

if [[ "$1" == "--stream" ]]; then
    exec mpv \
        --title="prusa-live-float" \
        --profile=low-latency \
        --untimed \
        --no-cache \
        --rtsp-transport=tcp \
        --demuxer-lavf-o="rtsp_transport=tcp" \
        "$RTSP_URL" &>/dev/null &
    exit 0
fi

JSON=$(curl -fsS --digest -u "maker:$API_KEY" --max-time 3 \
    "$PRUSA_URL/api/v1/status" 2>/dev/null)

if [[ $? -ne 0 || -z "$JSON" ]]; then
    jq -nc '{"text":"⚫ Off","class":"offline","tooltip":"Printer offline or unreachable"}'
    exit 0
fi

read -r STATE NOZZLE_ACT NOZZLE_TRG BED_ACT BED_TRG PROGRESS REMAINING TIME_PRINTING < <(
    jq -r '[
        .printer.state // "UNKNOWN",
        (.printer.temp_nozzle // 0),
        (.printer.target_nozzle // 0),
        (.printer.temp_bed // 0),
        (.printer.target_bed // 0),
        (.job.progress // 0),
        (.job.time_remaining // 0),
        (.job.time_printing // 0)
    ] | @tsv' <<< "$JSON"
)

fmt_duration() {
    local secs=$1
    if ! [[ "$secs" =~ ^[0-9]+$ ]] || (( secs == 0 )); then echo "—"; return; fi
    local h=$(( secs / 3600 )) m=$(( (secs % 3600) / 60 ))
    (( h > 0 )) && echo "${h}h ${m}m" || echo "${m}m"
}

TOOLTIP=$(printf "State: %s\nNozzle: %s°C → %s°C\nBed: %s°C → %s°C\nProgress: %.1f%%" \
    "$STATE" "$NOZZLE_ACT" "$NOZZLE_TRG" "$BED_ACT" "$BED_TRG" "$PROGRESS")

case "$STATE" in
    PRINTING|BUSY)
        ELAPSED=$(fmt_duration "$TIME_PRINTING")
        REMAIN=$(fmt_duration "$REMAINING")
        TOOLTIP+=$(printf "\nElapsed: %s  Remaining: %s" "$ELAPSED" "$REMAIN")
        if [[ "$(fmt_duration "$REMAINING")" != "—" ]]; then
            TEXT="🖨 $(fmt_duration "$REMAINING")"
        else
            TEXT="🖨 ${PROGRESS}%"
        fi
        CLASS="printing" ;;
    PAUSED)
        TOOLTIP+=$(printf "\nElapsed: %s" "$(fmt_duration "$TIME_PRINTING")")
        TEXT="⏸ ${PROGRESS}%"
        CLASS="paused" ;;
    FINISHED)
        TEXT="✅ Done"
        CLASS="finished" ;;
    STOPPED)
        TEXT="🛑 Stopped"
        CLASS="stopped" ;;
    ERROR)
        TEXT="❌ Error"
        CLASS="error" ;;
    ATTENTION)
        TEXT="⚠ Attention"
        CLASS="attention" ;;
    IDLE|READY)
        TEXT="⏹ Idle"
        CLASS="idle" ;;
    *)
        TEXT="⚙ $STATE"
        CLASS="other" ;;
esac

jq -nc \
    --arg text "$TEXT" \
    --arg class "$CLASS" \
    --arg tooltip "$TOOLTIP" \
    --argjson pct "$PROGRESS" \
    '{"text":$text,"class":$class,"tooltip":$tooltip,"percentage":$pct}'
