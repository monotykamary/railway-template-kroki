FROM docker.io/caddy:2.11.9-alpine@sha256:003a97808e781aa9f7e75cc2f43d34d461099031faf5e20faefb9f61126836f0

COPY Caddyfile /etc/caddy/Caddyfile
COPY entrypoint.sh /usr/local/bin/kroki-proxy-entrypoint
RUN chmod +x /usr/local/bin/kroki-proxy-entrypoint
EXPOSE 8080
ENTRYPOINT ["/usr/local/bin/kroki-proxy-entrypoint"]
