#from django.conf.urls import patterns, include, url
from django.conf.urls.defaults import *
from django.views.generic.simple import direct_to_template

from tastypie.api import Api
from mango_demo.api.resources import UserResource
from mango_demo.api.resources import EntryResource

v1_api = Api(api_name='v1')
v1_api.register(UserResource())

v2_api = Api(api_name='v2')
v2_api.register(EntryResource())

# Uncomment the next two lines to enable the admin:
from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('',
    # api    
    url(r'^api/', include(v1_api.urls)),
    url(r'^api/', include(v2_api.urls)),
    
    # Examples:
    # url(r'^$', 'mango_demo.views.home', name='home'),
    # url(r'^mango_demo/', include('mango_demo.foo.urls')),

    # Uncomment the admin/doc line below to enable admin documentation:
    # url(r'^admin/doc/', include('django.contrib.admindocs.urls')),

    # Uncomment the next line to enable the admin:
    url(r'^admin/', include(admin.site.urls)),
    #url(r'^admin/(.*)', include(admin.site.root)),
    url(r'^accounts/', include('registration.backends.simple.urls')),
    url(r'^$', direct_to_template,
            { 'template': 'index.html' }, 'index'),
)
