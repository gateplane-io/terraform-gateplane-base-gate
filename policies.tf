# Copyright (C) 2025 Ioannis Torakis <john.torakis@gmail.com>
# SPDX-License-Identifier: Elastic-2.0
#
# Licensed under the Elastic License 2.0.
# You may obtain a copy of the license at:
# https://www.elastic.co/licensing/elastic-license
#
# Use, modification, and redistribution permitted under the terms of the license,
# except for providing this software as a commercial service or product.

# Policy for the "user"
resource "vault_policy" "user" {
  name   = "${local.policy_prefix}-requestor"
  policy = <<EOF
// Capabilities to allow
// requesting and claiming access
path "${local.plugin_paths["request"]}" {
  capabilities = ["read", "update"]
}

path "${local.plugin_paths["claim"]}" {
  capabilities = ["read", "update"]
}

// Capabilities to allow reading
// access provided through this Gate
path "${local.plugin_paths["config"]}*" {
  capabilities = ["read"]
}
EOF
}

# Policy for the "gatekeeper"
resource "vault_policy" "gtkpr" {
  name   = "${local.policy_prefix}-approver"
  policy = <<EOF
// Capabilities to allow
// listing and approving requests
path "${local.plugin_paths["request"]}" {
  capabilities = ["list"]
}

// base-0.3.2 approve endpoint
path "${local.plugin_paths["approve"]}" {
  capabilities = ["update"]
}

// base-0.4.0+ approve endpoint
path "${local.plugin_paths["approve"]}/*" {
  capabilities = ["update", "list"]
}

// Capabilities to allow reading
// access provided through this Gate
path "${local.plugin_paths["config"]}*" {
  capabilities = ["read"]
}
EOF
}
