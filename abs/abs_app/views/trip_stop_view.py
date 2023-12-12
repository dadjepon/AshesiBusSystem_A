from django.http import HttpResponse, HttpResponseBadRequest
from abs_app.models import TripStop, Trip, Stop
from abs_app.serializers import TripStopSerializer
from rest_framework import status
from rest_framework.response import Response
from rest_framework.decorators import api_view


@api_view(['POST'])
def add_stop_to_trip(request):
    
    """Add a stop to a trip
    
    Args:
        request (Request): A request object containing the trip ID and stop ID.

    Returns:
        Response: A response object containing the serialized trip-stop object.
    """
    
    data = request.data
    
    trip_id = data.get('trip')
    stop_id = data.get('stop')
    
    trip = Trip.objects.get(trip_id=trip_id)
    stop = Stop.objects.get(stop_id=stop_id)
    
    if trip is None or stop is None:
        return Response({'message': 'Trip or stop does not exist'}, status=status.HTTP_400_BAD_REQUEST)

    trip_stop_data = request.data
    serializer = TripStopSerializer(data=trip_stop_data)

    if serializer.is_valid():
        serializer.save()
        return Response({'message': 'Stop added to trip successfully'}, status=status.HTTP_201_CREATED)
    
    else:
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(['GET'])
def get_stops_for_trip(request):
    
    """Get all stops for a trip
    
    Args:
        request (Request): A request object containing the trip ID.

    Returns:
        Response: A response object containing the serialized trip-stop object.
    """
    
    trip_id = request.query_params.get('trip_id')

    if trip_id is None:
        return HttpResponseBadRequest("Trip ID is required")

    try:
        stops = TripStop.objects.filter(trip__trip_id=trip_id)
        if stops:
            serialized_data = []
            for stop in stops:
                data = {
                    'trip_id': stop.trip.trip_id,
                    'trip_name': stop.trip.trip_name,
                    'trip_start_time': stop.trip.trip_start_time,
                    'trip_end_time': stop.trip.trip_end_time,
                    'stop_id': stop.stop.stop_id,
                    'stop_name': stop.stop.stop_name,
                    'price': stop.stop.price,
                }
                serialized_data.append(data)

            return Response({'message': 'Stops fetched successfully', 'data': serialized_data}, status=status.HTTP_200_OK)
        
        else:
            return Response({'message': 'No stops found for the given trip.'}, status=status.HTTP_404_NOT_FOUND)
        
    except Exception as e:
        
        return Response({'message': 'Error fetching stops for trip. Try again.'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


@api_view(['GET'])
def get_all_trips_and_stops(request):
    """Get all trips and stops

    Args:
        request (Request): A request object.

    Returns:
        Response: A response object containing the serialized trip-stop objects.
    """
    trip_stops = TripStop.objects.all()
    
    try: 
    
        if trip_stops:
            serialized_data = []
            for trip_stop in trip_stops:
                data = {
                    'trip_id': trip_stop.trip.trip_id,
                    'trip_name': trip_stop.trip.trip_name,
                    'stop_id': trip_stop.stop.stop_id,
                    'stop_name': trip_stop.stop.stop_name,
                }
                serialized_data.append(data)

            return Response({'message': 'Trips and stops fetched successfully', 'data': serialized_data}, status=status.HTTP_200_OK)
        
        return Response({'message': 'No trips and stops found.'}, status=status.HTTP_404_NOT_FOUND)

    except Exception as e:
            return Response({'message': 'Error fetching trips and stops. Try again.'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)






