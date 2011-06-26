from django.contrib import admin
from config.models import Config

class ConfigAdmin(admin.ModelAdmin):
    fields = ('page_title', 'analytics_code', 'description', 'keywords', 'develop', 'release_date')
    readonly_fields = ('release_date',)

admin.site.register(Config, ConfigAdmin)