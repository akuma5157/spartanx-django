"""
Do not modify this file. It is generated from the Swagger specification.
Create fixtures file by running "./manage.py dumpdata core auth -o core/fixtures/core.json"


"""
import logging
from django.contrib.auth.models import AnonymousUser, User
from django.test import RequestFactory, TestCase, tag
from django.contrib.sessions.middleware import SessionMiddleware
import moto


from . import views

# Set up logging
logging.basicConfig(level=logging.DEBUG)
logger = logging.getLogger(__name__)
logging.getLogger('boto').setLevel(logging.CRITICAL)
logging.getLogger('boto3').setLevel(logging.CRITICAL)
logging.getLogger('botocore').setLevel(logging.CRITICAL)
logging.getLogger('s3transfer').setLevel(logging.CRITICAL)
logging.getLogger('urllib3').setLevel(logging.CRITICAL)


def add_session_to_request(request):
    """Annotate a request object with a session"""
    middleware = SessionMiddleware()
    middleware.process_request(request)
    request.session.save()


class CoreTest(TestCase):
    fixtures = ['core.json']

    def setUp(self):
        # Every test needs access to the request factory.
        self.factory = RequestFactory()
        self.user = User.objects.get(username="ajay")

    @tag('get', 'getSpec')
    def test_getSpec(self):
        # Create an instance of a GET request.
        vars = dict()
        request = self.factory.get('', vars)
        add_session_to_request(request)

        # simulating a logged in user
        request.user = self.user

        # Test Root.as_view() as if it were deployed at 
        response = views.Root.as_view()(request, )
        print(response.content)
        self.assertEqual(response.status_code, 200)
