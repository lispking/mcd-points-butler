#!/usr/bin/env bash
# 打包 mcd-points-butler 专家包（zip 内以同名文件夹为根）
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
NAME="mcd-points-butler"
OUT="$ROOT/expert/$NAME.zip"

command -v zip >/dev/null || { echo "需要 zip 命令"; exit 1; }

# 若启用内置 MCP，先将 .mcp.json.optional 复制为 .mcp.json（打包后删除，不污染源目录）
OPT="$ROOT/expert/$NAME/.mcp.json.optional"
TMP=""
if [[ -f "$OPT" ]]; then
  TMP="$ROOT/expert/$NAME/.mcp.json"
  cp "$OPT" "$TMP"
fi
trap '[[ -n "$TMP" ]] && rm -f "$TMP"' EXIT

( cd "$ROOT/expert" && zip -rq "$OUT" "$NAME" \
    -x '*.DS_Store' \
    -x "$NAME/.mcp.json.optional" \
    -x "$NAME.zip" )

echo "已生成: $OUT"
unzip -l "$OUT"
