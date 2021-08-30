# Minimal Docker image for VG-Flow using Debian minimal base
FROM debian:10.10-slim
MAINTAINER Niema Moshiri <niemamoshiri@gmail.com>

# install VG-Flow
RUN echo "deb [ arch=amd64 ] https://downloads.skewed.de/apt buster main" >> /etc/apt/sources.list && \
    apt-key adv --keyserver keys.openpgp.org --recv-key 612DEFB798507F25 && \
    apt-get update && apt-get upgrade && \
    apt-get install -y biopython python3 python3-graph-tool python3-pip wget && \
    pip3 install --no-cache-dir graph-tool gurobipy numpy && \
    wget -qO- "https://bitbucket.org/jbaaijens/vg-flow/get/v0.0.4.tar.gz" | tar -zx && \
    mv jbaaijens-vg-flow-* /usr/local/bin/vg-flow && \
    chmod a+x /usr/local/bin/vg-flow/scripts/*.py && \
    for f in /usr/local/bin/vg-flow/scripts/*.py ; do ln -s $f /usr/local/bin/$(echo $f | rev | cut -d'/' -f1 | rev) ; done
