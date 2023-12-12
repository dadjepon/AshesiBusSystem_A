from django.urls import path
from abs_app.views.trip_stop_view import add_stop_to_trip, get_stops_for_trip, get_all_trips_and_stops


urlpatterns = [
    path('trip/add_stop_to_trip/', add_stop_to_trip, name='add_stop_to_trip'),
    path('trip/get_stops_for_trip', get_stops_for_trip, name='get_stops_for_trip'),
    path('trip/get_trips_and_stops/', get_all_trips_and_stops, name='get_all_trips_and_stops'),
]
