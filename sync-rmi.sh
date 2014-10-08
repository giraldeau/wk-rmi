#!/bin/sh

DEST="wk-rpc-server.phd.vm wk-rpc-client.phd.vm"

for i in $DEST; do 
	rsync -av ./ ubuntu@$i:~/wk-rmi/
done
