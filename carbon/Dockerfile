# docker build -t carbon .

FROM ubuntu

RUN apt-get update \
  && apt-get install -y curl \
  && curl -s https://packagecloud.io/install/repositories/raintank/raintank/script.deb.sh | bash
RUN apt-get install -d carbon-relay-ng \
  && dpkg --force-bad-version -i /var/cache/apt/archives/carbon-relay-ng_*_amd64.deb

ADD carbon-relay-ng.conf /etc/carbon-relay-ng

CMD ["carbon-relay-ng", "/etc/carbon-relay-ng/carbon-relay-ng.conf"]
