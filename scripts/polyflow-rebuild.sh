#!/usr/bin/env bash
set -euo pipefail

REPO_USER="@githubUser@"
if [ -z "$REPO_USER" ]; then
  echo "[polyflow-rebuild] GitHub user not configured" >&2
  exit 1
fi

if printf '%s' "$REPO_USER" | grep -qE '[[:space:]]'; then
  echo "[polyflow-rebuild] Rejecting GitHub user with whitespace" >&2
  exit 1
fi

ROBOT_ID_ENV="@hostname@"
if [ -z "$ROBOT_ID_ENV" ]; then
  ROBOT_ID_ENV="$(hostname)"
fi

if printf '%s' "$ROBOT_ID_ENV" | grep -qE '[[:space:]]'; then
  echo "[polyflow-rebuild] Rejecting robot id with whitespace" >&2
  exit 1
fi

FLAKE_REF="github:${REPO_USER}/polyflow_robot_${ROBOT_ID_ENV}#rpi4"

exec nixos-rebuild switch --flake "$FLAKE_REF" --refresh
