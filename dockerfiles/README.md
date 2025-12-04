# Dockerfile-checker-image

Цей Docker-образ створений для використання в CI/CD конвеєрах для виконання базових перевірок (наприклад, `check-filename`).

## Підтримка

Особа, що підтримує функціонал: **Мирослава Бабійчук**

## Компоненти образу

| Компонент | Версія |
| :--- | :--- |
| [cite_start]Базова ОС | alpine:3.20 [cite: 46] |
| bash | [cite_start]5.2.26-r0 [cite: 48] |
| git | [cite_start]2.45.4-r0 [cite: 49] |
| python3 | [cite_start]3.12.3-r1 [cite: 50] |

## Використання в CI

Повний тег образу в GCP Artifact Registry: 
`europe-west3-docker.pkg.dev/directed-cove-452818-r6/myroslavababiichuk09/ci-checker-image-myroslavababiichuk:0.1.0`
