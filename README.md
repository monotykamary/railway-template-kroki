# Kroki on Railway

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/deploy/kroki-secure?referralCode=ZqgrJ0)

Deploy Kroki 0.32.0 behind generated HTTP Basic authentication for on-demand diagram rendering.

The Deploy on Railway button is added after the published route is verified.

## What this deploys

- Private Kroki gateway `0.32.0`, pinned to its official Linux/AMD64 image digest
- Public Caddy `2.10.2-alpine` proxy, pinned by digest
- Generated HTTP Basic credentials
- Upstream-backed `/healthz` readiness and a 2 MB source request limit

## Supported diagram scope

The core Kroki image includes PlantUML, GraphViz, Ditaa, Vega, Vega-Lite, WaveDrom, C4PlantUML, Structurizr, BlockDiag-family tools, and other embedded renderers. This intentionally minimal topology does not deploy the optional Mermaid, BPMN, Excalidraw, or diagrams.net companion services. Requests for those external backends will not work until you add and wire the corresponding services.

## Usage

Read `BASIC_AUTH_USER` and `BASIC_AUTH_PASSWORD` from the proxy service variables, then render a diagram:

```bash
curl --user "$BASIC_AUTH_USER:$BASIC_AUTH_PASSWORD" \
  --header 'Content-Type: application/json' \
  --data '{"diagram_source":"digraph G { a -> b }","diagram_type":"graphviz","output_format":"svg"}' \
  https://your-domain.example/
```

The public proxy limits source request bodies to 2 MB. Rendered diagrams are returned directly and are not persisted.

## Security

Rendering is compute-intensive and parser bugs may be reachable through untrusted diagram source. Authentication is enabled to reduce anonymous abuse; rotate credentials if disclosed and keep the pinned release current. Do not remove authentication from an unrestricted public endpoint casually.

## Updating

Update both image tags and digests, read Kroki and Caddy release notes, then repeat authentication, health, SVG/PNG rendering, malformed-input, concurrency, memory, and redeploy soak tests.

## Validation

```bash
npm test
BASE_URL=https://your-domain.example BASIC_AUTH_USER=kroki BASIC_AUTH_PASSWORD=... ./scripts/smoke.sh
```

## Upstream

- Source: https://github.com/yuzutech/kroki/tree/v0.32.0
- Release: https://github.com/yuzutech/kroki/releases/tag/v0.32.0
- Documentation: https://docs.kroki.io/kroki/
- License: MIT

This repository contains Railway adapters and documentation. Kroki remains copyright its upstream contributors and is not affiliated with Railway.
