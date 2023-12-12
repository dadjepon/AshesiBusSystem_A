from django.urls import path
from abs_app.views.stop_view import create_stop, get_stop_by_id


urlpatterns = [
    path('stop/create/', create_stop, name='create_stop'),
    path('stop/get', get_stop_by_id, name='get_stop_by_id'),
]
