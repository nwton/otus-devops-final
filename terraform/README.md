# Terraform templates

## Сохранение terraform.tfstate в Google Cloud

Можно использовать сохранение tfstate файлов во внешнем хранилище,
в этом проекте используем Google Cloud storage buckets

- <https://cloud.google.com/storage/>
- <https://console.cloud.google.com/storage/browser>

Копируем образцы, изменяем параметры и запускаемся

``` text
cp -n terraform.tfvars.example terraform.tfvars
cp -n storage-bucket.tf.example storage-bucket.tf

vi terraform.tfvars

terraform get
terraform init
terraform refresh
terraform plan

terraform apply
```

Если контейнер был создан вручную или сломалась база tfstate и есть
потребность в полном управлении данным объектом через terraform
(чтобы можно было его удалить), то можно сделать import так:

``` text
terraform import module.storage-bucket.google_storage_bucket.default[0] unknown-project-tf-state

terraform destroy
```
