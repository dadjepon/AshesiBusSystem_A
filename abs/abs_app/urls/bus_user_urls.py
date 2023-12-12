from django.urls import path
from abs_app.views.bus_user_view import register_and_verify, activate, login, admin_register_and_verify, admin_login


urlpatterns = [
    path('bus_user/register/', register_and_verify, name='register_and_verify'),
    path('bus_user/activate', activate, name='activate'),
    path('bus_user/login/', login, name='login'),
    
    path('bus_user/admin_register/', admin_register_and_verify, name='admin_register_and_verify'),
    path('bus_user/admin_login/', admin_login, name='admin_login'),
]
