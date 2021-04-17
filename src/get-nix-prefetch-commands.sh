#!/usr/bin/env bash
set -eu
jq --arg name_prefix "$NAME_PREFIX-" --raw-output -f "$SCRIPT_DIR/get-fetchcipd-prefetch-commands.jq" "$REV_INFO_FILE"
jq --arg name_prefix "$NAME_PREFIX-" --raw-output -f "$SCRIPT_DIR/get-fetchgit-prefetch-commands.jq" "$REV_INFO_FILE"
