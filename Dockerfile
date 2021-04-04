FROM gitlab-registry.nautilus.optiputer.net/prp/docker-nvidia-egl-desktop-18.04:latest

USER root

RUN curl https://raw.githubusercontent.com/Xilinx/XRT/2019.1/src/runtime_src/tools/scripts/xrtdeps.sh --output xrtdeps.sh && \
    chmod 755 xrtdeps.sh && ./xrtdeps.sh

RUN curl https://bootstrap.pypa.io/pip/2.7/get-pip.py  --output get-pip.py && \
    python2 get-pip.py

RUN apt-get update && apt-get install -y --no-install-recommends \
    dkms uuid-dev \
    ocl-icd-opencl-dev \
    libboost-filesystem1.65.1 \
    libboost-program-options1.65.1 \
    libboost-system1.65.1 \
    libboost-dev \
    libncurses5 \
    libprotobuf10 \
    libtinfo5 \
    libsm6 \
    libxv1 \
    libxv1:i386

RUN apt-get update && apt-get install -y --no-install-recommends \
    dbus-x11 \
    libdbus-c++-1-0v5

RUN apt-get update && apt-get install -y --no-install-recommends \
    python3-venv \
    python3-pip \
    python3-setuptools

WORKDIR /tools
RUN curl https://nextcloud.nautilus.optiputer.net/s/yLSs43Dyps6XPMq/download --output xilinx-u200-xdma-201830.2-dev-2580015_18.04.deb && \
    curl https://nextcloud.nautilus.optiputer.net/s/s8EjqqWfMkWoQYs/download --output xilinx-u200-xdma-201830.2-2580015_18.04.deb && \
    curl https://nextcloud.nautilus.optiputer.net/s/YXjktibxG9tRGFj/download --output xrt_201910.2.2.2250_18.04-xrt.deb && \
    apt install -y ./xrt*.deb --no-install-recommends && \
    rm -rf *.deb && \
    rm -rf /var/lib/apt/lists/*

RUN wget -O install_drivers.tar https://nextcloud.nautilus.optiputer.net/s/SNoy7F6TXF4prF9/download && \
    tar -xvf install_drivers.tar && \
    cd install_drivers && \
    ./install_drivers

RUN git clone https://github.com/casper-astro/casperfpga && \
    cd casperfpga  && \
    git checkout master && \
    pip install -r requirements.txt && \
    pip install casperfpga

USER user
WORKDIR /home/user

#RUN python3 -m venv casper_venv && \
#    source casper_venv/bin/activate

#RUN git clone https://github.com/casper-astro/mlib_devel && \
#    cd mlib_devel && \
#    git checkout m2019a && \
#    pip3 install -r requirements.txt
