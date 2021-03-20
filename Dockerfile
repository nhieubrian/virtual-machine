FROM gitlab-registry.nautilus.optiputer.net/prp/docker-nvidia-egl-desktop:latest

RUN curl https://bootstrap.pypa.io/pip/2.7/get-pip.py  --output get-pip.py && \
    python2 get-pip.py

RUN git clone https://github.com/casper-astro/casperfpga && \
    cd casperfpga  && \
    git checkout master && \
    pip2 install -r requirements.txt && \
    pip2 install casperfpga

USER user
WORKDIR /home/user

ENTRYPOINT ["/usr/bin/supervisord"]
