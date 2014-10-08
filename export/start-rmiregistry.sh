#!/bin/sh -x
DIR=$(dirname $(readlink -f $0))

CLASSPATH=$DIR/wk-rmi-compute.jar rmiregistry
