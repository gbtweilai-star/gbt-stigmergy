#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
PYTHONPATH=src python -m gbt_stigmergy info
PYTHONPATH=src python -m gbt_stigmergy check --payload '{}'
PYTHONPATH=src python -m gbt_stigmergy run   --payload '{}'
