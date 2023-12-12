from django.urls import path
from abs_app.views.vehicle_view import add_vehicle, get_vehicle_by_id, get_all_vehicles


urlpatterns = [
    path('vehicle/add/', add_vehicle, name='add_vehicle'),
    path ('vehicle/get', get_vehicle_by_id, name='get_vehicle_by_id'),
    path ('vehicle/get_all/', get_all_vehicles, name='get_all_vehicles'),
]
