from django.contrib.auth.models import User
from tastypie.resources import ModelResource, ALL, ALL_WITH_RELATIONS
from django.db import IntegrityError
from tastypie.exceptions import BadRequest
from tastypie.authentication import BasicAuthentication
from tastypie.authorization import DjangoAuthorization
from tastypie.authentication import Authentication
from tastypie.authorization import Authorization
from tastypie.serializers import Serializer

class SillyAuthentication(Authentication):
    def is_authenticated(self, request, **kwargs):        
        return True        

    # Optional but recommended
    #def get_identifier(self, request):
    #    return request.user.username
    
class SillyAuthorization(Authorization):
    def is_authorized(self, request, object=None):
        return True
    
    # Optional but useful for advanced limiting, such as per user.
    #def apply_limits(self, request, object_list):
    #    if request and hasattr(request, 'user'):
    #        return object_list.filter(author__username=request.user.username)
    #
    #    return object_list.none()

from mango_demo.models import MangoUser
class MangoUserResource(ModelResource):
    class Meta:
        queryset = MangoUser.objects.all()
        resource_name = 'mangouser'
        serializer = Serializer(formats=['json'])
        authentication = SillyAuthentication()
        authorization = SillyAuthorization()              

    def obj_create(self, bundle, request=None, **kwargs):            
        username = bundle.data['username']
        password = bundle.data['password']
        email =  bundle.data['email']
        userdata =  bundle.data['userdata']
        
        print username
        print password
        print email
        
        try:
            bundle.obj = MangoUser(userdata=userdata)
            bundle.obj.user = User.objects.create_user(username, email, password)
            bundle.obj.user.set_password(password)
            bundle.obj.user.save()
            bundle.obj.save()
        except IntegrityError:                
            raise BadRequest('That username already exists!!!')
        return bundle    

class UserResource(ModelResource):    
    class Meta:
        queryset = User.objects.all()
        resource_name = 'user'
        serializer = Serializer(formats=['json'])  
        filtering = {
            'username': ALL,
        }                            
        authentication = SillyAuthentication()
        authorization = SillyAuthorization()              

    def obj_create(self, bundle, request=None, **kwargs):            
        username = bundle.data['username']
        password = bundle.data['password']
        email =  bundle.data['email']
        
        print username
        print password
        print email
        
        try:
            bundle.obj = User.objects.create_user(username, email, password)
            bundle.obj.set_password(password)
            bundle.obj.save()
        except IntegrityError:                
            raise BadRequest('That username already exists!!!')
        return bundle


        