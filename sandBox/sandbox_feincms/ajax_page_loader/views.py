from django.shortcuts import render_to_response
from django.template import RequestContext
from django.contrib.sites.models import RequestSite
from feincms.module.page.models import Page
from feincms.views.applicationcontent import handler


def search_engine_view(request, hash_fragment):
    request.path = hash_fragment
    request.shebang_seo = True
    request.is_ajax = lambda : False
    return handler(request)
