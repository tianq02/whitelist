#!/bin/bash

# 使用方法: ./convert.sh input.txt [output.csv] [tag] [custom.csv]

INPUT_FILE="${1:-eo98.txt}"
OUTPUT_FILE="${2:-firewall_rules.csv}"
TAG="${3:-EO}"
CUSTOM_FILE="${4:-custom.csv}"

if [ -f "$CUSTOM_FILE" ]; then
    awk 'BEGIN { ORS = "\r\n" } { sub(/\r?$/, ""); print }' "$CUSTOM_FILE" > "$OUTPUT_FILE"
else
    printf '%s\r\n' "来源,协议,端口,策略,备注" > "$OUTPUT_FILE"
fi

awk -v tag="$TAG" 'BEGIN { ORS = "\r\n" }
  /^[[:space:]]*($|#)/ { next }
  { gsub(/^[[:space:]]+|[[:space:]]+$/, "", $0) }
  $0 != "" {
    print $0, "TCP", "443", "允许", tag
  }
' FS= OFS=, "$INPUT_FILE" >> "$OUTPUT_FILE"

echo "输出文件: $OUTPUT_FILE"
