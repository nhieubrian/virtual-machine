FROM gitlab-registry.nautilus.optiputer.net/prp/docker-nvidia-egl-desktop-18.04:latest

USER root

RUN curl https://bootstrap.pypa.io/pip/2.7/get-pip.py  --output get-pip.py && \
    python2 get-pip.py

RUN apt-get update && apt-get install -y --no-install-recommends \
    python3-venv \
    python3-pip \
    python3-setuptools
    
COPY bootstrap.sh /bootstrap.sh
RUN chmod 755 /bootstrap.sh

WORKDIR /isaac
RUN wget -q https://nextcloud.nautilus.optiputer.net/s/HtBcCw6MTNfM4Ci/download -O isaac-sdk-20201201-427971df2.tar.xz && \
    tar -xf isaac-sdk-20201201-427971df2.tar.xz && chown -R user:user /isaac

USER user 
WORKDIR /isaac/engine
ARG DEBIAN_FRONTEND=noninteractive
RUN ./engine/build/scripts/install_dependencies.sh

WORKDIR /home/user
