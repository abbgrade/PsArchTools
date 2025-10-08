# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed

- Updated PsMermaidTools to 0.7.0.
- Escaping within nodes is now handles by PsMermaidTools.

### Added

- Added `Remove-DataLayer` command.

## [0.6.2] - 2025-01-17

### Fixed

- Updated PsMermaidTools, to fix escaping for special characters.

## [0.6.1] - 2025-01-17

### Fixed

- Updated PsMermaidTools, to add escaping for special characters.

## [0.6.0] - 2025-01-15

### Added

- Added description property to data journey models.

## [0.5.0] - 2025-01-14

### Added

- Added description property to data journey flows.

## [0.4.1] - 2024-11-28

### Fixed

- `Select-DataJourney` failed when selecting models by key instead of title.

## [0.4.0] - 2024-11-19

### Added

- `Export-DataJourney` and `Import-DataJourney` now support directory structure additional to single files.
- `Add-DataFlow`, `Add-DataLayer` and `Add-DataModel` now support input objects.

### Changed

- Changed shape of a flow to subroutine.

## Fixed

- Ignored model key while diagram creation.

## [0.3.0] - 2024-11-12

### Added

- new command `Add-FeatureState` for feature styling by state.

### Fixed

- added feature name escaping.

### Changed

- replaced `powershell-yaml` by `Yayaml`.

## [0.2.0] - 2023-10-19

### Added

- new command `Export-DataJourney`.
- new command `Import-DataJourney`.
- new command `New-DataFlow`.
- new command `New-DataJourney`.
- new command `New-DataLayer`.
- new command `New-DataModel`.
- new command `Select-DataJourney`.
- new command `Set-DataJourney`.

## [0.1.0] - 2023-09-14

### Added

- new command `New-Roadmap`.
- new command `Add-Feature`.
- new command `Add-Milestone`.
- new command `ConvertTo-Diagram`.

<!-- markdownlint-configure-file {"MD024": { "siblings_only": true } } -->