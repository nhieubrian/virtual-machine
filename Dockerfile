FROM ubuntu

RUN apt update && apt install -y python-pip git && \
    git clone https://github.com/casper-astro/casperfpga && \
    cd casperfpga  && \
    git checkout master && \
    sudo pip install -r requirements.txt && \
    sudo pip install casperfpga
