# Changelog — erupe

## [0.1.1] - 2026-04-29

### Fixed
- Remove duplicate `readOnly` field in init container volumeMounts (deployment.yaml)
- Update init container image and refactor secret handling

---

## [0.1.0] - 2026-04-28

### Added
- Initial release of erupe chart
- Single-deployment chart for Erupe (MHF server) with all servers in one Pod
- ConfigMap for configuration with secret injection via init container
- Service exposure for game server
- Support for custom values: replicas, image, resources, probes, security contexts, etc.

