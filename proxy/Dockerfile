FROM docker.io/caddy:2.10.2-alpine@sha256:d8c17a862962def15cde69863a3a463f25a2664942eafd7bdbf050e9c3116b83

COPY Caddyfile /etc/caddy/Caddyfile
COPY entrypoint.sh /usr/local/bin/kroki-proxy-entrypoint
RUN chmod +x /usr/local/bin/kroki-proxy-entrypoint
EXPOSE 8080
ENTRYPOINT ["/usr/local/bin/kroki-proxy-entrypoint"]
