# Changelog

All notable changes to the AhaKey protocol documentation repository will be documented in this file.

This changelog is for **documentation and public protocol definition changes**, not for every internal firmware change.

---

## Unreleased

### Added
- Initial public repository structure
- Repository README
- Protocol overview
- Protocol stability policy
- BLE services and characteristics document
- Events and states document
- Commands document
- Public vs internal boundary document
- Examples directory README
- Minimal client flow example

### Notes
- The current protocol documentation is based on existing code inspection and public behavior extraction.
- Some field-level details are still marked as “to be confirmed”.
- Stable / Experimental / Internal boundaries are intentionally documented early to avoid over-promising firmware internals.

### Current public protocol focus
- Custom service `0x7340`
- Command path on `0x7343`
- Notify / response path on `0x7344`
- Bulk payload path on `0x7341` as experimental
- Stable command focus on `0x00`, `0x04`, `0x73`, `0x83`, `0x90`

---

## Future guidance

When updating this changelog in the future, try to record:

- what public protocol behavior changed
- whether the change affects Stable / Experimental / Internal areas
- whether compatibility is preserved
- whether third-party clients need to update
