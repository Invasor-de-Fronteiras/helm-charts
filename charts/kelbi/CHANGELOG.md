# Changelog — kelbi

## [3.2.0] - 2026-04-28

### Added
- `extraChannels` map support: define any number of additional channel servers via `extraChannels.<key>` in values
- Each enabled entry generates a dedicated ConfigMap, Deployment, and LoadBalancer Service with K8s resource names derived from the map key (e.g. `kelbi-erupe-beta`)
- Enabled channels are automatically injected as entries in the Entrance Server's `config.json`
- helm-unittest test suite covering all new templates (27 tests across 4 suites)

---

## [3.1.7] - previous

See git log for prior history.
