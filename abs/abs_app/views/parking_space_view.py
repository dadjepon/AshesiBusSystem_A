from django.http import HttpResponseBadRequest
from abs_app.models import Driver, ParkingSpace, Vehicle
from abs_app.serializers import ParkingSpaceSerializer, VehicleSerializer
from rest_framework import status
from rest_framework.response import Response
from rest_framework.decorators import api_view


@api_view(['POST'])
def create_parking_space(request):
    
    """Create a parking space
    
    Args: 
        request(Request): A request object containing the name of the parking space.

    Returns:
        response(Response): A response containing a message indicating whether the request was successful or not.
        
    """
    
    serializer = ParkingSpaceSerializer(data=request.data)
    
    if serializer.is_valid():
        serializer.save()
        return Response({'message': 'Parking space created successfully'}, status=status.HTTP_201_CREATED)
    
    else:
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)  
        
        
        
    

@api_view(['GET'])
def get_all_parking_spaces(request):
    
    """Get all parking spaces


    Returns:
        Response: A response object containing the serialized parking space objects.
    """
    
    parking_spaces = ParkingSpace.objects.all()

    try:
        
        if parking_spaces:
            serialized_data = []
            for parking_space in parking_spaces:
                
                if parking_space.vehicle_id is None:
                    data = {
                        'parking_space_id': parking_space.parking_space_id,
                        'parking_space_name': parking_space.parking_space_name,
                        'vehicle_id': None,
                        'vehicle_name': None,
                        'license_no': None,
                        'model': None
                    }
                    
                else: 
                    data = {
                        'parking_space_id': parking_space.parking_space_id,
                        'parking_space_name': parking_space.parking_space_name,
                        'vehicle_id': parking_space.vehicle_id,
                        'vehicle_name': parking_space.vehicle.vehicle_name,
                        'license_no': parking_space.vehicle.license_no,
                        'model': parking_space.vehicle.model
                    }
                
                serialized_data.append(data)
            
            return Response({'message': 'Parking spaces retrieved successfully', 'data': serialized_data}, status=status.HTTP_200_OK)
        
        return Response({'message': 'No parking spaces found'}, status=status.HTTP_404_NOT_FOUND)
    
    except Exception as e:
        return Response({'message': 'Error fetching parking spaces. Try again.'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
    
    
@api_view(['GET'])
def get_empty_parking_spaces(request):
    
    """Get all available parking spaces


    Returns:
        Response: A response object containing the serialized parking space objects.
    """
    
    parking_spaces = ParkingSpace.objects.all()

    try:
        
        if parking_spaces:
            serialized_data = []
            for parking_space in parking_spaces:
                
                if parking_space.vehicle_id is None:
                    
                    data = {
                        
                        'parking_space_id': parking_space.parking_space_id,
                        'parking_space_name': parking_space.parking_space_name,
                        'vehicle_id': None,
                        'vehicle_name': None,
                        'license_no': None,
                        'model': None
                    }
                
                serialized_data.append(data)
            
            return Response({'message': 'Empty parking spaces retrieved successfully', 'data': serialized_data}, status=status.HTTP_200_OK)
        
        return Response({'message': 'No empty parking spaces found'}, status=status.HTTP_404_NOT_FOUND)
    
    except Exception as e:
        return Response({'message': 'Error fetching empty parking spaces. Try again.'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


@api_view(['GET'])
def get_vehicles_parked(request):
        
        """Get all cars parked in parking spaces
    
    
        Returns:
            Response: A response object containing the serialized vehicle objects.
        """
        
        parking_spaces = ParkingSpace.objects.all()
        
        try:
            
            if parking_spaces:
                serialized_data = []
                
                for parking_space in parking_spaces:    
                    data = {
                        'parking_space_id': parking_space.parking_space_id,
                        'parking_space_name': parking_space.parking_space_name,
                        'time_parked': parking_space.time_parked,
                        'vehicle_id': parking_space.vehicle_id,
                        'vehicle_name': parking_space.vehicle.vehicle_name,
                        'license_no': parking_space.vehicle.license_no,
                        'model': parking_space.vehicle.model
                    }
                    
                    serialized_data.append(data)
                
                return Response({'message': 'All vehicles parked retrieved successfully', 'data': serialized_data}, status=status.HTTP_200_OK)
            
            return Response({'message': 'No vehicles parked'}, status=status.HTTP_404_NOT_FOUND)
        
        except Exception as e:
            return Response({'message': 'Error fetching vehicles parked. Try again.'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

@api_view(['PATCH'])
def park_vehicle(request):
        
        """Park a vehicle in a parking space
        
        Args:
            request (Request): A request object containing the vehicle ID and the parking space ID.
    
        Returns:
            Response: A response object containing a message indicating whether the vehicle was parked successfully or not.
        """
        
        data = request.data
        parking_space_id = data.get('parking_space_id')
        vehicle_id = data.get('vehicle_id')
        
        parking_space = ParkingSpace.objects.get(parking_space_id=parking_space_id)
        vehicle = Vehicle.objects.get(vehicle_id=vehicle_id)
        
        if parking_space is None:
            return HttpResponseBadRequest("Parking space does not exist")
        
        if vehicle is None:
            return HttpResponseBadRequest("Vehicle does not exist")
        
        parking_space.vehicle_id = vehicle_id
        parking_space.save()
        
        return Response({'message': 'Vehicle parked successfully'}, status=status.HTTP_200_OK)
    
    
@api_view(['PATCH'])
def unpark_vehicle(request):
        
        """Unpark a vehicle in a parking space
        
        Args:
            request (Request): A request object containing the parking space ID.
    
        Returns:
            Response: A response object containing a message indicating whether the vehicle was unparked successfully or not.
        """
        
        data = request.data
        parking_space_id = data.get('parking_space_id')
        
        parking_space = ParkingSpace.objects.get(parking_space_id=parking_space_id)
        
        if parking_space is None:
            return HttpResponseBadRequest("Parking space does not exist")
        
        parking_space.vehicle_id = None
        parking_space.save()
        
        return Response({'message': 'Vehicle unparked successfully'}, status=status.HTTP_200_OK)
    
