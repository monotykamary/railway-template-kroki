FROM docker.io/caddy:2.11.4-alpine@sha256:5f5c8640aae01df9654968d946d8f1a56c497f1dd5c5cda4cf95ab7c14d58648

COPY Caddyfile /etc/caddy/Caddyfile
COPY entrypoint.sh /usr/local/bin/kroki-proxy-entrypoint
RUN chmod +x /usr/local/bin/kroki-proxy-entrypoint
EXPOSE 8080
ENTRYPOINT ["/usr/local/bin/kroki-proxy-entrypoint"]
