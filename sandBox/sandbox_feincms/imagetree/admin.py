from django.contrib import admin
from imagetree.models import Image, Gallery

class ImageAdmin(admin.ModelAdmin):
    fields = ('image', 'description', 'order')
    list_display = ( '__unicode__', 'description', 'order')  
    
class GalleryAdmin(admin.ModelAdmin):
    fields = ('title', 'images')  
    list_display = ('title',)
    
admin.site.register(Image, ImageAdmin)    
admin.site.register(Gallery, GalleryAdmin)