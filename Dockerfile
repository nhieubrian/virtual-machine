#FROM gitlab-registry.nautilus.optiputer.net/prp/docker-nvidia-egl-desktop-18.04:latest
FROM gitlab-registry.nautilus.optiputer.net/aip_197_accchi/purple_nl/docker-nvidia-glx-desktop:latest

USER root

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
    latexmk texlive-latex-recommended texlive-latex-extra texlive-fonts-recommended \
    texlive-luatex texlive-xetex \
    libudev-dev \
    libi2c-dev \
    libhidapi-libusb0 libturbojpeg \
    python3-dev libssl-dev \
    python3-tk libopenmpi-dev \
    glib2.0 gstreamer1.0-plugins.* libgstreamer1.0.* libgstreamer-plugins-.*1.0.* \
    jq

RUN pip3 install --upgrade pip
RUN pip3 install tensorflow-gpu==1.15.0
RUN pip3 install --upgrade pip==19.3.1

RUN curl -s -L https://packages.nvidia.com/install/repositories/dataplatform_prod/python/script.python.sh -o script.python.sh && \
    chmod +x script.python.sh && \
    /bin/bash script.python.sh
RUN apt-get install -y python3-scp python-scp python-elasticsearch python3-elasticsearch protobuf-compiler


COPY requirements.txt .
RUN pip3 install --pre --no-cache-dir -r ./requirements.txt

RUN jupyter nbextension enable --py widgetsnbextension
RUN python3 -m pip install pyparsing

RUN curl -s -L https://github.com/bazelbuild/bazel/releases/download/3.1.0/bazel-3.1.0-installer-linux-x86_64.sh -o bazel-3.1.0-installer-linux-x86_64.sh && \
    chmod +x bazel-3.1.0-installer-linux-x86_64.sh && \
    /bin/bash ./bazel-3.1.0-installer-linux-x86_64.sh

COPY bootstrap.sh /bootstrap.sh
RUN chmod 755 /bootstrap.sh


RUN cd /usr/local/ && \
    wget -q -O blender-2.90.1-linux64.tar.xz https://download.blender.org/release/Blender2.90/blender-2.90.1-linux64.tar.xz && \
    tar -xf blender-2.90.1-linux64.tar.xz && \
    rm -rf blender-2.90.1-linux64.tar.xz && \
    ln -s /usr/local/blender-2.90.1-linux64 /usr/local/blender && \
    cp /usr/local/blender-2.90.1-linux64/blender.desktop /usr/share/applications/blender.desktop
#    mkdir /usr/local/UnrealEngine && \
#    chown 1000:1000 /usr/local/UnrealEngine \

RUN cd /usr/local/ && \
    apt update -y && \
    apt install -y software-properties-common apt-transport-https wget && \
    wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" && \
    apt update -y && \
    apt install -y code

RUN apt install -y apt-transport-https ca-certificates curl software-properties-common && \
    curl -fsSL https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add - && \
    add-apt-repository "deb https://download.sublimetext.com/ apt/stable/" && \
    apt update -y && \
    apt install -y sublime-text


#WORKDIR /isaac
#RUN wget -q https://nextcloud.nautilus.optiputer.net/s/HtBcCw6MTNfM4Ci/download -O isaac-sdk-20201201-427971df2.tar.xz && \
#    tar -xf isaac-sdk-20201201-427971df2.tar.xz && chown -R user:user /isaac

USER user 
WORKDIR /isaac/engine
ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /home/user
