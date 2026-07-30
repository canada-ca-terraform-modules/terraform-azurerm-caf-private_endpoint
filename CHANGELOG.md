# Changelog

All notable changes to this module will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.2.0] - 2026-07-29

### Changed

- Bumped `required_providers` azurerm constraint from `~> 4.0` to `~> 5.0`
- Bumped `actions/checkout` GitHub Actions version from `v6.0.2` to `v7.0.1`
- Bumped `hashicorp/setup-terraform` GitHub Actions version from `v4.0.0` to `v4.0.1`
- Updated ESLZ module `source` ref from `v1.1.0` to `v1.2.0`

### Fixed

- `.gitignore`: added `*.tfvars` ignore rule above `!ESLZ/*.tfvars` — the negation was previously a no-op with no prior `*.tfvars` pattern, meaning root-level tfvars files were not protected from accidental commit

### Notes

- `azurerm_private_endpoint` has no breaking changes in azurerm v5.0. All existing tfvars and module block arguments continue to work unchanged.
- Provider-level change in v5: `resource_provider_registrations` now defaults to `none` instead of `legacy`. Callers that relied on automatic RP registration should explicitly set `resource_provider_registrations = "legacy"` or register `Microsoft.Network` in their provider block.

## [1.1.0] - 2026-03-27

### Added

- `custom_network_interface_name` support (from `private_endpoint` object or top-level variable)
- `ip_configuration` dynamic block for static IP address assignment
- `private_connection_resource_alias` support for Private Link Service alias connections
- `request_message` for manual connection approval flows
- `providers.tf` with `required_providers` pinned to `~> 4.0`
- `.tflint.hcl` with `call_module_type = "local"`
- `.gitignore` and `.gitattributes`
- GitHub Actions CI (`terraform-ci.yml`) and documentation (`documentation.yml`) workflows
- `tests/private_endpoint.tftest.hcl` and `tests/upgrade_compat.tftest.hcl`

### Fixed

- Invalid regex escape `[^\\/]+` → `[^/]+` in `locals.tf`
- Output `name` was returning the full resource object instead of `.name`
- Full resource object outputs missing `sensitive = true`

## [1.0.2] - prior

### Changed

- Removed `tags` from `ignore_changes` lifecycle block

## [1.0.1] - prior

### Fixed

- Added `try()` around private DNS zone locals to handle omitted values

## [1.0.0] - prior

### Added

- Initial release with private endpoint, private DNS zone group, and private service connection support
- Support for resource group and subnet provided as name or full ARM ID
