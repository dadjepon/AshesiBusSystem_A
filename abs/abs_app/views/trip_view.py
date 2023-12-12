from datetime import datetime, time 
from django.http import HttpResponse, HttpResponseBadRequest, HttpRequest
from abs_app.models import Trip
from abs_app.serializers import TripSerializer
from rest_framework import status
from rest_framework.response import Response
from rest_framework.decorators import api_view


@api_view(['POST'])
def create_trip (request):
        
    """Create a trip.
    
    Args:
        request (Request): A request object containing the trip name.

    Returns:
        Response: A response object containing the serialized trip object.
    """
        
    serializer = TripSerializer(data=request.data)
        
    if serializer.is_valid():
        serializer.save()
        return Response({'message': 'Trip created successfully'}, status=status.HTTP_201_CREATED)
    
    else:
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)        


@api_view(['GET'])
def get_trip_by_id(request):
    
    """Get a trip with a given stop ID.
    
    Args:
        request (Request): A request object containing the trip ID.

    Returns:
        Response: A response object containing the serialized trip object.
    """
    
    trip_objects = Trip.objects
    trip_id = request.query_params.get('trip_id')
    
    if trip_id is None:
        return HttpResponseBadRequest("Trip ID is required")
        
    trip = trip_objects.get(trip_id=trip_id)
        
    if trip:
        return Response({'message': 'Trip fetched successfully', 'data': TripSerializer(trip).data}, status=status.HTTP_200_OK)
        
    return Response({'message': 'Error fetching trip. Try again.'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


@api_view(['GET'])
def get_all_trips(request):
    
    """Get all trips.
    
    Returns:
        Response: A response object containing the serialized trip object.
    """
    
    trips = Trip.objects.all()
    
    if trips:
        return Response({'message': 'Trips fetched successfully', 'data': TripSerializer(trips, many=True).data}, status=status.HTTP_200_OK)
    
    return Response({'message': 'Error fetching trips. Try again.'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
    

    

@api_view(['GET'])
def get_morning_trips(request):
    
    """Get all trips whose start time is before 12pm.
    
    Args:
        request (Request): A request object containing the trip ID.

    Returns:
        Response: A response object containing the serialized trip object.
    """
    
    
    # Get all trips whose start time is before 12pm
    morning_trips = Trip.objects.filter(trip_start_time__lt=time(12, 0, 0))
    
    if morning_trips:
        return Response({'message': 'Morning trips fetched successfully', 'data': TripSerializer(morning_trips, many=True).data}, status=status.HTTP_200_OK)
    
    return Response({'message': 'Error fetching morning trips. Try again.'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


@api_view(['GET'])
def get_afternoon_trips(request):
    
    """Get all trips whose start time is after 12pm.
    
    Args:
        request (Request): A request object containing the trip ID.

    Returns:
        Response: A response object containing the serialized trip object.
    """
    
    
    # Get all trips whose start time is after 12pm
    afternoon_trips = Trip.objects.filter(trip_start_time__gte=time(12, 0, 0))
    
    if afternoon_trips:
        return Response({'message': 'Afternoon trips fetched successfully', 'data': TripSerializer(afternoon_trips, many=True).data}, status=status.HTTP_200_OK)
    
    return Response({'message': 'Error fetching afternoon trips. Try again.'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


@api_view(['GET'])
def get_evening_trips(request):
    
    """Get all trips whose start time is after 5pm.
    
    Args:
        request (Request): A request object containing the trip ID.

    Returns:
        Response: A response object containing the serialized trip object.
    """
    
    
    # Get all trips whose start time is after 5pm
    evening_trips = Trip.objects.filter(trip_start_time__gte=time(17, 0, 0))
    
    if evening_trips:
        return Response({'message': 'Evening trips fetched successfully', 'data': TripSerializer(evening_trips, many=True).data}, status=status.HTTP_200_OK)
    
    return Response({'message': 'Error fetching evening trips. Try again.'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
    






