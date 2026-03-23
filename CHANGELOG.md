# Changelog

## [0.2.1] - 2026-03-22

### Changed
- Add legion-* sub-gems as runtime dependencies (legion-logging, legion-settings, legion-json, legion-cache, legion-crypt, legion-data, legion-transport)
- Update spec_helper with real sub-gem helper stubs

## [0.2.0] - 2026-03-15

### Added
- `Helpers::Client` module for building Faraday connections to Elasticsearch
- `Runners::Indices` with list_indices, create_index, delete_index, index_exists?, get_index
- `Runners::Documents` with index_document, get_document, delete_document, update_document
- `Runners::Search` with search and count
- Standalone `Client` class including all runner modules

### Changed
- Replaced `elasticsearch` gem dependency with `faraday` (>= 2.0) for consistency with other LEXs

## [0.1.0] - 2026-03-13

### Added
- Initial release
