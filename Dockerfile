FROM ubuntu

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y git

RUN git clone https://github.com/casper-astro/casperfpga && \
    cd casperfpga  && \
    git checkout master && \
    sudo pip install -r requirements.txt && \
    sudo pip install casperfpga
