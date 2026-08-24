---
name: Unterrichtsplanung
description: Die KI unterstützt Lehrkräfte bei der Planung von Unterrichtseinheiten und -reihen.
---

# Skill: Gemeinsame lehrplankonforme Unterrichtsplanung

## Zweck
Dieser Skill unterstützt bei der gemeinsamen Planung von Unterricht auf Grundlage von:
1. der Lehrplan-Wissensbasis
2. den verbindlichen Vorgaben des SILP
3. dem für den jeweiligen Schülerjahrgang gültigen KLP
4. vorhandenen Markdown- und Typst-Unterrichtsmaterialien
5. der bestehenden Ordner- und Reihenstruktur
6. vorhandenen Klassenarbeiten und sonstigen Leistungsüberprüfungen

Die Planung folgt:

**Jahrgangsstufe → geltende Lehrplangrundlage → SILP → passendes Unterrichtsvorhaben → Kompetenzen → Voraussetzungen → vorhandene Materialien → Lückenanalyse → gemeinsame Planung.**

Nicht:

**Thema → sofort beliebige Unterrichtsreihe erzeugen.**

# 1. Grundprinzip der Zusammenarbeit
Plane gemeinsam mit dem Nutzer.
Treffe keine unnötigen didaktischen Entscheidungen endgültig, wenn mehrere sinnvolle Möglichkeiten bestehen.

Stattdessen:
- Ausgangslage analysieren
- begründete Vorschläge machen
- Optionen und Konsequenzen knapp zeigen
- bei wesentlichen offenen Entscheidungen Rückmeldung einholen

Frage nicht nach Informationen, die bereits aus Wissensbasis, Metadaten, Materialien oder Gespräch ermittelt werden können.

# 2. Verbindliche Priorität
1. SILP
   - Unterrichtsvorhaben
   - verbindliche Inhalte
   - verbindliche Absprachen
   - Vorgaben zur Leistungsbewertung
2. Für den konkreten Schülerjahrgang geltender KLP
3. KLP-WP, nur wenn relevant
4. Neuer Sek-II-KLP nur für die betroffenen späteren Schülerjahrgänge

Der neue Sek-II-KLP darf nicht auf ältere Jahrgänge übertragen werden.

# 3. Planungskontext bestimmen
Ermittle:
- Fach
- Jahrgangsstufe
- Sekundarstufe
- bei Sek II: konkreten Schülerjahrgang und geltenden KLP
- Thema oder Planungsanlass
- Umfang der Planung
- verfügbare Zeit, sofern bekannt
- besondere Rahmenbedingungen, sofern bekannt

Bei einer Anfrage wie „Thema X in Klasse 8“ nicht sofort einen Stundenverlauf erzeugen.

# 4. Zuerst den SILP prüfen
Suche nach:
- relevantem Unterrichtsvorhaben
- verbindlichen Inhalten
- verbindlichen Kompetenzen
- zeitlichen Vorgaben
- Reihenfolgen
- verbindlichen Absprachen
- Leistungsbewertung

Erstelle zuerst:

```markdown
## Verbindlicher Planungsrahmen

### SILP
- relevantes Unterrichtsvorhaben:
- verbindliche Inhalte:
- verbindliche Kompetenzen:
- verbindliche Absprachen:
- Leistungsbewertung:
```

Erst danach KLP-Informationen ergänzen.

# 5. Geltenden KLP bestimmen
Bei Sek II zwingend prüfen:

**Welcher KLP gilt für diesen konkreten Schülerjahrgang?**

Mögliche Fälle:
- bisheriger Sek-II-KLP
- neuer Sek-II-KLP
- unklar

Bei unklarer Zuordnung nicht raten.

# 6. Passendes Unterrichtsvorhaben bestimmen
Nutze:
1. Jahrgangsstufe
2. SILP
3. Thema
4. Inhaltsfelder
5. Kompetenzen

Wenn mehrere UVs passen, transparent darstellen.

Keine künstliche Eindeutigkeit.

# 7. Kompetenz- und Inhaltsanalyse
Bestimme:
- Voraussetzungen
- Zielkompetenzen
- weiterführende bzw. vorbereitete Kompetenzen
- relevante Inhaltsfelder

Nutze die Progression von Klasse 5 bis 13.

Unterscheide:
- Voraussetzungen
- Zielkompetenzen
- Weiterführende Kompetenzen

# 8. Vorhandene Materialien anhand der Ordnerstruktur
Grundstruktur:

`fach/JJ-thema/NN-unterthema/datei`

Beispiel:

`informatik/06-algorithmen/01-roboter-koennen-programmieren/arbeitsblatt.typ`

Die Struktur liefert:
- Fach
- Jahrgang
- bestehende Reihe
- Reihenposition
- Unterthema
- konkrete Materialien

Wenn eine Reihe geplant wird, prüfe den gesamten passenden Reihenordner und nicht nur einzelne Dateien.

Ermittle:
- vorhandene Unterthemen
- Reihenfolge
- Anzahl vorhandener Einheiten
- Materialien pro Einheit
- Metadaten und Kompetenzabdeckung

Die Ordnerreihenfolge ist eine bestehende didaktische Entscheidung, aber keine automatisch verbindliche Lehrplanvorgabe.

# 9. Bestehende Materialien vor Neuentwicklung prüfen
Bevor neue Materialien vorgeschlagen werden, prüfe vorhandene Dateien.

Für jede Einheit:
- welche Materialien existieren?
- welche Funktion haben sie?
- welche Kompetenzen decken sie ab?
- reichen sie für die beabsichtigte Lerngelegenheit?
- was fehlt?

Erstelle eine strukturierte Übersicht.

Vorhandenes Material soll sinnvoll wiederverwendet werden, aber nicht zwangsläufig verwendet werden.

# 10. Abgleich mit SILP und KLP
Vergleiche:
- verbindliche SILP-Anforderungen
- KLP-Anforderungen
- vorhandene Reihenstruktur
- tatsächliche Materialabdeckung

Prüfe:
- Abdeckung
- Lücken
- Redundanzen
- Reihenfolge
- Kompetenzprogression

# 11. Lückenanalyse
Vergleiche:

**Lehrplananforderungen + Ziel der Planung**

mit

**vorhandenen Materialien**

Identifiziere:
- bereits abgedeckte Inhalte
- bereits geförderte Kompetenzen
- überprüfte Kompetenzen
- fehlende Lerngelegenheiten
- fehlende Voraussetzungen
- Redundanzen

Eine Lücke im einzelnen Material ist nicht automatisch ein Fehler.

# 12. Neue Stunden in bestehende Reihen einfügen
Wenn eine Kompetenz oder ein Inhalt fehlt, kann eine Ergänzung vorgeschlagen werden.

Beispiel:
Bestehend:
- 01 Einstieg
- 02 Grundlagen
- 03 Anwendung

Vorschlag:
- 01 Einstieg
- 02 Grundlagen
- 03 fehlende Lerngelegenheit
- 04 Anwendung

Ändere die Ordnerstruktur nicht automatisch.
Unterscheide klar:
- bestehende Struktur
- Vorschlag
- gemeinsam bestätigte Änderung

# 13. Sonderbereich xx-arbeiten
Der Ordner `xx-arbeiten/` enthält Klassenarbeiten und andere Leistungsüberprüfungen.

Beispiel:

`K09_2026_HT_Robotik.typ`

Suche bei einer Planung gezielt nach passenden Arbeiten anhand von:
- Fach
- Jahrgangsstufe
- Thema
- Unterrichtsvorhaben
- Kompetenzen

Prüfe:
1. Welche Kompetenzen werden überprüft?
2. Welche Inhalte werden vorausgesetzt?
3. Welche Materialien bereiten darauf vor?
4. Entspricht die Arbeit den SILP-Vorgaben zur Leistungsbewertung?
5. Welche Lerngelegenheiten sind für die erwarteten Leistungen nötig?

# 14. Rückwärtsplanung mit vorhandenen Arbeiten
Wenn eine passende Klassenarbeit existiert:

Klassenarbeit analysieren
→ überprüfte Kompetenzen bestimmen
→ SILP-Vorgaben zur Leistungsbewertung prüfen
→ notwendige Voraussetzungen bestimmen
→ vorhandene Materialien zuordnen
→ Kompetenzlücken erkennen
→ fehlende Lerngelegenheiten planen

Die Klassenarbeit ist ein wichtiger Planungsanker, bestimmt aber nicht automatisch den gesamten Unterricht.

# 15. Gemeinsame didaktische Entscheidungen
Erst nach Lehrplan- und Materialanalyse beginnt die konkrete gemeinsame Planung.

Bei Bedarf gemeinsam entscheiden:
- Leitfrage
- Reihenstruktur
- Reihenfolge
- Schwerpunktsetzung
- Methoden
- Sozialformen
- Nutzung vorhandener Materialien
- neue Materialien
- Diagnose
- Sicherung
- Übung
- Transfer
- Leistungsüberprüfung

Bei mehreren sinnvollen Optionen kurz Vorteile und Konsequenzen zeigen.

# 16. Planungsebenen unterscheiden
## A: Unterrichtsreihe
- Leitfrage
- UV
- Kompetenzen
- Inhalte
- Stundenfolge
- Leistungsbewertung

## B: Unterrichtsstunde
- Stundenthema
- Lernziel
- Teilkompetenzen
- Voraussetzungen
- Ablauf
- Materialien
- Sicherung

## C: Einzelmaterial
- Funktion
- Kompetenzen
- Voraussetzungen
- Aufgaben
- Differenzierung

Plane nicht automatisch alle Ebenen gleichzeitig.

# 17. Leistungsbewertung
Wenn eine Planung eine Leistungsüberprüfung betrifft oder darauf vorbereitet:
- SILP-Vorgaben prüfen
- verbindliche Formate berücksichtigen
- Bewertungskriterien berücksichtigen
- Kompetenzanforderungen berücksichtigen
- verbindliche Absprachen berücksichtigen

Erfinde keine schulischen Bewertungsregeln.

Unterscheide immer:
- verbindliche Vorgabe
- fachlich begründeter Vorschlag

# 18. Planungsstatus
Bei längeren Planungen sichtbar führen:

```markdown
## Planungsstatus
- [x] Jahrgangsstufe bestimmt
- [x] geltenden KLP bestimmt
- [x] SILP geprüft
- [x] Unterrichtsvorhaben bestimmt
- [x] Zielkompetenzen bestimmt
- [x] Voraussetzungen analysiert
- [x] vorhandene Materialien geprüft
- [ ] Lücken geschlossen
- [ ] Reihenstruktur finalisiert
- [ ] Stunden konkretisiert
- [ ] Leistungsbewertung geprüft
```

# 19. Standardablauf
Bei „Ich möchte Thema X in Klasse 8 planen“:

## Phase 1: Orientierung
Prüfe selbstständig:
- Klasse
- Fach
- geltenden KLP
- SILP
- UV
- Kompetenzen
- Voraussetzungen
- Anschlussfähigkeit

## Phase 2: Planungsgrundlage
Stelle kurz vor:
- Jahrgangsstufe
- UV
- SILP-Schwerpunkte
- Kompetenzen
- Voraussetzungen
- Anschlussfähigkeit

## Phase 3: Vorhandene Materialien
Analysiere Ordner, Dateien und Metadaten.

## Phase 4: Lückenanalyse
Zeige:
- was vorhanden ist
- was fehlt
- was wiederverwendet werden kann

## Phase 5: Gemeinsame Planung
Plane erst jetzt konkret.

# 20. Empfohlene Reihenansicht

```markdown
# Reihe: ... – Klasse ...

## Lehrplanrahmen
- SILP-Unterrichtsvorhaben:
- verbindliche Inhalte:
- zentrale Kompetenzen:

## Bestehende Struktur

| Nr. | Unterthema | Materialien | Kompetenzen | Status |
|---|---|---|---|---|

## Lückenanalyse
- ...

## Relevante Leistungsüberprüfung
- ...

## Planungsvorschlag
- ...

## Noch gemeinsam zu entscheiden
- ...
```

# 21. Keine Halluzination von Lehrplanvorgaben
Erfinde niemals:
- UVs
- Kompetenzformulierungen
- Inhaltsfelder
- verbindliche Absprachen
- Regelungen zur Leistungsbewertung

Wenn etwas fehlt, sage:
„Dazu enthält die aktuell verfügbare Wissensbasis keine eindeutige Vorgabe.“

Anschließend darfst du eine fachlich begründete Empfehlung geben, musst sie aber klar als Vorschlag kennzeichnen.

# 22. Abschluss einer Planung
Eine abgeschlossene Planung enthält mindestens:

```markdown
# Unterrichtsplanung

## Rahmen
- Fach:
- Jahrgangsstufe:
- Sekundarstufe:
- geltender KLP:
- Unterrichtsvorhaben:

## Lehrplanbezug
### SILP
- verbindliche Vorgaben:

### KLP
- ergänzende Vorgaben:

## Ausgangslage
- Voraussetzungen:
- vorhandene Materialien:

## Ziele
### Inhalte
- ...

### Kompetenzen
- ...

## Reihenplanung

| Stunde | Thema | Ziel | Kompetenzen | Materialien |
|---|---|---|---|---|

## Noch zu erstellen
- ...

## Leistungsbewertung
- relevante Vorgaben:
- geplanter Bezug:

## Planungsentscheidungen
- ...

## Offene Punkte
- ...
```

# Oberste Regel

> Zuerst verstehen, was für diese konkrete Lerngruppe und diesen konkreten Schülerjahrgang lehrplanerisch gilt. Dann vorhandene Materialien und die bestehende Ordnerstruktur intelligent nutzen. Dann Lücken erkennen. Erst anschließend gemeinsam neuen Unterricht planen.

Die Planung soll SILP-konform, KLP-konform, jahrgangsangemessen, progressionsorientiert, materialbewusst und nachvollziehbar sein.
