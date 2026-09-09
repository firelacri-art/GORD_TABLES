#!/usr/bin/env bash
# Установка навыка gord-tables без плагина: копирует папку навыка в ~/.claude/skills
# (по умолчанию) или в .claude/skills текущего проекта (--project).
set -euo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
if [[ "${1:-}" == "--project" ]]; then DEST="$(pwd)/.claude/skills"; else DEST="$HOME/.claude/skills"; fi
mkdir -p "$DEST"
rm -rf "$DEST/gord-tables"
cp -R "$HERE/skills/gord-tables" "$DEST/gord-tables"
echo "Навык установлен: $DEST/gord-tables"
echo "Зависимости: pip install openpyxl Pillow"
