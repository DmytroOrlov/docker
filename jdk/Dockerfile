# docker build --tag dmytroorlov/jdk .
FROM ubuntu

COPY jdk-11.0.6_linux-x64_bin.deb /var/cache/oracle-jdk11-installer-local/
ENV JAVA_HOME /usr/lib/jvm/jdk-11.0.6
RUN apt update \
  && apt install -y libasound2 \
  && dpkg -i /var/cache/oracle-jdk11-installer-local/jdk-11.0.6_linux-x64_bin.deb \
  && ln -s /usr/lib/jvm/jdk-11.0.6/bin/java /usr/bin \
  && ln -s /usr/lib/jvm/jdk-11.0.6/bin/javac /usr/bin \
  && rm -rf /var/cache/oracle-jdk11-installer-local/jdk-11.0.6_linux-x64_bin.deb \
  && rm -rf /var/lib/apt/lists/*
