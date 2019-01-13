FROM golang:1.11-alpine as builder

MAINTAINER Olaoluwa Osuntokun <lightning.engineering>

# Install dependencies and install/build lnd.
RUN apk add --no-cache --update alpine-sdk \
    git \
    make \
    gcc

# Copy in the local repository to build from.
COPY . /lnd

WORKDIR /lnd

# Force Go to use the cgo based DNS resolver. This is required to ensure DNS
# queries required to connect to linked containers succeed.
ENV GODEBUG netdns=cgo

RUN make && make install

FROM lightningnetwork/btcd-alpine as btcd

FROM alpine as final
RUN apk add --no-cache --update alpine-sdk \
    git \
    make \
    bash


COPY --from=builder /go/bin/lnd /bin/
COPY --from=builder /go/bin/lncli /bin/
COPY --from=btcd /bin/btcctl /bin/
COPY --from=btcd /bin/btcd /bin/



