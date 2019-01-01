#!/usr/bin/env bash


btcd --txindex --simnet --rpcuser=kek --rpcpass=kek &

mkdir /lnd
cd /lnd

# Create folders for each of our nodes
mkdir alice bob charlie

lnd --rpclisten=localhost:10001 --listen=localhost:10011 --restlisten=localhost:8001 --datadir=/lnd/alice/data --logdir=log --debuglevel=info --bitcoin.simnet --bitcoin.active --bitcoin.node=btcd --btcd.rpcuser=kek --btcd.rpcpass=kek &
lnd --rpclisten=localhost:10002 --listen=localhost:10011 --restlisten=localhost:8002 --datadir=/lnd/bob/data --logdir=log --debuglevel=info --bitcoin.simnet --bitcoin.active --bitcoin.node=btcd --btcd.rpcuser=kek --btcd.rpcpass=kek &
lnd --rpclisten=localhost:10003 --listen=localhost:10011 --restlisten=localhost:8003 --datadir=/lnd/charlie/data --logdir=log --debuglevel=info --bitcoin.simnet --bitcoin.active --bitcoin.node=btcd --btcd.rpcuser=kek --btcd.rpcpass=kek &


alias lncli-alice="lncli --rpcserver=localhost:10001 --macaroonpath=data/admin.macaroon"
alias lncli-bob="lncli --rpcserver=localhost:10002 --macaroonpath=data/admin.macaroon"
alias lncli-charlie="lncli --rpcserver=localhost:10003 --macaroonpath=data/admin.macaroon"