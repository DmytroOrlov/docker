# Usage
#
# Create image:
# $ docker build --rm -t ubuntu:tomcat .
#
# JMX port: 1099, debug port: 8000
# Create container from image:
# $ NAME=tomcat && docker run -it -p 8080:8080 -p 8000:8000 -p 1099:1099 -p 10002:10002 --name $NAME --hostname $NAME -v /Users/dorlov/repo/shared:/shared:ro ubuntu:$NAME

FROM ubuntu
# Install Java
#RUN apt-get update && apt-get -y install default-jdk curl && rm -rf /var/lib/apt/lists/*
#ADD jdk-8u40-linux-x64.tar.gz /usr/lib/jvm
#ENV PATH /usr/lib/jvm/jdk1.8.0_40/bin:$PATH
#ENV JAVA_HOME /usr/lib/jvm/jdk1.8.0_40
# Set locales for java installation
#RUN locale-gen en_GB.UTF-8
#ENV LANG en_GB.UTF-8
#ENV LC_CTYPE en_GB.UTF-8
RUN apt-get update \
    && apt-get install -y software-properties-common curl \
    && add-apt-repository -y ppa:webupd8team/java \
    && apt-get update \
    && echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections \
    && apt-get install -y oracle-java8-installer \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/cache/oracle-jdk8-installer
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

ENV CATALINA_HOME /root/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
RUN mkdir -p "$CATALINA_HOME"
WORKDIR $CATALINA_HOME

# see https://www.apache.org/dist/tomcat/tomcat-8/KEYS
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys \
    05AB33110949707C93A279E3D3EFE6B686867BA6 \
    07E48665A34DCAFAE522E5E6266191C37C037D42 \
    47309207D818FFD8DCD3F83F1931D684307A10A5 \
    541FBE7D8F78B25E055DDEE13C370389288584E7 \
    61B832AC2F1C5A90F0F9B00A1C506407564C17A3 \
    79F7026C690BAA50B92CD8B66A3AD3F4F22C4FED \
    9BA44C2621385CB966EBA586F72C284D731FABEE \
    A27677289986DB50844682F8ACB77FC2E86E29AC \
    A9C5DF4D22E99998D9875A5110C01C5A2F6059E7 \
    DCFD35E0BF8CA7344752DE8B6FB21E8933C60243 \
    F3A04C595DB5B6A5F1ECA43E3B7BBB100D811BBE \
    F7DA48BB64BCB84ECBA7EE6935CD23C10D498E23

ENV TOMCAT_MAJOR 8
ENV TOMCAT_VERSION 8.0.28
ENV TOMCAT_URL https://www.apache.org/dist/tomcat/tomcat-$TOMCAT_MAJOR/v$TOMCAT_VERSION/bin
ENV TOMCAT_TGZ_URL $TOMCAT_URL/apache-tomcat-$TOMCAT_VERSION.tar.gz

RUN set -x \
    && curl -fSL "$TOMCAT_TGZ_URL" -o tomcat.tar.gz \
    && curl -fSL "$TOMCAT_TGZ_URL.asc" -o tomcat.tar.gz.asc \
    && gpg --verify tomcat.tar.gz.asc \
    && tar -xvf tomcat.tar.gz --strip-components=1 \
    && rm bin/*.bat \
    && rm tomcat.tar.gz* \

    && curl $TOMCAT_URL/extras/catalina-jmx-remote.jar -o lib/catalina-jmx-remote.jar

ENV HOST tomcat

RUN sed -i '$i<role rolename="manager-gui"/>' conf/tomcat-users.xml \
    && sed -i '$i<user password="admin" roles="manager-gui" username="admin"/>' conf/tomcat-users.xml \
    && sed -i '/<Listener className="org.apache.catalina.startup.VersionLoggerListener/i<Listener className="org.apache.catalina.mbeans.JmxRemoteLifecycleListener" rmiRegistryPortPlatform="1099" rmiServerPortPlatform="10002" />' conf/server.xml \
    && echo 'JPDA_ADDRESS=0.0.0.0:8000' >> bin/setenv.sh \
    && echo "CATALINA_OPTS=\"-Dcom.sun.management.jmxremote= -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false -Djava.rmi.server.hostname=$HOST\"" >> bin/setenv.sh
#    && echo 'CATALINA_OPTS="-Duser.timezone=UTC $CATALINA_OPTS"' >> bin/setenv.sh

#RUN apt-get update && apt-get install -y vim && rm -rf /var/lib/apt/lists/*

EXPOSE 8080 8000 1099 10002

CMD ["catalina.sh", "jpda", "run"]
