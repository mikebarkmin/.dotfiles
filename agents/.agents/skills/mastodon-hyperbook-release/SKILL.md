---
name: mastodon-hyperbook-release
description: Fast workflow to extract a Hyperbook release from changelog.md, match documentation links, validate post length, copy to clipboard via wl-copy, and output the post.
---

Generate a Mastodon release post for Hyperbook.

### Argument Handling
When this skill is invoked via `/skill:mastodon-hyperbook-release [version]`, Pi appends the `[version]` argument as a standard user message at the bottom of the context.
- If the user message contains a version (e.g., `v0.100.0` or `0.100.0`), use it as the target version.
- If the user message is empty or missing, assume they want the latest release.

### Instructions

1. **Extract Release Section directly via CLI:**
   - Execute the parser script to fetch only the needed changelog entry. Substitute `<target_version>` with the version requested by the user, or leave it empty `""` for the latest version.
     ```bash
     node ~/.agents/skills/mastodon-hyperbook-release/parse-changelog.js website/en/book/changelog.md "<target_version>"
     ```

2. **Map Documentation Link:**
   - Identify key features mentioned in the extracted text (e.g., `struktolab`, `alert`, `pyide`).
   - Check `website/en/book/` and subfolders (e.g., `website/en/book/elements/`) for a matching `.md` file.
   - If found, construct the URL: `https://hyperbook.openpatch.org/<path-without-md-extension>`
   - If no specific match exists, use `https://hyperbook.openpatch.org`.

3. **Format Post Draft:**
   - Summarize the extracted changes into concise bullet points matching the openpatch format:

#hyperbook <version> got released:

- <change bullet 1>
- <change bullet 2>

<documentation link>

<hashtags>

4. **Validate Character Count:**
   - Run the validator script on the draft:
     ```bash
     node ~/.agents/skills/mastodon-hyperbook-release/validation.js "<draft_text>"
     ```
   - If it exceeds 500 weighted characters, trim bullet points until it exits with status 0.

5. **Copy to Clipboard & Output:**
   - Pipe the final validated post into `wl-copy`:
     ```bash
     printf '%b' "<validated_post_text>" | wl-copy
     ```
   - Output the formatted post to the user and confirm it has been copied to the clipboard.
