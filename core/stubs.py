"""
Do not modify this file. It is generated from the Swagger specification.
"""


class AbstractStubClass(object):
    """
    Implementations need to be derived from this class.
    """

    # getSpec -- Synchronisation point for meld
    @staticmethod
    def getSpec(request, *args, **kwargs):
        """
        :param request: An HttpRequest
        """
        raise NotImplementedError()

    # getTweets -- Synchronisation point for meld
    @staticmethod
    def getTweets(request, keyword, *args, **kwargs):
        """
        :param request: An HttpRequest
        :param keyword: 
        :type keyword: string
        :default keyword: halo
        """
        raise NotImplementedError()


