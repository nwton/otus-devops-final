# Terraform templates

Тут размещены файлы для создания инфраструктуры:

- [папка stage](stage) - файлы описывающие инфраструктуру **stage** окружения
- [папка prod](prod) - файлы описывающие инфраструктуру **production** окружения
- [папка modules](modules) - файлы модулей, используемые в разных окружениях
- [папка tf_remote_state](tf_remote_state) - инициализация bucket Google Cloud Storage
  (необходимо только при использовании расширенного варианта с использованием
  Remote State backend вместо локальных файлов terraform.tfstate)

## Быстрый старт (с локальными файлами terraform.tfstate)

Копируем файлы terraform.tfvars с переменными и обновляем их содержимое
в папках только для окружений stage и prod.
Из обязательного параметра - только идентификатор проекта из GCP.

``` bash
export TF_VAR_project="final-000000"

declare -a arr=("stage" "prod")
for i_env in "${arr[@]}"
do
  export TF_VAR_tf_env="${i_env}"
  cp -n ${TF_VAR_tf_env}/terraform.tfvars.example ${TF_VAR_tf_env}/terraform.tfvars
  sed -i -- "s/unknown-project-example/${TF_VAR_project}/g" ${TF_VAR_tf_env}/terraform.tfvars
  sed -i -- "s/unknown-tf-env-example/${TF_VAR_tf_env}/g" ${TF_VAR_tf_env}/terraform.tfvars
done
```

После этого работаем в папке для выбранного окружения
[stage](stage) или [prod](prod)

``` bash
terraform get
terraform init
terraform refresh
terraform plan

terraform apply

terraform destroy
```

## Усложнённый старт (с сохранение terraform.tfstate в Google Cloud)

Можно использовать сохранение tfstate файлов во внешнем хранилище,
в этом проекте используем Google Cloud storage buckets

- <https://cloud.google.com/storage/>
- <https://console.cloud.google.com/storage/browser>

### Шаг 1

Копируем файлы terraform.tfvars с переменными и обновляем их содержимое
для основного каталога и в папках для окружений stage и prod.

Дополнительно к идентификатору проекта из GCP необходимо задать имя для
bucket (должно быть уникально и не использоваться другими клиентами GCP)

``` bash
export TF_VAR_project="final-000000"
export TF_VAR_tf_state_bucket="unknown-project-bucket-name"

declare -a arr=("tf_remote_state" "stage" "prod")
for i_env in "${arr[@]}"
do
  export TF_VAR_tf_env="${i_env}"
  cp -n ${TF_VAR_tf_env}/terraform.tfvars.example ${TF_VAR_tf_env}/terraform.tfvars
  sed -i -- "s/unknown-project-example/${TF_VAR_project}/g" ${TF_VAR_tf_env}/terraform.tfvars
  sed -i -- "s/unknown-tf-state-bucket-example/${TF_VAR_tf_state_bucket}/g" ${TF_VAR_tf_env}/terraform.tfvars
  sed -i -- "s/unknown-tf-env-example/${TF_VAR_tf_env}/g" ${TF_VAR_tf_env}/terraform.tfvars
done
```

### Шаг 2

После этого инициализируем Google Cloud Storage для создания bucket
(или можно использовать уже существующий bucket и пропустить этот шаг)

Для этого применяем план terraform используя файлы из папки
[tf_remote_state](tf_remote_state)

``` bash
cd tf_remote_state
cp -n ./storage-bucket.tf.example ./storage-bucket.tf

terraform get
terraform init
terraform refresh
terraform plan

terraform apply

cd -
```

Если контейнер был создан вручную или сломалась база tfstate и есть
потребность в полном управлении данным объектом через terraform
(чтобы можно было его удалить), то можно сделать import так:

``` text
terraform import module.storage-bucket.google_storage_bucket.default[0] unknown-project-tf-state

terraform destroy
```

### Шаг 3

Для всех окружений инициализируем terraform на удалённое хранилище:

``` bash
declare -a arr=("stage" "prod")
for i_env in "${arr[@]}"
do
  export TF_VAR_tf_env="${i_env}"
  cp -n ${TF_VAR_tf_env}/backend.tf.example ${TF_VAR_tf_env}/backend.tf
  cd "${TF_VAR_tf_env}" \
  && terraform init \
      -backend-config "bucket=$TF_VAR_tf_state_bucket" \
      -backend-config "prefix=$TF_VAR_tf_env" \
  && cd -
done
```

Данный этап необходим из-за того, что terraform не позволяет напрямую
использовать переменные в конфигурационных файлах. Используем для того,
чтобы не использовать хардкод переменных в разных окружениях и чтобы
не сохранять чувствительную информацию в публичных репозиториях.

После предварительной инициализации terraform больше дополнительных
действий в будущем не понадобится, кроме случаев, когда требуется
выполнить `terraform init`, например, при добавлении модулей.
В этом случае потребуется ещё раз прогнать цикл (это безопасно).

Проблема с interpolation описана как ожидаемое поведение:

- <https://github.com/hashicorp/terraform/issues/13603>
- <https://github.com/hashicorp/terraform/issues/13022>
- <https://github.com/hashicorp/terraform/issues/18417>

### Шаг 4

После этого работаем в папке для выбранного окружения
[stage](stage) или [prod](prod) точно так же, как и при
использовании локальных файлов terraform.tfstate

``` bash
terraform get
terraform init
terraform refresh
terraform plan

terraform apply

terraform destroy
```
