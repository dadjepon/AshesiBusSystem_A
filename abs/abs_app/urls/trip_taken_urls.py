from django.urls import path
from abs_app.views.trip_taken_view import start_trip, get_all_trips_taken, get_trips_completed_by_driver, get_ongoing_trips, get_ongoing_trips_started_by_driver, get_bus_user_ongoing_trips, get_bus_user_ended_trips, end_trip, delete_trip_taken, get_trip_passengers


urlpatterns = [
    path('trip/start/', start_trip, name='start_trip'),
    
    path('trip/get_all_trips_taken/', get_all_trips_taken, name='get_all_trips_taken'),
    path('trip/get_ongoing_trips/', get_ongoing_trips, name='get_ongoing_trips'),
    
    path('trip/get_trips_completed_by_driver/', get_trips_completed_by_driver, name='get_trips_started_by_driver'),
    path('trip/get_ongoing_trips_started_by_driver', get_ongoing_trips_started_by_driver, name='get_ongoing_trips_started_by_driver'),
    
    path('trip/get_bus_user_ongoing_trips', get_bus_user_ongoing_trips, name='get_bus_user_ongoing_trips'),
    path('trip/get_bus_user_ended_trips', get_bus_user_ended_trips, name='get_bus_user_ended_trips'),
    
    path('trip/get_trip_passengers', get_trip_passengers, name='get_trip_passengers'),
    
    path('trip/end/', end_trip, name='end_trip'),
    path('trip/delete/', delete_trip_taken, name='delete_trip_taken'),
]
