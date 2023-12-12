from django.urls import path
from abs_app.views.driver_view import add_driver, driver_login, get_driver_by_id, get_all_drivers


urlpatterns = [
    path('driver/add/', add_driver, name='add_driver'),
    path('driver/login/', driver_login, name='driver_login'),
    path('driver/get', get_driver_by_id, name='get_driver_by_id'),
    path('driver/get_all/', get_all_drivers, name='get_all_drivers')
]
