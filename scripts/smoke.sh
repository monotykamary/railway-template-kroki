#!/bin/sh
set -eu
: "${BASE_URL:?Set BASE_URL}"
: "${BASIC_AUTH_USER:?Set BASIC_AUTH_USER}"
: "${BASIC_AUTH_PASSWORD:?Set BASIC_AUTH_PASSWORD}"
base=${BASE_URL%/}
health=$(curl -fsS "$base/healthz")
printf '%s' "$health" | grep -q '"status":"pass"'
printf '%s' "$health" | grep -q '"number":"0.33.0"'
unauth=$(curl -sS -o /dev/null -w '%{http_code}' -H 'Content-Type: application/json' --data '{"diagram_source":"digraph G {a -> b}","diagram_type":"graphviz","output_format":"svg"}' "$base/")
[ "$unauth" = "401" ]
svg=$(curl -fsS --user "$BASIC_AUTH_USER:$BASIC_AUTH_PASSWORD" -H 'Content-Type: application/json' --data '{"diagram_source":"digraph G {a -> b}","diagram_type":"graphviz","output_format":"svg"}' "$base/")
printf '%s' "$svg" | grep -q '<svg'
printf '%s' "$svg" | grep -q '>a<'
bad=$(curl -sS -o /dev/null -w '%{http_code}' --user "$BASIC_AUTH_USER:$BASIC_AUTH_PASSWORD" -H 'Content-Type: application/json' --data '{"diagram_source":"x","diagram_type":"not-a-renderer","output_format":"svg"}' "$base/")
[ "$bad" = "400" ]
vega_ssrf=$(curl -sS -o /dev/null -w '%{http_code}' --user "$BASIC_AUTH_USER:$BASIC_AUTH_PASSWORD" -H 'Content-Type: application/json' --data '{"diagram_source":"{\"marks\":[{\"type\":\"group\",\"marks\":[{\"type\":\"image\",\"encode\":{\"enter\":{\"url\":{\"value\":\"file:///etc/passwd\"}}}}]}]}","diagram_type":"vega","output_format":"svg"}' "$base/")
[ "$vega_ssrf" = "400" ]
optional=$(curl -sS -o /dev/null -w '%{http_code}' --user "$BASIC_AUTH_USER:$BASIC_AUTH_PASSWORD" -H 'Content-Type: application/json' --data '{"diagram_source":"graph TD; A-->B","diagram_type":"mermaid","output_format":"svg"}' "$base/")
[ "$optional" = "503" ]
printf '%s\n' 'Kroki smoke checks passed'
