FROM registry.yandex-academy.ru/school/2024-06/backend/python/homeworks/hw3_dbindex/fruits/service-base:latest

RUN mkdir /$app/solution

ADD src /$app
ADD solution /$app/solution
CMD fastapi run /$app/enterprise/app.py
