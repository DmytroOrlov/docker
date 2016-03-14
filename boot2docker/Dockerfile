FROM boot2docker/boot2docker

RUN git clone https://github.com/DmytroOrlov/cjdns.git $ROOTFS/cjdns \
  && cd $ROOTFS/cjdns \
  && ./do

RUN /make_iso.sh

CMD ["cat", "boot2docker.iso"]
