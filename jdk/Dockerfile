# docker build --tag dmytroorlov/jdk .
FROM ubuntu

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
RUN apt-get update \
    && apt-get install -y software-properties-common curl \
    && add-apt-repository -y ppa:webupd8team/java \
    && apt-get update \
    && echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections \
    && apt-get install -y oracle-java8-installer \
    && rm -rf /var/cache/oracle-jdk8-installer \
    && rm -rf /var/lib/apt/lists/*
