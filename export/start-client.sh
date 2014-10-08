#!/bin/sh -x

cd $(dirname $(readlink -f $0))

JAR_CLIENT=wk-rmi-client.jar
JAR_COMPUTE=wk-rmi-compute.jar

host=$(hostname --fqdn)

#grant codeBase "file:/home/francis/workspace-java/wk-rmi/bin/" {
cat > client.policy << EOF
grant codeBase "file:$(pwd)/${JAR_CLIENT}" {
    permission java.security.AllPermission;
};
EOF

# FIXME: unzip content of jar to the webserver

mkdir -p $HOME/public_html
cp ${JAR_COMPUTE} $HOME/public_html

     #-Djava.rmi.server.codebase=http://berta.dorsal.polymtl.ca/~${USER}/ \
     #-Djava.rmi.server.codebase=http://berta.dorsal.polymtl.ca/~${USER}/${JAR_CLIENT} \
java -cp $(pwd)/${JAR_CLIENT}:$HOME/public_html/${JAR_COMPUTE} \
     -Djava.rmi.server.codebase=http://${host}/~${USER}/ \
     -Djava.rmi.server.hostname=${host} \
     -Djava.security.policy=client.policy \
     ca.polymtl.dorsal.wk.rmi.client.ComputePi wk-rpc-server.phd.vm 5
