FROM alpine:3.9

ENV APP_HOME /app
RUN mkdir $APP_HOME

WORKDIR $APP_HOME
COPY . $APP_HOME

RUN apk add --no-cache build-base python3 python3-dev  \
    && pip3 install -r /app/requirements.txt \
    && apk del build-base python3-dev \
    && rm -rf /var/cache/* \
    && rm -rf /root/.cache/*

ENV MONGO se_mongo_crawler_db
ENV MONGO_PORT 27017
ENV RMQ_HOST=se_rabbit
ENV RMQ_QUEUE=crawler
ENV RMQ_USERNAME=guest
ENV RMQ_PASSWORD=guest
ENV CHECK_INTERVAL=1
ENV EXCLUDE_URLS='.*github.com'
ENV URL='https://vitkhab.github.io/search_engine_test_site/'

# ENTRYPOINT ["python3", "-u", "crawler/crawler.py"]
ENTRYPOINT python3 -u crawler/crawler.py $URL
