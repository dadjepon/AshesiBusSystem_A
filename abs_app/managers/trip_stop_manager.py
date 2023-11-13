from django.db import models
from django.http import HttpResponseBadRequest, HttpResponse
from rest_framework.response import Response



# TRIP STOP
class TripStopManager(models.Manager):
    
    def get_stops_for_trip(self, trip_id):
        
        """Get the stops for a trip with a given trip ID.

        Args:
            trip_id (int): The ID of the trip.

        Returns:
            QuerySet: A queryset containing dictionaries with fields from the related Trip and Stop models.
        """
        return self.filter(trip__tripId=trip_id).values('trip__', 'stop__')

    def get_all_trips_and_stops(self):
        
        """Get all trips and their associated stops.

        Returns:
            QuerySet: A queryset containing dictionaries with fields from the related Trip and Stop models for all TripStop instances.
        """
        return self.all().values('trip__', 'stop__')


