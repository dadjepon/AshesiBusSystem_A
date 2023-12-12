from django.http import HttpResponseBadRequest
from abs_app.models import Driver
from abs_app.serializers import DriverSerializer
from rest_framework import status
from rest_framework.response import Response
from rest_framework.decorators import api_view


@api_view(['POST'])
def add_driver (request):
    
    """Add a driver.
    
    Args:
        request (Request): A request object containing the driver

    Returns:
        Response: A response object containing the serialized driver object.
    """
        
    serializer = DriverSerializer(data=request.data)
        
    if serializer.is_valid():
        serializer.save()
        return Response({'message': 'Driver added successfully'}, status=status.HTTP_201_CREATED)
    
    else:
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    

@api_view(['POST'])
def driver_login(request):
        
        """Login a driver.
        
        Args:
            request (Request): A request object containing the driver ID.
    
        Returns:
            Response: A response object containing the serialized driver object.
        """
        
        data = request.data
        
        driver_objects = Driver.objects
        driver_ashesi_id = data.get('driver_ashesi_id')
        
        if driver_ashesi_id is None:
            return HttpResponseBadRequest("Driver ID is required")
        
        driver = driver_objects.get(driver_ashesi_id=driver_ashesi_id)
        
        if driver:
            return Response({'message': 'Driver logged in successfully', 'data': DriverSerializer(driver).data}, status=status.HTTP_200_OK)
        
        return Response({'message': 'Error logging in driver. Try again.'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
    
    
@api_view(['GET'])
def get_driver_by_id(request):
    
    """Get a driver with a given driver ID.
    
    Args:
        request (Request): A request object containing the driver ID.

    Returns:
        Response: A response object containing the serialized driver object.
    """
    
    driver_objects = Driver.objects
    driver_id = request.query_params.get('driver_id')
    
    if driver_id is None:
        return HttpResponseBadRequest("Driver ID is required")
    
    driver = driver_objects.get(driver_id=driver_id)
    
    if driver:
        return Response({'message': 'Driver fetched successfully', 'data': DriverSerializer(driver).data}, status=status.HTTP_200_OK)
    
    return Response({'message': 'Error fetching driver. Try again.'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


@api_view(['GET'])
def get_all_drivers(request):
    
    """Get all drivers.
    
    Args:
        request (Request): A request object containing the driver ID.

    Returns:
        Response: A response object containing the serialized driver object.
        
    """
    
    drivers = Driver.objects.all()
    
    if drivers:
        return Response({'message': 'Drivers fetched successfully', 'data': DriverSerializer(drivers, many=True).data}, status=status.HTTP_200_OK)
    
    return Response({'message': 'No drivers found.'}, status=status.HTTP_404_NOT_FOUND)
    
    
    
    
            