# Lesson 30 - Reddit Logging System

## Описание
Развертывание приложения Reddit с системой логирования на основе Elasticsearch, Fluentd и Kibana.

## Компоненты
- **Reddit Services**: UI, Post, Comment сервисы
- **Databases**: MongoDB для post и comment
- **Logging Stack**:
  - Elasticsearch 7.17.0 - хранение и индексация логов
  - Fluentd - сбор и парсинг логов
  - Kibana 7.17.0 - визуализация логов

## Парсинг логов UI
Реализовано два способа парсинга логов сервиса UI:
1. **Regexp парсер** - использует регулярные выражения
2. **Grok парсер** - использует grok patterns

## Запуск

### Предварительные требования
- Docker 20.10+
- Docker Compose 2.0+
- 4GB+ RAM для Elasticsearch

### Шаги по запуску

1. Сборка и запуск всех сервисов:
```bash
cd lesson30
docker-compose up -d
