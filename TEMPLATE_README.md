# Deploy and Host Kroki on Railway

## About Hosting Kroki

Kroki provides a unified HTTP API that turns text descriptions into SVG, PNG, PDF, and other diagram formats. This template deploys stable Kroki 0.33.0 privately behind an authenticated Caddy proxy.

Retrieve `BASIC_AUTH_USER` and the generated `BASIC_AUTH_PASSWORD` from the proxy service before calling rendering endpoints. Kroki 0.33.0 includes the secure-mode fix for nested Vega URL SSRF and local-file reads.

## Common Use Cases

- Render architecture and dependency diagrams in documentation pipelines
- Generate GraphViz, PlantUML, Ditaa, Vega, and WaveDrom assets
- Provide a private diagram API for CI and internal tools

## Dependencies for Kroki Hosting

### Deployment Dependencies

- Private Kroki gateway service
- Public Caddy authentication proxy
- No database or persistent volume

### Implementation Details

Railway HTTPS routes to Caddy on port 8080. Caddy enforces generated HTTP Basic credentials, limits source bodies to 2 MB, and forwards requests over Railway private networking to Kroki on port 8000. `/healthz` checks Kroki's own `/health` response.

This minimal deployment includes only renderers bundled into the core Kroki image. Optional Mermaid, BPMN, Excalidraw, and diagrams.net companion services are deliberately excluded rather than pretending those formats work.

## Why Deploy Kroki on Railway?

Railway provides managed HTTPS, generated credentials, private networking, health checks, and reproducible deployment for a stateless diagram-rendering API.
