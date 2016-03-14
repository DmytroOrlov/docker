# docker build -t dmytroorlov/elasticsearch:2.2.2 .
# docker run -d -p 9200:9200 --name elasticsearch elasticsearch:2.2.2

FROM jdk

RUN useradd -ms /bin/bash elasticsearch

WORKDIR /home/elasticsearch

USER elasticsearch

ENV ES_VERSION 2.2.2
ENV ES_URL https://download.elasticsearch.org/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/$ES_VERSION/elasticsearch-$ES_VERSION.tar.gz
ENV ES_FILE elasticsearch.tar.gz

RUN curl -fSL "$ES_URL.sha1" -o $ES_FILE.sha1 \
  && curl -fSL "$ES_URL" -o $ES_FILE \
  && echo " $ES_FILE" >> $ES_FILE.sha1 \
  && sha1sum --check $ES_FILE.sha1 \
  && tar -xvf $ES_FILE --strip-components=1 \
  && rm $ES_FILE \
  && rm $ES_FILE.sha1 \
  && /home/elasticsearch/bin/plugin install mobz/elasticsearch-head

EXPOSE 9200

CMD ["/home/elasticsearch/bin/elasticsearch", "-Des.network.host=0.0.0.0"]
