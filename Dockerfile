FROM gitlab-registry.nautilus.optiputer.net/prp/docker-nvidia-egl-desktop:latest

USER root
RUN curl https://bootstrap.pypa.io/pip/2.7/get-pip.py  --output get-pip.py && \
    python2 get-pip.py

RUN  apt-get update && apt-get install -y --no-install-recommends dkms uuid-dev \
     ocl-icd-opencl-dev \
     libboost-filesystem1.65.1 \
     libboost-program-options1.65.1 \
     libboost-system1.65.1 \
     libncurses5 \
     libprotobuf10 \
     libtinfo5

WORKDIR /xilinx

RUN curl https://nextcloud.nautilus.optiputer.net/s/BeeFrHF9cKGYQzm/download --output xrt_202020.2.8.743_18.04-amd64-xrt.deb && \
    curl https://nextcloud.nautilus.optiputer.net/s/dL6nW4zgHCzA76Q/download --output xilinx-u200-xdma-201830.2-dev-2580015_18.04.deb && \
    curl https://nextcloud.nautilus.optiputer.net/s/2CdEXBSFe5o32aR/download --output xilinx-u200-xdma-201830.2-2580015_18.04.deb && \
#    curl https://nextcloud.nautilus.optiputer.net/s/dpw2YtjXRFpeGyr/download --output Xilinx_Vivado_Vitis_Update_2020.2.1_1211_2237.tar.gz && \
#    curl https://nextcloud.nautilus.optiputer.net/s/iZYcCo5wWeP33SY/download --output Xilinx_Unified_2020.2_1118_1232_Lin64.bin && \
    apt install -y ./xrt*.deb --no-install-recommends && rm -rf *.deb && \
    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/casper-astro/casperfpga && \
    cd casperfpga  && \
    git checkout master && \
    pip install -r requirements.txt && \
    pip install casperfpga

USER user
WORKDIR /home/user
