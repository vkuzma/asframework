from django.conf.urls.defaults import *
from django.contrib import admin

import os

admin.autodiscover()

urlpatterns = patterns('',
    #flash site
    url(r'^$', 'views.index'),
    
    #admin
    (r'^admin/', include(admin.site.urls)),
    
    url(r'^media/(?P<path>.*)$', 'django.views.static.serve',
            {'document_root': os.path.join(os.path.dirname(__file__), 'media/')}),
            
    #piston 
    url(r'^api/', include('ajax_page_loader.urls')),  

    #FeinCMS
    url(r'^(.*)/$|^$', 'feincms.views.applicationcontent.handler'),
)
