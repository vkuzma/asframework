from sandbox_feincms.page_extensions import page_as_model
from feincms.module.page.models import Page
from feincms.content.richtext.models import RichTextContent

from django.db import models

Page.register_extensions(
    'datepublisher',
    'translations',
    'changedate',
    'navigation',
    'symlinks',
    'seo',
    page_as_model,
)

Page.register_templates({
    'key': 'content',
    'title': 'Content Page',
    'path': 'content.html',
    'regions': (
        ('main', 'Main Region'),
    ),
})

Page.create_content_type(RichTextContent, regions=('main',))
