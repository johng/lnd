#!/usr/bin/env bash

btcd --txindex --simnet --rpcuser=kek --rpcpass=kek --rpclisten=127.0.0.1:8334 &

sleep 2

mkdir -p /data/alice /data/bob /data/charlie

lnd --rpclisten=localhost:10001 --listen=localhost:10011 \
    --restlisten=localhost:8001 --datadir=data/alice \
    --logdir=log --debuglevel=info \
    --bitcoin.simnet --bitcoin.active \
    --bitcoin.node=btcd --btcd.rpcuser=kek \
    --btcd.rpcpass=kek --btcd.rpchost=127.0.0.1:8334 \
    --noseedbackup &

sleep 10

addressJson=$(lncli --rpcserver=localhost:10001 --macaroonpath=/data/alice/chain/bitcoin/simnet/admin.macaroon newaddress p2wkh)

address=`echo $addressJson | python -c 'import json,sys;obj=json.load(sys.stdin);print(obj["address"])'`
echo $address