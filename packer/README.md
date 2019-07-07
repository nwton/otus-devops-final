# Packer templates

Темплейты для создания системных образов утилитой packer
от [hashicorp](https://www.packer.io/)

## Использование

Запускать следует из корневого каталога репозитория, т.к.
используются ansible playbooks

Краткий вариант, если значения по-умолчанию устраивают:
``` text
packer build \
    -var-file=variables.json.example \
    -var 'my_project_id=final-00000' \
    packer/base_docker.json
```

Или полный вариант запуска с изменением переменных
в конфигурационном файле:

``` text
cp -n packer/variables.json.examples packer/variables.json
vi packer/variables.json
packer build \
    -var-file=variables.json \
    packer/base_docker.json
```

## Установка packer
Установка для linux 64-bit (или для WSL)
[версии 1.2.4](https://releases.hashicorp.com/packer/)

``` text
$ base=https://releases.hashicorp.com/packer &&
  curl -L $base/1.2.4/packer_1.2.4_linux_amd64.zip -o /tmp/packer.zip &&
  unzip -n /tmp/packer.zip packer -d /tmp &&
  cp /tmp/packer ~/bin/packer &&
  chmod +x ~/bin/packer

sudo install /tmp/packer /usr/local/bin/packer
```

## Альтернативные варианты

Сейчас собирается только один базовый образ Ubuntu 16.04 LTS + Docker CE.
Альтернативный вариант - использовать образы с уже установленным docker:

* [CoreOS](https://coreos.com/) - есть в GCP
* [Atomic](http://www.projectatomic.io/)
* [RancherOS](https://rancher.com/rancher-os/)
* [Google Container-Optimized OS](https://cloud.google.com/container-optimized-os/docs/)
  есть в GCP
