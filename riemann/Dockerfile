# docker build -t riemann .
FROM jdk

WORKDIR /root

ENV RM_VER 0.2.13
ENV RM_URL https://github.com/riemann/riemann/releases/download/$RM_VER/riemann-$RM_VER.tar.bz2
ENV RM_FILE riemann-$RM_VER.tar.bz2

RUN apt-get update \
  && apt-get install -y bzip2 \
  && rm -rf /var/lib/apt/lists/* \
  && curl -fSL "$RM_URL.md5" -o $RM_FILE.md5 \
  && curl -fSL "$RM_URL" -o $RM_FILE \
  && md5sum -c $RM_FILE.md5 \
  && tar -xjvf $RM_FILE --strip-components=1 \
  && rm $RM_FILE \
  && rm $RM_FILE.md5

ADD riemann.config etc

CMD ["bin/riemann", "etc/riemann.config"]
