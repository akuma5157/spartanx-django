"""
Do not modify this file. It is generated from the Swagger specification.

Routing module.
"""
from django.conf.urls import url
from django.conf import settings
import core.views as views

urlpatterns = [
    url(r"^tweets/$", views.Tweets.as_view()),
    url(r"^$", views.Root.as_view()),
]

if settings.DEBUG:
    urlpatterns.extend([
        url(r"^spec/$", views.__SWAGGER_SPEC__.as_view()),
    ])