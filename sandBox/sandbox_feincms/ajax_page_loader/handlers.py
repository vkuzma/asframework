from feincms.module.page.models import Page
from feincms.module.medialibrary.models import MediaFile
from feincms.content.application.models import retrieve_page_information
from feincms.views.applicationcontent import handler
from django.conf import settings

from piston.handler import BaseHandler

class PageHandler(BaseHandler):
    allowed_methods = ('GET',)
    model = Page
    fields = (
        'title',
        'language',
        'languagemenu',
        'has_children',
        'sections',  
        'template',
        '_cached_url',  
        #'url'
    )
    
    def read(self, request, path):  
        #get page
        path = path.replace('_','/')
        page = Page.objects.best_match_for_path(path)
        
        #create languagemenu
        languagemenu = dict((navigation.language, navigation.get_absolute_url()) for navigation in page.available_translations())
        absolut_path_length = len(page.get_absolute_url())-2
        if absolut_path_length < len(path):
            suffix = path[absolut_path_length+1:]+'/'
        else:
            suffix = u''     
        languagemenu[page.language] = page.get_absolute_url() + suffix
        page.languagemenu = []
        for key in sorted(languagemenu.iterkeys()):
            page.languagemenu.append({'key':key,'link':languagemenu[key] + suffix})
            
        page.has_children = page.children.active().count() > 0 or bool(page.navigation_extension)            
        
        #page.url = page._cached_url
        return {
            'page': page,
        }     

class NavigationHandler(BaseHandler):
    allowed_methods = ('GET',)
    
    def read(self, request, language):
        toplevel = Page.objects.in_navigation().filter(language=language).all()
        navigations = []
        for navigation in toplevel:     
            navigations.append({
                'title': navigation.title,
                'url': navigation.get_absolute_url(),
                'slug': navigation.slug,
            })
        return {
            'navigation':navigations,
        }
        
class InitHandler(BaseHandler):
    allowed_methods = ('GET',)
    
    def read(self, request,):
        init = {
            'languages': [dict(settings.LANGUAGES)],
        }
        return {
            "init": init
        }
        
# class SoundHandler(BaseHandler):
#     allowed_methods = ('GET',)
#     
#     def read(self, request,):
#         tracks_raw = MediaFile.objects.filter(type='audio')
#         tracks = []
#         for track in tracks_raw:
#             tracks.append({'url': track.get_absolute_url()})
#         
#         return {'track': tracks,}   
        

