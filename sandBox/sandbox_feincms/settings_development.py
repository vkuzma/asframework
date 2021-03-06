# Django settings for sandbox_feincms project.
import os
PROJECT_DIR = os.path.dirname(__file__)

DEBUG = True
TEMPLATE_DEBUG = DEBUG

ADMINS = (
    #('itcrowd', 'itcrowd@allink.ch'),
)

MANAGERS = ADMINS

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3', # Add 'postgresql_psycopg2', 'postgresql', 'mysql', 'sqlite3' or 'oracle'.
        'NAME': 'db.sqlite',                      # Or path to database file if using sqlite3.
        'USER': '',                      # Not used with sqlite3.
        'PASSWORD': '',                  # Not used with sqlite3.
        'HOST': '',                      # Set to empty string for localhost. Not used with sqlite3.
        'PORT': '',                      # Set to empty string for default. Not used with sqlite3.
    }
}

# Local time zone for this installation. Choices can be found here:
# http://en.wikipedia.org/wiki/List_of_tz_zones_by_name
# although not all choices may be available on all operating systems.
# On Unix systems, a value of None will cause Django to use the same
# timezone as the operating system.
# If running in a Windows environment this must be set to the same as your
# system time zone.
TIME_ZONE = 'Europe/Zurich'

# Language code for this installation. All choices can be found here:
# http://www.i18nguy.com/unicode/language-identifiers.html
LANGUAGE_CODE = 'en'

SITE_ID = 1

# If you set this to False, Django will make some optimizations so as not
# to load the internationalization machinery.
USE_I18N = True

# If you set this to False, Django will not format dates, numbers and
# calendars according to the current locale
USE_L10N = True

# Absolute path to the directory that holds media.
# Example: "/home/media/media.lawrence.com/"
MEDIA_ROOT = os.path.join(PROJECT_DIR, 'media/')

# URL that handles the media served from MEDIA_ROOT. Make sure to use a
# trailing slash if there is a path component (optional in other cases).
# Examples: "http://media.lawrence.com", "http://example.com/media/"
MEDIA_URL = '/media/'

# URL prefix for admin media -- CSS, JavaScript and images. Make sure to use a
# trailing slash.
# Examples: "http://foo.com/media/", "/media/".
ADMIN_MEDIA_PREFIX = '/media/admin/'

FEINCMS_ADMIN_MEDIA = '/media/feincms/'  
FEINCMS_TINYMCE_INIT_TEMPLATE = 'admin/content/richtext/init_tinymce.html'  
FEINCMS_RICHTEXT_INIT_CONTEXT  = {
    'TINYMCE_JS_URL': os.path.join(MEDIA_URL, 'javascript/tiny_mce/tiny_mce.js'),  
    'TINYMCE_CONTENT_CSS_URL': MEDIA_URL + 'stylesheets/tiny_mce.css',
    'TINYMCE_LINK_LIST_URL': '/admin/javascript/tiny_mce_links.js'
}

TEMPLATE_CONTEXT_PROCESSORS = (
    'django.core.context_processors.auth',
    'django.core.context_processors.debug',
    'django.core.context_processors.i18n',
    'django.core.context_processors.media',
    'django.core.context_processors.request',
)    

TEMPLATE_DIRS = (
    os.path.join(PROJECT_DIR, 'templates'),
)

# Make this unique, and don't share it with anybody.
SECRET_KEY = 'c_)=bnhp@h8bpr109!i051b5xgp=o#$^9y9+bynk@qye%_h35!'

 # List of callables that know how to import templates from various sources.
TEMPLATE_LOADERS = (
    'django.template.loaders.filesystem.Loader',
    'django.template.loaders.app_directories.Loader',
)

MIDDLEWARE_CLASSES = (
    'django.middleware.common.CommonMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',  
    'ajax_page_loader.middleware.SeoMiddleware', 
)

ROOT_URLCONF = 'sandbox_feincms.urls'

INSTALLED_APPS = (
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.sites',
    'django.contrib.admin',
    #'django.contrib.messages',
    'feincms',
    'feincms.module.page', 
    'feincms.module.medialibrary',
    'sandbox_feincms',
    'mptt', 
    'south',
    'django.contrib.admindocs', 
    'imagetree',
)

SOUTH_MIGRATION_MODULES = {
    'page': 'sandbox_feincms.migrations_page',
    'medialibrary': 'sandbox_feincms.migrations_medialibrary',
}

LANGUAGES = (
    ('en', 'English'),
    ('de', 'German'),
    ('fr', 'French'),
)

FEINCMS_TREE_EDITOR_INCLUDE_ANCESTORS = True 
EMAIL_BACKEND = 'django.core.mail.backends.console.EmailBackend'
SWF_PATH = '/media/flash/debug/sandbox_loader.swf'
MAIN_SWF_PATH = '/media/flash/debug/sandbox.swf'
