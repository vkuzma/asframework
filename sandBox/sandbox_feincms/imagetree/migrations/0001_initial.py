# encoding: utf-8
import datetime
from south.db import db
from south.v2 import SchemaMigration
from django.db import models

class Migration(SchemaMigration):

    def forwards(self, orm):
        
        # Adding model 'Image'
        db.create_table('imagetree_image', (
            ('id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('description', self.gf('django.db.models.fields.TextField')(null=True, blank=True)),
            ('image', self.gf('django.db.models.fields.files.ImageField')(max_length=100)),
            ('width', self.gf('django.db.models.fields.IntegerField')(default=0)),
            ('heigth', self.gf('django.db.models.fields.IntegerField')(default=0)),
            ('order', self.gf('django.db.models.fields.IntegerField')(default=0)),
        ))
        db.send_create_signal('imagetree', ['Image'])

        # Adding model 'Gallery'
        db.create_table('imagetree_gallery', (
            ('id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('title', self.gf('django.db.models.fields.CharField')(default='Gallery', max_length=40)),
        ))
        db.send_create_signal('imagetree', ['Gallery'])

        # Adding M2M table for field images on 'Gallery'
        db.create_table('imagetree_gallery_images', (
            ('id', models.AutoField(verbose_name='ID', primary_key=True, auto_created=True)),
            ('gallery', models.ForeignKey(orm['imagetree.gallery'], null=False)),
            ('image', models.ForeignKey(orm['imagetree.image'], null=False))
        ))
        db.create_unique('imagetree_gallery_images', ['gallery_id', 'image_id'])


    def backwards(self, orm):
        
        # Deleting model 'Image'
        db.delete_table('imagetree_image')

        # Deleting model 'Gallery'
        db.delete_table('imagetree_gallery')

        # Removing M2M table for field images on 'Gallery'
        db.delete_table('imagetree_gallery_images')


    models = {
        'imagetree.gallery': {
            'Meta': {'object_name': 'Gallery'},
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'images': ('django.db.models.fields.related.ManyToManyField', [], {'to': "orm['imagetree.Image']", 'symmetrical': 'False'}),
            'title': ('django.db.models.fields.CharField', [], {'default': "'Gallery'", 'max_length': '40'})
        },
        'imagetree.image': {
            'Meta': {'object_name': 'Image'},
            'description': ('django.db.models.fields.TextField', [], {'null': 'True', 'blank': 'True'}),
            'heigth': ('django.db.models.fields.IntegerField', [], {'default': '0'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'image': ('django.db.models.fields.files.ImageField', [], {'max_length': '100'}),
            'order': ('django.db.models.fields.IntegerField', [], {'default': '0'}),
            'width': ('django.db.models.fields.IntegerField', [], {'default': '0'})
        }
    }

    complete_apps = ['imagetree']
