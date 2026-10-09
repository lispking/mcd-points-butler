#!/usr/bin/env bash
# 打包 mcd-points-butler 专家包（zip 内以同名文件夹为根）
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
NAME="mcd-points-butler"
OUT="$ROOT/expert/$NAME.zip"

command -v zip >/dev/null || { echo "需要 zip 命令"; exit 1; }

# 内置 MCP 声明随包启用：将 .mcp.json.optional 复制为 .mcp.json（打包后由 trap 删除，不污染源目录）
# 如需发布纯手动配置版，让包内不生成 .mcp.json 即可（跳过下面这一步）
OPT="$ROOT/expert/$NAME/.mcp.json.optional"
TMP=""
if [[ -f "$OPT" ]]; then
  TMP="$ROOT/expert/$NAME/.mcp.json"
  cp "$OPT" "$TMP"
fi
trap '[[ -n "$TMP" ]] && rm -f "$TMP"' EXIT

rm -f "$OUT"
( cd "$ROOT/expert" && zip -rq "$OUT" "$NAME" \
    -x '*.DS_Store' \
    -x "$NAME/.mcp.json.optional" )

echo "已生成: $OUT"
unzip -l "$OUT"
