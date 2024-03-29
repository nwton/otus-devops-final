# Исходный код компонентов

## Сборка и запуск

Необходимо заполнить `.env` по аналогии с `.env.example`
и запустить через docker-compose

``` text
cp -n .env.example .env
docker-compose build
docker-compose up -d
```

После этого проверить работу UI на 8000 порту по адресу docker хоста.

## Очищение хвостов

Для crawler специально сделано именованный persistent volume,
если необходимо при тестировании очистить содержимое базы, то
можно удалить конкретный volume.
Дополнительно можно очистить вообще всё лишнее (используйте
с осторожностью, т.к. придётся скачивать базовые образа заново
и пересобирать контейнеры)

``` text
docker-compose down

docker image ls
docker image rm search_db

docker image ls
docker-compose down --rmi local
docker-compose down --rmi all
docker image rm $(docker image ls -q)

docker-compose down -v
docker volume rm $(docker volume ls -q)

docker-compose down --remove-orphans
```

## Примечание по GCP

Для открытия доступа к UI необходимо добавить правило фаервола
по 8000 порту, например, для docker-lab сделать так:

``` text
gcloud compute firewall-rules create \
    --allow tcp:8000 \
    --target-tags=docker-machine \
    --description="docker-lab allow access to search_ui port 8000" \
    --direction=INGRESS \
    web-access-docker-lab-search-ui
```

##
Исходный код приложения:

* <https://github.com/express42/search_engine_crawler>
* <https://github.com/express42/search_engine_ui>

Была загружена последняя версия исходных файлов
для удобства локальной сборки и внесения изменений.

``` bash
wget https://github.com/express42/search_engine_crawler/archive/master.zip \
  && unzip master.zip \
  && rm master.zip

wget https://github.com/express42/search_engine_ui/archive/master.zip \
  && unzip master.zip \
  && rm master.zip
```

Из внешних зависимостей:

* MongoDB, предполагаю версию 3.4, т.к. используется pymongo=3.5.1
  * <https://pypi.org/project/pymongo/3.5.1/>
  * <http://api.mongodb.com/python/3.5.1/>
  * <http://api.mongodb.com/python/3.5.1/changelog.html>
  * <https://docs.mongodb.com/manual/release-notes/>
  * <https://hub.docker.com/_/mongo/>
* RabbitMQ, предполагаю последнюю стабильную версию 3.7, но возможно из-за
  устаревшей библиотеки pika=0.11.0 (даже не 0.13.1) потребуется откат до
  версии 3.6, при проблемах можно будет попробовать обновить зависимости
  (требуется AMQP 0-9-1)
  * <https://pypi.org/project/pika/0.11.0/>
  * <https://pika.readthedocs.io/en/0.13.1/>
  * <https://www.rabbitmq.com/versions.html>
  * <https://hub.docker.com/_/rabbitmq/>
