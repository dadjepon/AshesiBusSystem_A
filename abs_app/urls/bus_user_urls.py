from django.urls import path
from abs_app.views.bus_user_view import register_and_verify, activate, login


urlpatterns = [
    path('bus_user/register/', register_and_verify, name='register_and_verify'),
    path('bus_user/activate/', activate, name='activate'),
    path('bus_user/login/', login, name='login'),
]
