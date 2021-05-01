FROM gitlab-registry.nautilus.optiputer.net/prp/docker-nvidia-egl-desktop-18.04:latest

USER root

#RUN curl https://bootstrap.pypa.io/pip/2.7/get-pip.py  --output get-pip.py && python2 get-pip.py

RUN apt-get update && apt-get install -y --no-install-recommends \
    python3-venv \
    python3-pip \
    python3-setuptools \
    apt-utils \
    dialog \
    ffmpeg \
    lsb-core \
    git git-lfs git-review build-essential g++ redis-server

RUN git lfs install
RUN apt-get install -y --no-install-recommends \
    pkg-config zip zlib1g-dev unzip curl \
    uuid-dev \
    libx11-dev libxcursor-dev libxrandr-dev libxinerama-dev \
    sox \
    gcc-aarch64-linux-gnu g++-aarch64-linux-gnu \
    libvpx5 libtwolame-dev libtheora-bin libspeex1 \
    libopus0 libmp3lame0 libvdpau1 openexr libmpg123-0 \
    python3-pip \
    latexmk texlive-latex-recommended texlive-latex-extra texlive-fonts-recommended \
    texlive-luatex texlive-xetex \
    libudev-dev \
    libi2c-dev \
    libhidapi-libusb0 libturbojpeg \
    python3-dev libssl-dev \
    python3-tk libopenmpi-dev \
    glib2.0 gstreamer1.0-plugins.* libgstreamer1.0.* libgstreamer-plugins-.*1.0.* \
    jq

RUN curl -s -L https://packages.nvidia.com/install/repositories/dataplatform_prod/python/script.python.sh -o script.python.sh && \
    chmod +x script.python.sh && \
    /bin/bash script.python.sh
RUN apt-get install -y python3-scp python-scp python-elasticsearch python3-elasticsearch protobuf-compiler

COPY requirements.txt .
RUN python3 -m pip install -r ./requirements.txt && \
    jupyter nbextension enable --py widgetsnbextension
RUN python3 -m pip install pyparsing

RUN curl -s -L https://github.com/bazelbuild/bazel/releases/download/3.1.0/bazel-3.1.0-installer-linux-x86_64.sh -o bazel-3.1.0-installer-linux-x86_64.sh && \
    chmod +x bazel-3.1.0-installer-linux-x86_64.sh && \
    /bin/bash ./bazel-3.1.0-installer-linux-x86_64.sh


COPY bootstrap.sh /bootstrap.sh
RUN chmod 755 /bootstrap.sh

WORKDIR /isaac
RUN wget -q https://nextcloud.nautilus.optiputer.net/s/HtBcCw6MTNfM4Ci/download -O isaac-sdk-20201201-427971df2.tar.xz && \
    tar -xf isaac-sdk-20201201-427971df2.tar.xz && chown -R user:user /isaac
COPY install_dependencies.sh /isaac/engine/engine/build/scripts/install_dependencies.sh
RUN chmod 755 /isaac/engine/engine/build/scripts/install_dependencies.sh
USER user 
WORKDIR /isaac/engine
ARG DEBIAN_FRONTEND=noninteractive
#RUN ./engine/build/scripts/install_dependencies.sh

WORKDIR /home/user
