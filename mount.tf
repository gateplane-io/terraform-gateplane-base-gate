# Copyright (C) 2025 Ioannis Torakis <john.torakis@gmail.com>
# SPDX-License-Identifier: Elastic-2.0
#
# Licensed under the Elastic License 2.0.
# You may obtain a copy of the license at:
# https://www.elastic.co/licensing/elastic-license
#
# Use, modification, and redistribution permitted under the terms of the license,
# except for providing this software as a commercial service or product.

resource "vault_mount" "this" {
  type        = var.plugin_name
  path        = local.plugin_paths_mount
  description = var.description
}

resource "vault_generic_endpoint" "plugin_config" {
  depends_on = [vault_mount.this]

  path                 = local.plugin_paths["config"]
  disable_delete       = true
  ignore_absent_fields = true

  data_json = jsonencode(var.plugin_options)
}

resource "vault_generic_endpoint" "plugin_lease" {
  depends_on = [vault_mount.this]

  path                 = local.plugin_paths["lease"]
  disable_delete       = true
  ignore_absent_fields = true

  data_json = jsonencode({
    lease     = var.lease_ttl,
    lease_max = var.lease_max_ttl,
  })
}
