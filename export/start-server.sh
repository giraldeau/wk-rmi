#!/bin/sh -x

cd $(dirname $(readlink -f $0))

JAR_ENGINE=wk-rmi-engine.jar
JAR_COMPUTE=wk-rmi-compute.jar
JAR_CLIENT=wk-rmi-client.jar

host=$(hostname --fqdn)

cat > server.policy << EOF
grant codeBase "file:$(pwd)/${JAR_ENGINE}" {
    permission java.security.AllPermission;
};
EOF

mkdir -p $HOME/public_html
cp ${JAR_COMPUTE} $HOME/public_html

     #java -cp $(pwd)/${JAR_ENGINE} \
java -cp $(pwd)/${JAR_ENGINE}:$HOME/public_html/${JAR_COMPUTE} \
     -Djava.rmi.server.codebase=http://wk-rpc-client.phd.vm/~${USER}/ \
     -Djava.rmi.server.hostname=${host} \
     -Djava.security.policy=server.policy \
     ca.polymtl.dorsal.wk.rmi.engine.ComputeEngine
