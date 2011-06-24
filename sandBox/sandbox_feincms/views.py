from django.conf import settings
from django.shortcuts import render_to_response
from feincms.module.page.models import Page
import datetime

from feincms.content.application.models import reverse
from django.http import HttpResponse, HttpResponseRedirect

import simplejson

def index(request):
    # current_config = Config.objects.all()[0]
    #     
    #     if current_config.develop:
    #         current_config.release_date = datetime.datetime.now()
    #         current_config.save()
    #         
    #     postfix = '?v=%s' % str(current_config.release_date)
    return render_to_response('index.html',
        {'debug': settings.DEBUG,
         'swf_path': settings.SWF_PATH,
         'main_swf_path': settings.MAIN_SWF_PATH, # + postfix,
         # 'current_config': current_config,
         # 'page_title': current_config.page_title
         })

def get_tinymce_link_list(request):
    link_list = query_to_tuple(Page.objects.filter(parent__isnull=True))
    output = "var %s = %s" % ("tinyMCELinkList", simplejson.dumps(link_list))
    return HttpResponse(output, content_type='application/x-javascript')

def query_to_tuple(query, level=0):
    link_list = tuple()
    prefix = (''.join(u'-' for i in range(level)) + ' ')
    for p in query:
        link_list += ((prefix + p.title, '/#!' + p.get_absolute_url()),)
        link_list += query_to_tuple(p.get_children(), level=level+1)
    return link_list