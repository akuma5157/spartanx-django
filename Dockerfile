FROM python:alpine
MAINTAINER Ajay Kumar <ajay.t.kumar@capgemini.com>

WORKDIR /usr/src/app

COPY ./requirements.txt requirements.txt
RUN apk add --no-cache --virtual .build-deps \
  build-base mariadb-dev libffi-dev \
    && pip install -r requirements.txt \
    && find /usr/local \
        \( -type d -a -name test -o -name tests \) \
        -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
        -exec rm -rf '{}' + \
    && runDeps="$( \
        scanelf --needed --nobanner --recursive /usr/local \
                | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
                | sort -u \
                | xargs -r apk info --installed \
                | sort -u \
    )" \
    && apk add --virtual .rundeps $runDeps \
    && apk del .build-deps

EXPOSE 8000
CMD gunicorn -b 0.0.0.0:8000 --access-logfile - "spartanx-django.wsgi:application"

COPY . .
