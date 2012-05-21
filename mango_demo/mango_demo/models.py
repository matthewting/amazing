#from tastypie.utils.timezone import now
from django.contrib.auth.models import User
from django.db import models

class MangoUser(models.Model):
    user = models.ForeignKey(User)
    userdata = models.TextField()

    def __unicode__(self, userdata):
        return self.userdata

    def save(self, *args, **kwargs):        
        return super(MangoUser, self).save(*args, **kwargs)
    
