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

ENV FLASK_APP ui.py

WORKDIR /app/ui

ENTRYPOINT ["gunicorn", "ui:app", "-b","0.0.0.0"]
