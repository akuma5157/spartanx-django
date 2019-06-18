[![Build Status](https://travis-ci.com/spartanAJ/spartanx-django.svg?branch=master)](https://travis-ci.com/spartanAJ/spartanx-django)
[![Coverage Status](https://coveralls.io/repos/github/spartanAJ/spartanx-django/badge.svg?branch=master)](https://coveralls.io/github/spartanAJ/spartanx-django?branch=master)

# spartanx-django
visit main app at [Google App Engine](https://serene-column-179904.appspot.com)  
this project uses [swagger-django-generator](https://github.com/spartanAJ/swagger-django-generator)   
checkout the API on [SwaggerUI](https://editor.swagger.io?url=https://raw.githubusercontent.com/spartanAJ/spartanx-django/master/swagger-spec.yml)

This project is a ci/cd example to deploy apps to gke using [TravisCI](https://travis-ci.com/spartanAJ/spartanx-django/).  
after unit testing, the docker service as configured [.travis.yml](/.travis.yml) builds the image from [Dockerfile](/Dockerfile) and pushes it to [DockerHub](https://hub.docker.com/r/spartanaj/spartanx-django).  

TravisCI then uses [gloud](/gke_scripts/gcloud-install.sh) to [log in](/gke_scripts/gcloud-login.sh) to GKE and changes the image in the (pre-existing)deployment using [kubectl](/gke_scripts/gke-deploy.sh).  
This deployment behaviour can be modified by customizing the [deploy script](/gke_scripts/gke-deploy.sh).  
