FROM lightningnetwork/btcd-alpine as btcd

FROM lnd as lnd

FROM alpine as final

RUN apk add --no-cache --update alpine-sdk \
    git \
    make \
    bash \
    python \
    iproute2

COPY --from=lnd /bin/lnd /bin/
COPY --from=lnd /bin/lncli /bin/
COPY --from=btcd /bin/btcctl /bin/
COPY --from=btcd /bin/btcd /bin/

COPY ./run.sh /run.sh

ENTRYPOINT /run.sh