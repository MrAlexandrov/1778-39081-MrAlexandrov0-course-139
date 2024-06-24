FROM registry.yandex-academy.ru/school/2024-06/backend/cpp/homeworks/hw3_dbindex/fruits/service-base:latest

RUN mkdir /$app/solution

ADD src /$app
ADD solution /$app/solution

CMD python manage.py migrate
CMD python manage.py runserver 0.0.0.0:8000
