ARG NATS_LEAFNODE_REGISTRY_VERSION=latest
ARG NATS_SERVER_VERSION=latest
FROM ci4rail/nats-leafnode-registry:$NATS_LEAFNODE_REGISTRY_VERSION as nats-leafnode-registry

FROM nats:$NATS_SERVER_VERSION as nats

FROM alpine:3.15
COPY --from=nats-leafnode-registry /registry /registry
COPY --from=nats /usr/local/bin/nats-server /nats-server

RUN apk add bash inotify-tools nano
COPY cmd/action.sh   /cmd/action.sh
COPY cmd/monitor.sh  /cmd/monitor.sh
COPY cmd/run-nats.sh /cmd/run-nats.sh
COPY cmd/run-leafnode-registry.sh /cmd/run-leafnode-registry.sh

COPY entrypoint.sh   /entrypoint.sh
RUN chmod +x /entrypoint.sh /cmd/action.sh /cmd/monitor.sh /cmd/run-nats.sh /cmd/run-leafnode-registry.sh
RUN mkdir -p /var/run/nats

COPY nats.json /config/nats.json
ENTRYPOINT ["/entrypoint.sh"]
