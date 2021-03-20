FROM gitlab-registry.nautilus.optiputer.net/prp/docker-nvidia-egl-desktop:latest

USER root
RUN curl https://bootstrap.pypa.io/pip/2.7/get-pip.py  --output get-pip.py && \
    python2 get-pip.py

USER user
WORKDIR /home/user

RUN git clone https://github.com/casper-astro/casperfpga && \
    cd casperfpga  && \
    git checkout master && \
    pip install -r requirements.txt && \
    pip install casperfpga
