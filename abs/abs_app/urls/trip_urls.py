from django.urls import path
from abs_app.views.trip_view import create_trip, get_trip_by_id, get_morning_trips, get_afternoon_trips, get_evening_trips, get_all_trips


urlpatterns = [
    path('trip/create/', create_trip, name='create_trip'),
    path('trip/get', get_trip_by_id, name='get_trip_by_id'),
    path('trip/get_morning_trips/', get_morning_trips, name='get_morning_trips'),
    path('trip/get_afternoon_trips/', get_afternoon_trips, name='get_afternoon_trips'),
    path('trip/get_evening_trips/', get_evening_trips, name='get_evening_trips'),
    path('trip/get_all/', get_all_trips, name='get_all_trips')
]
