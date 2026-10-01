# Changelog

All notable changes to this project are documented here. The format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and the project uses
[Semantic Versioning](https://semver.org/).

## [0.1.0] - 2026-10-01

### Added

- Fixit widget catalog for genui: ResponseStack, SafetyBanner, DiagnosisCard,
  QuestionForm, StepChecklist, PartsList, ProCallout and NoteCard, each with a
  JSON schema, typed model and example payload.
- Response pipeline: parse, assemble, validate against the catalog schemas,
  and repair invalid components into fallback notes instead of dropping them.
- Safety guardrail that guarantees a SafetyBanner and ProCallout for
  electrical, gas and structural jobs, and upgrades understated severities.
- Gemini generator over REST with an API key, and a scripted demo generator
  for three sample problems that runs offline with no setup.
- Jobs saved with drift: history, generated surfaces, submitted answers and
  checklist progress, restored when a job is reopened.
- Photo input from the camera or library, downscaled to 1024px JPEG.
- Material 3 light and dark themes, list-detail layout on tablets, large-text
  support and English ARB strings.
- Unit, widget, golden and integration tests, with an 85% coverage gate on
  `lib/genui` and domain code.
