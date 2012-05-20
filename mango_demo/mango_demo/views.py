from django.shortcuts import render_to_response
from mango_demo.api.resources import UserResource

def user_detail(request, username):
    ur = UserResource()
    user = ur.obj_get(username=username)
        
    ur_bundle = ur.build_bundle(obj=user, request=request)
    return render_to_response('mango_demo/user_detail.html', {
        # Other things here.
        "user_json": ur.serialize(None, ur.full_dehydrate(ur_bundle), 'application/json'),
    })

