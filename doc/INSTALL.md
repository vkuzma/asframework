Django mit asframework
======================
                  
Voraussetzung
------------
Django sollte nach der Anleitung: 
https://github.com/allink/toolbox/blob/master/django.md
bereits aufgesetzt sein.     

Das Projekt welches mit dieser Anleitung erstellt wird, wurde mit den folgenden Requirements getestet: 
                                                                  
    Django==1.2.5
    FeinCMS==1.2.2
    South==0.7.3
    simplejson==2.1.3
    PIL==1.1.7
    django-mptt==0.4.2     
    -e hg+http://bitbucket.org/jespern/django-piston#egg=django-piston   
    django-robots==0.8.0

                        
Settings anpassen
-----------------
1. TinyMCE Pfade setzen:

        FEINCMS_ADMIN_MEDIA = '/media/feincms/'  
        FEINCMS_TINYMCE_INIT_TEMPLATE = 'admin/content/richtext/init_tinymce.html'  
        FEINCMS_RICHTEXT_INIT_CONTEXT  = {
            'TINYMCE_JS_URL': os.path.join(STATIC_URL, 'javascript/tiny_mce/tiny_mce.js'),  
            'TINYMCE_CONTENT_CSS_URL': STATIC_URL + 'stylesheets/tiny_mce.css',
            'TINYMCE_LINK_LIST_URL': '/admin/javascript/tiny_mce_links.js'
        }       
        
2. Middleware ergänzen:        

        MIDDLEWARE_CLASSES = (
            ...
            'ajax_page_loader.middleware.SeoMiddleware', 
        ) 
3. Apps ergänzen:

        INSTALLED_APPS = (
            ...
            'robots',   
            'config',        
        )
4. Flash Pfade setzen:

    _Im settings\_development.py:_

        SWF_PATH = STATIC_URL + 'flash/debug/flash_loader.swf'
        MAIN_SWF_PATH = STATIC_URL + 'flash/debug/flash.swf'   

    _Im settings\_production.py und settings\_staging.py:_

        SWF_PATH = '/media/flash/flash_loader.swf'
        MAIN_SWF_PATH = '/media/flash/flash.swf' 

5. urls.py wie folgt anpassen:

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
                url(r'', include('feincms.urls')),   
        ) 
        
6. Ins Django-Projektverzeichnis wechseln.  

7. Order für Flashdateien erstellen:

        mkdir static/flash
        mkdir static/flash/debug

8. views.py kopieren:
    
        cp path/to/asframework/django_includes/views.py .         

9. Wichtige Javascriptscripts hinzufügen:

        cp path/to/asframework/django_includes/static/javascript/flash_utils/* static/javascript/

10. TinyMCE
        
    _Applikations-Ordner kopieren:_

        cp -R path/to/asframework/django_includes/javascript/tiny_mce static/javascript/

    _Config kopieren:_  
    
        cp -R path/to/asframework/django_includes/tinyMCE_config/admin templates/
        
11. HTML-Fallback kopieren:

        cp -R path/to/asframework/django_includes/html_fallback/* templates/
        
12. Error Templates kopieren:

        cp path/to/asframework/django_includes/error_templates/* templates/
        
13. Sitemap kopieren:

        cp path/to/asframework/django_includes/sitemap.xml templates/sitemap.xml
        
14. ajax\_page\_loader-Ornder kopieren:

        cp -R path/to/asframework/django_includes/ajax\_page\_loader .
        
15. page\_extensions-Ordner kopieren:

        cp -R page/to/asframework/django_includes/page\_extensions .
        
    _Extensions dem Pagemodul im models.py hinzufügen:_
        
        from sandbox_feincms.page_extensions import page_as_model 
        ...
        Page.register_extensions(
            ...
            page_as_model,
        )
                      
16. config App installieren:

    _Applikations-Ordner kopieren:_
    
        cp -R path/to/asframework/django_includes/config .

    _Tabellen erstellen:_  
    
        ./mangage.py schemamigration --init config
        ./manage.py migrate config

17. imagetree App installieren:
                                                                                    
   _Applikations-Ordner kopieren:_

        cp -R path/to/asframework/django_includes/imagetree .

    _Tabellen erstellen:_  
    
        ./mangage.py schemamigration --init imagetree
        ./manage.py migrate imagetree
        
18. robots App installieren:

    _Tabellen erstellen:_  

        ./mangage.py schemamigration --init robots
        ./manage.py migrate robots  

19. CMS configurieren.
       
    _config App configurieren:_
    1. Ins CMS einloggen
    2. In die config App wechseln
    3. Einen neuen Eintrag erstellen 
    4. Checkbox bein Entwicklermodus anwählen und abspeichern.
    
    _robots App configurieren:_
    1. In die robots App wechseln
    2. Rules anwählen
    3.  
