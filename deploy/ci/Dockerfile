FROM registry.yandex-academy.ru/school/2024-06/backend/python/homeworks/hw3_dbindex/fruits/service-base:latest

RUN mkdir /$app/tasks

ADD src /$app
ADD tasks /$app/tasks
CMD fastapi run /$app/enterprise/app.py
