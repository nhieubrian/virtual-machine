FROM gitlab-registry.nautilus.optiputer.net/prp/centos-egl

USER root

RUN wget -O xrt_201910.2.2.2250_7.4.1708-xrt.rpm https://nextcloud.nautilus.optiputer.net/s/X4BMG5jNoAmA26Q/download && \

    wget -O xilinx-u200-xdma-201830.2-2580015.x86_64.rpm https://nextcloud.nautilus.optiputer.net/s/R98YpRq9FrnZoLo/download && \
    wget -O xilinx-u200-xdma-dev-201830.2-2580015.x86_64.rpm https://nextcloud.nautilus.optiputer.net/s/tKxcYCyXb7xca8X/download && \
    wget -O Xilinx_Unified_2019.2_1106_2127_Lin64.bin https://nextcloud.nautilus.optiputer.net/s/6HGYdHDXRadNs7Q/download && \
    wget -O install_drivers.tar https://nextcloud.nautilus.optiputer.net/s/SNoy7F6TXF4prF9/download && \
    tar -xvf install_drivers.tar && \
    cd install_drivers && \
    ./install_drivers && \
    ln -s /home/stream/tools /tools && \
    cd ../ && rm -rf install_drivers* 
    
RUN yum clean all && yum -y install xrt_201910.2.2.2250_7.4.1708-xrt.rpm \
    xilinx-u200-xdma-201830.2-2580015.x86_64.rpm \
    xilinx-u200-xdma-dev-201830.2-2580015.x86_64.rpm && \
    rm -rf xrt_201910.2.2.2250_7.4.1708-xrt.rpm \
    xilinx-u200-xdma-201830.2-2580015.x86_64.rpm \
    xilinx-u200-xdma-dev-201830.2-2580015.x86_64.rpm

USER user
