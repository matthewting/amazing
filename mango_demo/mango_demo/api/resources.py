from django.contrib.auth.models import User
from tastypie.authorization import Authorization
from tastypie.resources import ModelResource
from mango_demo.models import Entry

class UserResource(ModelResource):
    class Meta:
        queryset = User.objects.all()
        resource_name = 'user'        
    

class EntryResource(ModelResource):
    class Meta:
        queryset = Entry.objects.all()
        resource_name = 'entry'
        
#        authorization = Authorization()
#        allowed_methods = ['get','post']
        