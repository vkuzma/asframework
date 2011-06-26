from django import template
from config.models import Config

register = template.Library()

@register.simple_tag
def google_analytics():
    return Config.objects.all()[0].analytics_code