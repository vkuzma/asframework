from shebangSeo.views import search_engine_view

class SeoMiddleware(object):
    def process_view(self, request, view_func, view_args, view_kwargs):
        if '_escaped_fragment_' in request.GET:
            return search_engine_view(request, request.GET['_escaped_fragment_'])