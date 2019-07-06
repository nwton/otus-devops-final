# Внутренняя лаборатория для тестирования контейнеризации

## Использование

Работаем в venv окружении
``` text
source venv/bin/activate

docker-machine ls
docker-machine status docker-lab
docker-machine start docker-lab
eval $(docker-machine env docker-lab)
docker run hello-world

vagrant status
vagrant up docker-lab
eval $(docker-machine env docker-lab-local)
docker run hello-world

...

docker-machine stop docker-lab
vagrant halt docker-lab

eval $(docker-machine env --unset)
deactivate
```

## Подготовка

### Установка docker-ce + docker-machine + docker-compose

Список инструкций:

- <https://docs.docker.com/install/linux/docker-ce/ubuntu/>
- <https://docs.docker.com/machine/install-machine/>
- <https://docs.docker.com/compose/install/#install-compose>

Установка docker-ce

``` text
sudo apt-get update
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
```

Установка docker-mashine в локальный каталог

``` text
$ base=https://github.com/docker/machine/releases/download/v0.16.0 &&
  curl -L $base/docker-machine-$(uname -s)-$(uname -m) -o /tmp/docker-machine &&
  cp /tmp/docker-machine ~/bin/docker-machine &&
  chmod +x ~/bin/docker-machine

sudo install /tmp/docker-machine /usr/local/bin/docker-machine
```

Установка docker-compose в локальный каталог
(или можно сделать `pip install docker-compose`)

``` text
$ base=https://github.com/docker/compose/releases/download/1.24.0 &&
  curl -L $base/docker-compose-$(uname -s)-$(uname -m) -o ~/bin/docker-compose &&
  cp /tmp/docker-machine ~/bin/docker-compose &&
  chmod +x ~/bin/docker-compose

sudo install /tmp/docker-compose /usr/local/bin/docker-compose
```

### Развертывание virtualenv

Сборка и запуск venv окружения

``` bash
sudo apt-get install python-virtualenv
sudo pip install virtualenv

virtualenv venv
source venv/bin/activate
...
pip install -r requirements.txt
...
deactivate
```

### Развертывание docker-lab через Vagrant+Virtualbox на локальном диске

При работе под Windows устанавливать надо обе версии Vagrant (Windows + WSL)

``` text
C:> windows
choco install virtualbox --version 5.2.30
choco install vagrant --version 2.2.5

$ WSL
wget https://releases.hashicorp.com/vagrant/2.2.5/vagrant_2.2.5_x86_64.deb
sudo dpkg -i vagrant_2.2.5_x86_64.deb

export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1"
export PATH="$PATH:/mnt/c/Program Files/Oracle/VirtualBox"
```

Запуск лабы
``` text
export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1"
export PATH="$PATH:/mnt/c/Program Files/Oracle/VirtualBox"

source venv/bin/activate

vagrant up docker-lab
vagrant provision docker-lab

docker-machine create \
    --driver generic \
    --generic-ip-address=10.10.10.42 \
    --generic-ssh-key .vagrant/machines/docker-lab/virtualbox/private_key \
    --generic-ssh-user=vagrant \
    docker-lab-local

docker-machine ls

eval $(docker-machine env docker-lab-local)
docker run hello-world

eval $(docker-machine env --unset)

deactivate
```

Завершение работы лабы

``` text
vagrant halt docker-lab
eval $(docker-machine env --unset)
docker-machine stop docker-lab-local
docker-machine rm docker-lab-local
```

Примечание: удаление через `docker-machine rm` приведёт только
к удалению из списка, но не удалению виртуалки.

### Развертывание docker-lab через docker-machine на GCP

Развертывание на GCP

``` text
export GOOGLE_PROJECT=xxxxx

docker-machine create --driver google \
    --google-machine-image https://www.googleapis.com/compute/v1/projects/ubuntu-os-cloud/global/images/family/ubuntu-1604-lts \
    --google-machine-type n1-standard-1 \
    --google-zone europe-west1-b \
    --google-disk-size 20 \
    docker-lab

gcloud compute firewall-rules create \
    --allow tcp:80,tcp:443 \
    --target-tags=docker-machine \
    --description="docker-lab allow access to HTTP and HTTPS" \
    --direction=INGRESS \
    web-access-docker-lab

docker-machine ls

eval $(docker-machine env docker-lab)
docker run hello-world

eval $(docker-machine env --unset)
``` text

Примечание: удаление через `docker-machine rm` приведёт к
удалению инстанса из GCP.
