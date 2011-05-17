from ajax_page_loader.handlers import PageHandler, NavigationHandler, InitHandler 
#from ajax_page_loader.handlers import SoundHandler 

from piston.resource import Resource
from django.conf.urls.defaults import *

page_handler = Resource(PageHandler)
navigation_handler = Resource(NavigationHandler)
init_handler = Resource(InitHandler) 
#sound_handler = Resource(SoundHandler)

urlpatterns = patterns('',
    url(r'^page/(?P<path>[^.]+)\.(?P<emitter_format>.+)$', page_handler, name = 'page_handler'),
    url(r'^navigation/(?P<language>\w{2})\.(?P<emitter_format>.+)$', navigation_handler, name= 'navigation_handler'),
    url(r'^init\.(?P<emitter_format>.+)$', init_handler, name = 'init_handler'), 
    # url(r'^sound\.(?P<emitter_format>.+)$', sound_handler, name = 'sound_handler') 
)
