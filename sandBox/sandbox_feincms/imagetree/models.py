from django.db import models
from PIL import Image as pil_image
from django.core import files   
from imagetree.functions import *
import os

class Image(models.Model):
    description = models.TextField(blank=True, null=True)
    image = models.ImageField(upload_to='images/original')
    width = models.IntegerField(default=0)
    heigth = models.IntegerField(default=0) 
   
    order = models.IntegerField(default=0)
    
    class Meta:
        verbose_name = "Image"
        verbose_name_plural = "Images"
        
    def __unicode__(self):
        return self.image.name
        
    def url(self):
        return self.image.url
       
    def save(self, *args, **kwargs):
        super(Image, self).save(*args, **kwargs)
 
        image_temp = cropImage(self.image, 350, 1000)
        self.image.save(os.path.split(self.image.name)[1], files.File(image_temp), save=False)       
        super(Image, self).save(*args, **kwargs)  
        
class Gallery(models.Model):    
    images = models.ManyToManyField(Image)  
    title = models.CharField(max_length=40, blank=False, default="Gallery", )
    
    class Meta:
        verbose_name = "Gallery"
        verbose_name_plural = "Galleries"  
        
    def __unicode__(self): 
        return self.title
        

class GalleryContentType(models.Model): 
    gallery = models.ForeignKey(Gallery, null=False)
    
    class Meta:
        abstract = True
        verbose_name = 'Gallery'  
        
    def save(self, *args, **kwargs):
        
        super(GalleryContentType, self).save(*args, **kwargs) 
        super(GalleryContentType, self).save(*args, **kwargs) 
        
    def render(self, request):
        return render_to_string('content/gallery/gallery_content.html', {'gallery': Image.objects.all()})