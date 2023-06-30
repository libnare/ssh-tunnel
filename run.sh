#!/bin/sh

if [ -z ${REMOTE_SERVER_IP+x} ]; then
    REMOTE_SERVER_IP="127.0.0.1"
fi

if  [ -z ${SSH_PORT+x} ] ; then
    SSH_PORT="22"
fi

if [ -z ${LOCAL_PORT+x} ] || [ -z ${REMOTE_PORT+x} ] || [ -z ${SSH_BASTION_HOST+x} ] || [ -z ${SSH_USER+x} ] || [ -z ${SSH_KEY_PATH+x} ] ; then
    echo "Some vars are not set"; 
    exit 1
fi

echo "starting SSH proxy $LOCAL_PORT:$REMOTE_SERVER_IP:$REMOTE_PORT on $SSH_USER@$SSH_BASTION_HOST:$SSH_PORT"

/usr/bin/ssh \
-NTC -o ServerAliveInterval=60 \
-o GatewayPorts=true \
-o ExitOnForwardFailure=yes \
-o StrictHostKeyChecking=no \
-L $LOCAL_PORT:$REMOTE_SERVER_IP:$REMOTE_PORT \
$SSH_USER@$SSH_BASTION_HOST \
-p $SSH_PORT \
-i $SSH_KEY_PATH