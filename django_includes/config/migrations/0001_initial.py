# encoding: utf-8
import datetime
from south.db import db
from south.v2 import SchemaMigration
from django.db import models

class Migration(SchemaMigration):

    def forwards(self, orm):
        
        # Adding model 'Config'
        db.create_table('config_config', (
            ('id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('page_title', self.gf('django.db.models.fields.CharField')(default='', unique=True, max_length=30, blank=True)),
            ('analytics_code', self.gf('django.db.models.fields.CharField')(max_length=15, null=True, blank=True)),
            ('description', self.gf('django.db.models.fields.TextField')(default='', blank=True)),
            ('keywords', self.gf('django.db.models.fields.TextField')(default='', blank=True)),
            ('develop', self.gf('django.db.models.fields.BooleanField')(default=False)),
            ('release_date', self.gf('django.db.models.fields.DateTimeField')(null=True)),
        ))
        db.send_create_signal('config', ['Config'])


    def backwards(self, orm):
        
        # Deleting model 'Config'
        db.delete_table('config_config')


    models = {
        'config.config': {
            'Meta': {'object_name': 'Config'},
            'analytics_code': ('django.db.models.fields.CharField', [], {'max_length': '15', 'null': 'True', 'blank': 'True'}),
            'description': ('django.db.models.fields.TextField', [], {'default': "''", 'blank': 'True'}),
            'develop': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'keywords': ('django.db.models.fields.TextField', [], {'default': "''", 'blank': 'True'}),
            'page_title': ('django.db.models.fields.CharField', [], {'default': "''", 'unique': 'True', 'max_length': '30', 'blank': 'True'}),
            'release_date': ('django.db.models.fields.DateTimeField', [], {'null': 'True'})
        }
    }

    complete_apps = ['config']
