FROM python:alpine
MAINTAINER Ajay Kumar <ajay.kumar.19495@gmail.com>

# Standard working directory for python apps
WORKDIR /usr/src/app

# Installing Dependencies and Packages
COPY ./requirements.txt requirements.txt
RUN apk add --no-cache --virtual .build-deps \
  build-base libffi-dev \
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

# The app will be accessible on port 80
EXPOSE 8000

# Using Gunicorn as the wsgi service
CMD gunicorn -b 0.0.0.0:8000 --access-logfile - "spartanx-django.wsgi:application"

# Copying app files
# This line is at the bottom to reuse the previously build layers when changes to source code are made
# see .dockerignore to see the files excluded from the image
COPY . .
