# Copyright (C) 2025 Ioannis Torakis <john.torakis@gmail.com>
# SPDX-License-Identifier: Elastic-2.0
#
# Licensed under the Elastic License 2.0.
# You may obtain a copy of the license at:
# https://www.elastic.co/licensing/elastic-license
#
# Use, modification, and redistribution permitted under the terms of the license,
# except for providing this software as a commercial service or product.

variable "name" {
  description = "Name of the gate, used in the mount path and generated policies."
}

variable "description" {
  description = "Brief explanation of what access is requested through this gate."
  default     = ""
}

variable "policy_prefix" {
  default = "gateplane"
}

variable "endpoint_prefix" {
  default = "gp"
}

variable "path_prefix" {
  description = "The endpoint where the plugin will be mounted."
  default     = "gateplane"
}

variable "lease_ttl" {
  description = "The duration that the protected token will be active (e.g.: \"`1h`\")."
  default     = "30m"
}

variable "lease_max_ttl" {
  description = "The duration that the protected token will be active (e.g.: \"`1h`\")."
  default     = "1h"
}

variable "plugin_options" {
  description = "Base options provided by the plugin to the `/config` endpoint, available [in plugin documentation](https://github.com/gateplane-io/vault-plugins)."
  default     = {}
}

variable "plugin_name" {
  description = "The name of the plugin to mount (e.g: `gateplane-policy-gate`)."
}
