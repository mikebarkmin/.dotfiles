---
name: unterrichtsmaterial-taggen
description: Lehrplanbasiertes Taggen von Unterrichtsmaterialien im Format Markdown und Typst
---

# Skill: Lehrplanbasiertes Taggen von Markdown- und Typst-Unterrichtsmaterialien

## Zweck
Analysiere vorhandene Unterrichtsmaterialien im Format Markdown (`.md`) und Typst (`.typ`) und ordne sie anhand der vorhandenen Lehrplan-Wissensbasis strukturiert ein.

Ziel ist, Materialien mit einheitlichen, maschinenlesbaren Metadaten zu versehen, damit eine KI später zuverlässig erkennen kann:
- Fach
- Jahrgangsstufe(n)
- Thema und Unterthema
- Unterrichtsvorhaben
- Inhaltsfelder
- Kompetenzen
- Leistungsbewertung
- verbindliche Absprachen aus dem SILP
- Lehrplanbezug und mögliche Lücken
- Beziehungen zu anderen Materialien

Der Skill verändert standardmäßig nicht den fachlichen Inhalt eines Materials. Seine primäre Aufgabe ist Analyse, Zuordnung und Verschlagwortung.

# 1. Wissensgrundlage und Prioritäten
Nutze die vorhandene Lehrplan-Wissensbasis.

Priorität:
1. SILP: höchste Priorität; enthält verbindliche Unterrichtsvorhaben, Absprachen und ggf. Vorgaben zur Leistungsbewertung.
2. Für den konkreten Schülerjahrgang gültiger KLP: ergänzt den SILP mit Kompetenzen, Inhaltsfeldern und Progression.
3. KLP-WP: nur wenn vorhanden und tatsächlich relevant.
4. Neuer Sek-II-KLP / Neu-Entwurf: nur für die betroffenen späteren Schülerjahrgänge; nicht auf ältere Jahrgänge übertragen.

Konkrete Vorgaben aus dem SILP haben Vorrang.

# 2. Ordnerstruktur als primäre Kontextquelle
Die Materialien folgen grundsätzlich:

`fach/jahrgang-thema/stunde-unterthema/datei`

Beispiel:

`informatik/06-algorithmen/01-roboter-koennen-programmieren/arbeitsblatt.typ`

Interpretation:
- `informatik`: Fach
- `06-algorithmen`: Jahrgangsstufe 6 und übergeordnetes Thema/Reihe „Algorithmen“
- `01-roboter-koennen-programmieren`: Reihenposition 1 und Unterthema „Roboter können programmieren“
- `arbeitsblatt.typ`: konkretes Material

Der Pfad liefert starken Kontext, ersetzt aber nicht die Inhaltsanalyse.

## 2.1 Fach
Die erste relevante Ordnerebene entspricht grundsätzlich dem Fach.

## 2.2 Jahrgangsstufe und Thema
Der Reihenordner folgt grundsätzlich `JJ-thema`.
Führende Nullen werden entfernt. Der Rest beschreibt Thema bzw. Unterrichtsreihe.

Beispiel:
`08-kuenstliche-intelligenz` → Jahrgangsstufe 8, Thema „Künstliche Intelligenz“.

## 2.3 Stunde und Unterthema
Der Unterordner folgt grundsätzlich `NN-unterthema`.
Die führende Zahl beschreibt die Position innerhalb der Reihe.

Beispiel:
`04-algorithmen-im-alltag` → Reihenposition 4, Unterthema „Algorithmen im Alltag“.

## 2.4 Dateiname
Der Dateiname kann Hinweise auf den Materialtyp liefern, z. B.:
- `arbeitsblatt.typ` → Arbeitsblatt
- `praesentation.typ` → Präsentation
- `erwartungshorizont.typ` → Erwartungshorizont
- `aufgaben.md` → Aufgabenblatt

Der tatsächliche Inhalt hat Vorrang.

# 3. Analyseablauf
Für jede Datei:
1. Datei, Format und Pfad bestimmen.
2. Vorhandene Metadaten prüfen.
3. Tatsächlichen Inhalt analysieren.
4. Fach, Jahrgangsstufe und Sekundarstufe bestimmen.
5. Bei Sek II den für den konkreten Schülerjahrgang geltenden KLP bestimmen.
6. Passendes SILP-Unterrichtsvorhaben suchen.
7. Inhaltsfelder und Kompetenzen zuordnen.
8. Relevanz für Leistungsbewertung und verbindliche Absprachen prüfen.
9. Metadaten ergänzen oder aktualisieren.
10. Mögliche Lücken und Beziehungen zu anderen Materialien dokumentieren.

# 4. Umgang mit bestehenden Metadaten
Vorhandene korrekte Angaben nicht unnötig überschreiben.
Fehlende Angaben ergänzen.
Widersprüche markieren, nicht stillschweigend verdecken.
Widerspricht eine Angabe einer verbindlichen SILP-Vorgabe, dokumentiere den Konflikt.

# 5. Inhaltliche Analyse
Bestimme, soweit zuverlässig möglich:
- zentrales Thema und Unterthemen
- fachliche Konzepte
- Lernziele
- Aufgabenformate
- geforderte Denk- und Arbeitsleistungen
- explizit oder implizit geförderte Kompetenzen
- Leistungsanforderungen
- methodische Schwerpunkte

Unterscheide:
- explizit belegbar
- plausibel zuordenbar
- unsicher

Unsicheres nicht als gesicherte Tatsache taggen.

# 6. Zuordnung zum Unterrichtsvorhaben
Suche zuerst nach passenden SILP-Unterrichtsvorhaben.

Reihenfolge:
1. Jahrgangsstufe
2. SILP
3. Inhaltsfelder
4. thematische Übereinstimmung
5. Kompetenzbezug

Verwende möglichst stabile IDs aus der Wissensbasis.

Beispiel:

```yaml
unterrichtsvorhaben:
  - id: UV-SEK1-08-02
    sicherheit: hoch
```

Mehrere passende UVs dürfen angegeben werden. Keine künstliche Eindeutigkeit erzeugen.

# 7. Kompetenzen
Verwende Kompetenz-IDs aus der Wissensbasis und unterscheide:
- primaer
- sekundaer
- ueberprueft
- vorausgesetzt

Eine Kompetenz darf nur als `ueberprueft` gelten, wenn das Material tatsächlich eine bewert- oder überprüfbare Leistung dazu verlangt.

# 8. Inhaltsfelder
Ordne nur tatsächlich relevante Inhaltsfelder anhand stabiler IDs zu.

# 9. Leistungsbewertung und verbindliche Absprachen
Prüfe, ob das Material für Klassenarbeiten, Klausuren, Tests, sonstige Leistungsüberprüfungen oder Erwartungshorizonte relevant ist.

Prüfe dazu die entsprechenden SILP-Vorgaben.

Erfinde keine schulischen Bewertungsregeln oder verbindlichen Absprachen.

# 10. Standard-Metadaten
Bevorzugtes Schema:

```yaml
---
typ: unterrichtsmaterial

fach: ...
jahrgangsstufen: []
sekundarstufen: []

lehrplanstand:
  sek_ii_klp: nicht_relevant

thema: ...
unterthema: ...
suchbegriffe: []

reihenposition: null

pfad:
  fach: ...
  reihe: ...
  einheit: ...
  datei: ...

unterrichtsvorhaben: []
inhaltsfelder: []

kompetenzen:
  primaer: []
  sekundaer: []
  ueberprueft: []
  vorausgesetzt: []

leistungsbewertung:
  relevant: false
  silp_bezug: []

verbindliche_absprachen: []

materialtyp: ...

herkunft_der_metadaten:
  fach: ...
  jahrgangsstufen: ...
  thema: ...
  unterthema: ...
  materialtyp: ...
  unterrichtsvorhaben: ...
  kompetenzen: ...

status_der_zuordnung: geprueft
zuordnungssicherheit: hoch
hinweise_zur_zuordnung: []
---
```

# 11. Markdown
Verwende YAML-Frontmatter am Anfang der Datei. Der übrige Inhalt bleibt unverändert.

# 12. Typst
Verwende einen maschinenlesbaren Kommentarblock am Anfang, der die Kompilierbarkeit nicht beeinträchtigt:

```typst
// @metadata
// typ: unterrichtsmaterial
// fach: ...
// jahrgangsstufen: [8]
// thema: ...
// unterrichtsvorhaben: [UV-SEK1-08-02]
// inhaltsfelder: [IF-...]
// kompetenzen_primaer: [KOMP-...]
// kompetenzen_sekundaer: []
// kompetenzen_ueberprueft: []
// kompetenzen_vorausgesetzt: []
// leistungsbewertung_relevant: false
// verbindliche_absprachen: []
// @endmetadata
```

# 13. Sonderbereich xx-arbeiten
Der Ordner `xx-arbeiten/` enthält Klassenarbeiten und andere Leistungsüberprüfungen und folgt nicht der regulären Reihenstruktur.

Beispiel:

`K09_2026_HT_Robotik.typ`

Vorläufige Interpretation:
- `K`: Klassenarbeit
- `09`: Jahrgangsstufe 9
- `2026`: Jahr
- `HT`: Kürzel; Bedeutung nicht erfinden, wenn keine dokumentierte Konvention vorliegt
- `Robotik`: Thema

Beispielmetadaten:

```yaml
materialtyp: Klassenarbeit
jahrgangsstufen: [9]
jahr: 2026
dateikuerzel: HT
dateikuerzel_bedeutung: unklar
thema: Robotik
leistungsbewertung:
  relevant: true
```

Analysiere anschließend die tatsächlichen Aufgaben und prüfe:
- überprüfte Kompetenzen
- Inhaltsfelder
- Anforderungsniveau
- Aufgabenformate
- SILP-Vorgaben zur Leistungsbewertung
- mögliche Zuordnung zu Unterrichtsvorhaben

# 14. Beziehungen zwischen Materialien
Bei mehreren Dateien prüfe, ob Beziehungen eindeutig erkennbar sind, z. B.:
- Arbeitsblatt gehört zu einer Reihe
- Erwartungshorizont gehört zu einer Aufgabe
- Präsentation ergänzt eine Stunde
- Klassenarbeit prüft Kompetenzen aus mehreren UVs

Nicht allein aufgrund ähnlicher Dateinamen Beziehungen erfinden.

# 15. Lückenanalyse
Vergleiche Lehrplananforderungen und Ziel des UV mit dem einzelnen Material bzw. einer Materialgruppe.

Unterscheide:
- bereits abgedeckt
- teilweise abgedeckt
- nicht erkennbar abgedeckt
- vorausgesetzt

Eine Lücke bedeutet nicht automatisch, dass ein Material fehlerhaft ist.

# 16. Umgang mit Widersprüchen
Priorität bei Widersprüchen:
1. verbindliche Lehrplan-Wissensbasis, insbesondere SILP
2. tatsächlicher Inhalt
3. explizite vorhandene Metadaten
4. Ordnerstruktur
5. Dateiname

Konflikte sichtbar dokumentieren.

# 17. Sicherheit
Verwende:
- hoch
- mittel
- niedrig
- unklar

Bei niedriger oder unklarer Sicherheit keine scheinbare Verbindlichkeit erzeugen.

# 18. Änderungen am Material
Ändere standardmäßig nur Metadaten und technisch notwendige Struktur.
Ändere nicht ohne ausdrücklichen Auftrag:
- Aufgabenstellungen
- fachliche Inhalte
- Formulierungen
- Layout
- Typst-Struktur
- didaktische Entscheidungen

# 19. Abschluss jeder Analyse
Gib eine kurze Zusammenfassung aus:
- Fach
- Jahrgangsstufe(n)
- Unterrichtsvorhaben
- zentrale Kompetenzen
- Inhaltsfelder
- SILP-Bezug
- relevante Leistungsbewertung
- relevante Absprachen
- Gesamtsicherheit
- hinzugefügte/aktualisierte Metadaten
- mögliche Lücken

Oberste Regel:

> Tagge nur, was durch Material und Lehrplan-Wissensbasis belegbar oder nachvollziehbar zuordenbar ist. SILP-Vorgaben haben bei konkreten schulischen Anforderungen Vorrang. Unsicherheiten müssen sichtbar bleiben.

