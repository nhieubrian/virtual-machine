FROM ubuntu

RUN git clone https://github.com/casper-astro/casperfpga && \
    cd casperfpga  && \
    git checkout master && \
    sudo apt-get install python-pip && \
    sudo pip install -r requirements.txt && \
    sudo pip install casperfpga
