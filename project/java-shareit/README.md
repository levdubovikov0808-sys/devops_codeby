# java-shareit

CI/CD и IaC проект на базе `java-shareit` с деплоем в Selectel Managed Kubernetes.

## О проекте

Этот репозиторий содержит:
- исходный код приложения `java-shareit`;
- Dockerfile для сборки образов;
- GitHub Actions pipeline;
- Terraform для инфраструктуры в Selectel;
- Helm chart для развертывания;
- Kubernetes manifests;
- конфигурации наблюдаемости.

## Структура репозитория

- `docker/` — Dockerfile для gateway и server.
- `infra/terraform/` — код инфраструктуры.
- `infra/helm/` — Helm chart приложения и observability.
- `infra/k8s/` — Kubernetes manifests.
- `.github/workflows/` — CI/CD и Terraform pipelines.
- `docs/` — правила релиза и изменения инфраструктуры.

## Используемая схема

- GitHub — хранение кода.
- GHCR — хранение Docker-образов.
- Selectel S3 — Terraform state.
- Selectel Managed Kubernetes — целевая среда.
- Helm — способ установки приложения.
- Grafana + Prometheus + Loki — мониторинг и логи.

## Требования

- Terraform 1.6+.
- kubectl.
- helm.
- docker.
- GitHub Secrets:
  - `KUBECONFIG_B64`
  - `GHCR_TOKEN` при необходимости
  - переменные Selectel для Terraform.

## Как развернуть инфраструктуру

### 1. Подготовить backend S3

Создайте bucket в Selectel Object Storage и добавьте доступы в `secret.backend.tfvars`.

### 2. Инициализировать Terraform

```bash
cd infra/terraform
terraform init -backend-config=envs/prod/backend.hcl
