from django.db import models
from feincms.module.page.models import Page

def buildSection(self):
    sections = []
    for cls in self._feincms_content_types:
        currentPage = cls.objects.filter(parent=self)
        sectionType = cls.__name__
        if str(cls) == "<class 'feincms.module.page.models.RichTextContent'>":
            sections.extend(buildTextSectionContent(currentPage, sectionType))
        if str(cls) == "<class 'feincms.module.page.models.ImageContentType'>":
            sections.extend(buildImageContent(currentPage, sectionType))
               
    sections.sort(key=lambda section: section['ordering'])
    return sections

def register(cls, admin_cls):
    cls.sections = buildSection
    
def buildTextSectionContent(currentPage, sectionType): 
    sections = []   
    for content in currentPage:
        sections.append(
                {'text': content.text, 
                'type': sectionType,
                'ordering': content.ordering,
                'region': content.region,})
    return sections
    
def buildImageContent(currentPage, sectionType):
    sections =[]
    for content in currentPage:
        sections.append(
                {'images': ({
                'url': content.image.url,
                'height': content.height,
                'width': content.width},),
                'type': sectionType,
                'ordering': content.ordering,
                'region': content.region,})
    return sections
