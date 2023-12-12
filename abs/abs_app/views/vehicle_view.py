from django.http import HttpResponse, HttpResponseBadRequest
from abs_app.models import Vehicle
from abs_app.serializers import VehicleSerializer
from rest_framework import status
from rest_framework.response import Response
from rest_framework.decorators import api_view


@api_view(['POST'])
def add_vehicle (request):
    
    """Add a vehicle.
    
    Args:
        request (Request): A request object containing the vehicle.

    Returns:
        Response: A response object containing the serialized vehicle object.
    """
        
    serializer = VehicleSerializer(data=request.data)
        
    if serializer.is_valid():
        serializer.save()
        return Response({'message': 'Vehicle added successfully'}, status=status.HTTP_201_CREATED)
    
    else:
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
    
@api_view(['GET'])
def get_vehicle_by_id(request):
    
    """Get a vehicle with a given vehicle ID.
    
    Args:
        request (Request): A request object containing the vehicle ID.

    Returns:
        Response: A response object containing the serialized vehicle object.
    """
    
    vehicle_objects = Vehicle.objects
    vehicle_id = request.query_params.get('vehicle_id')
    
    if vehicle_id is None:
        return HttpResponseBadRequest("Vehicle ID is required")
    
    vehicle = vehicle_objects.get(vehicle_id=vehicle_id)
    
    if vehicle:
        return Response({'message': 'Vehicle fetched successfully', 'data': VehicleSerializer(vehicle).data}, status=status.HTTP_200_OK)
    
    return Response({'message': 'Error fetching vehicle. Try again.'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


@api_view(['GET'])
def get_all_vehicles(request):
    
    """Get all vehicles.
    
    Args:
        request (Request): A request object.

    Returns:
        Response: A response object containing the serialized vehicle objects.
    """
    
    vehicles = Vehicle.objects.all()
    
    if vehicles:
        return Response({'message': 'Vehicles fetched successfully', 'data': VehicleSerializer(vehicles, many=True).data}, status=status.HTTP_200_OK)
    
    return Response({'message': 'Error fetching vehicles. Try again.'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
    
    
    
    
            