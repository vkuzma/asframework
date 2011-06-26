from django.db import models
from feincms.module.medialibrary.models import MediaFile

class Config(models.Model):
    page_title = models.CharField(max_length=30, blank=True, default='', unique=True, verbose_name='Seitentitel')
    analytics_code = models.CharField(max_length=15, blank=True, null=True, verbose_name='Google Analyticks Code')
    description = models.TextField(blank=True, default='', verbose_name='Seitenbeschreibung')
    keywords = models.TextField(blank=True, default='', verbose_name='Keywords')
    develop = models.BooleanField(verbose_name='Entwicklungsmodus', help_text='Im Entwicklungsmodus wird das Hauptswf nicht vom Browser gecached.')
    release_date = models.DateTimeField(null=True, verbose_name='Letztes SWF update.')
    
    def __unicode__(self):
        return 'Config'
    
    class Meta:
        verbose_name_plural = 'Config'
        verbose_name = 'Config'
        
    def save(self, *arg, **kwargs):
        super(Config, self).save(*arg, **kwargs)
        if Config.objects.all().count() > 1:
            Config.objects.all()[1].delete()
            raise ValueError("Nur eine Configuration ist moeglich!")
    