# Vault/OpenBao Base Gate Configuration (dependency)
![License: ElasticV2](https://img.shields.io/badge/ElasticV2-green?style=flat-square&label=license&cacheSeconds=3600&link=https%3A%2F%2Fwww.elastic.co%2Flicensing%2Felastic-license)

This Terraform module is not to be used directly.

It is used by all Terraform modules in this organization, that configure Gates,
such as [`terraform-gateplane-policy-gate`](https://github.com/gateplane-io/terraform-gateplane-policy-gate).

## What it does

* It mounts each plugin (registered using [`terraform-gateplane-setup`](https://github.com/gateplane-io/terraform-gateplane-setup))
under a designated path

* It configures parameters, such as `lease` and `required_approvals`, that remain unchanged in all GatePlane plugins.

* It creates two Vault/OpenBao Policies, one for creating and one for approving AccessRequests.

## Resource Naming

### Mount Path
The variables `endpoint_prefix`, `name` and `path_prefix` are used to establish the mountpoint of the plugin as below:
```
<path_prefix>/?<endpoint_prefix>-<name>
```
This value is returned by the `mount_path` output, and can be used to construct additional policies.

### Policy Names
The naming of the two default policies created using the `policy_prefix` and `name` variables, as below:
```
<policy_prefix>-?<name>-[requestor|approver]
```
The names are returned by the `policy_names` map variable (keys: "requestor", "approver"),
and can be directly attached to Vault/OpenBao Entities, Groups and Auth Methods.

##### If a `*_prefix` variable is empty (i.e: `""`), the following `/` or `-` is not produced (as shown by the RegEx-like `?`).

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |
| <a name="requirement_null"></a> [null](#requirement\_null) | 3.2.4 |
| <a name="requirement_vault"></a> [vault](#requirement\_vault) | 4.7.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_null"></a> [null](#provider\_null) | 3.2.4 |
| <a name="provider_vault"></a> [vault](#provider\_vault) | 4.7.0 |

## Resources

| Name | Type |
|------|------|
| [null_resource.reconfigure](https://registry.terraform.io/providers/hashicorp/null/3.2.4/docs/resources/resource) | resource |
| [vault_generic_endpoint.plugin_config](https://registry.terraform.io/providers/hashicorp/vault/4.7.0/docs/resources/generic_endpoint) | resource |
| [vault_generic_endpoint.plugin_lease](https://registry.terraform.io/providers/hashicorp/vault/4.7.0/docs/resources/generic_endpoint) | resource |
| [vault_mount.this](https://registry.terraform.io/providers/hashicorp/vault/4.7.0/docs/resources/mount) | resource |
| [vault_policy.gtkpr](https://registry.terraform.io/providers/hashicorp/vault/4.7.0/docs/resources/policy) | resource |
| [vault_policy.user](https://registry.terraform.io/providers/hashicorp/vault/4.7.0/docs/resources/policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Name of the gate, used in the mount path and generated policies. | `any` | n/a | yes |
| <a name="input_plugin_name"></a> [plugin\_name](#input\_plugin\_name) | The name of the plugin to mount (e.g: `gateplane-policy-gate`). | `any` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | Brief explanation of what access is requested through this gate. | `string` | `""` | no |
| <a name="input_endpoint_prefix"></a> [endpoint\_prefix](#input\_endpoint\_prefix) | n/a | `string` | `"gp"` | no |
| <a name="input_lease_max_ttl"></a> [lease\_max\_ttl](#input\_lease\_max\_ttl) | The duration that the protected token will be active (e.g.: "`1h`"). | `string` | `"1h"` | no |
| <a name="input_lease_ttl"></a> [lease\_ttl](#input\_lease\_ttl) | The duration that the protected token will be active (e.g.: "`1h`"). | `string` | `"30m"` | no |
| <a name="input_path_prefix"></a> [path\_prefix](#input\_path\_prefix) | The endpoint where the plugin will be mounted. | `string` | `"gateplane"` | no |
| <a name="input_plugin_options"></a> [plugin\_options](#input\_plugin\_options) | Base options provided by the plugin to the `/config` endpoint, available [in plugin documentation](https://github.com/gateplane-io/vault-plugins). | `map` | `{}` | no |
| <a name="input_policy_prefix"></a> [policy\_prefix](#input\_policy\_prefix) | n/a | `string` | `"gateplane"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_mount_path"></a> [mount\_path](#output\_mount\_path) | The Vault/OpenBao path where the plugin has been mounted. |
| <a name="output_paths"></a> [paths](#output\_paths) | The map of paths supported by this plugin. |
| <a name="output_policies"></a> [policies](#output\_policies) | The verbatim policies created and referenced in this module. |
| <a name="output_policy_names"></a> [policy\_names](#output\_policy\_names) | The names of the policies created and referenced in this module. |


## License

This project is licensed under the [Elastic License v2](https://www.elastic.co/licensing/elastic-license).

This means:

- ✅ You can use, fork, and modify it for **yourself** or **within your company**.
- ✅ You can submit pull requests and redistribute modified versions (with the license attached).
- ❌ You may **not** sell it, offer it as a paid product, or use it in a hosted service (e.g., SaaS).
- ❌ You may **not** re-license it under a different license.

In short: You can use and extend the code freely, privately or inside your business - just don’t build a business around it without our permission.
[This FAQ by Elastic](https://www.elastic.co/licensing/elastic-license/faq) greatly summarizes things.

See the [`./LICENSES/Elastic-2.0.txt`](./LICENSES/Elastic-2.0.txt) file for full details.
