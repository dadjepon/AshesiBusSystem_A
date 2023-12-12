from django.urls import path
from abs_app.views.parking_space_view import create_parking_space, get_all_parking_spaces, get_vehicles_parked, get_empty_parking_spaces, park_vehicle, unpark_vehicle


urlpatterns = [
    path('parking_space/create/', create_parking_space, name='create_parking_space'),
    path('parking_space/get_all/', get_all_parking_spaces, name='get_all_parking_spaces'),
    path('parking_space/park_vehicle/', park_vehicle, name='park_vehicle'),
    path('parking_space/unpark_vehicle/', unpark_vehicle, name='unpark_vehicle'),
    path('parking_space/get_vehicles_parked/', get_vehicles_parked, name='get_vehicles_parked'),
    path('parking_space/get_empty_parking_spaces/', get_empty_parking_spaces, name='get_empty_parking_spaces')
]
