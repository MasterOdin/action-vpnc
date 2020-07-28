FROM debian:buster-slim

COPY entrypoint.sh /entrypoint.sh

RUN apt-get update \
    && apt-get install -y vpnc \
    && chmod +x /entrypoint.sh \
    && mkdir -p /etc/service/vpnc \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


ENTRYPOINT ["/entrypoint.sh"]
