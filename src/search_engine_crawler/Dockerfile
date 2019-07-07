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

# ENTRYPOINT ["python3", "-u", "crawler/crawler.py", "$URL"]
ENTRYPOINT python3 -u crawler/crawler.py $URL
