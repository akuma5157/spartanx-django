import os

from ruamel.yaml import YAML

from .stubs import AbstractStubClass

yaml = YAML()
yaml.explicit_start = True
yaml.indent(sequence=4, offset=2)


class Implementation(AbstractStubClass):

    def getSpec(request, *args, **kwargs):
        try:
            with open(os.path.join("swagger-spec.yml"), "r") as f:
                spec = yaml.load(f)
        except EnvironmentError:
            spec = "No Swagger Spec available"
        return spec

    def getTweets(request, keyword, *args, **kwargs):
        return "keyword: '{}' recieved".format(keyword)
