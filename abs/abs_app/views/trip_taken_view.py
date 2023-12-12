from django.http import HttpResponse, HttpResponseBadRequest, HttpRequest
from abs_app.models import Payment, TripTaken, Trip, Vehicle, Driver
from abs_app.serializers import TripTakenSerializer
from rest_framework import status
from rest_framework.response import Response
from rest_framework.decorators import api_view
from django.utils import timezone
from rest_framework.request import Request




@api_view(['POST'])
def start_trip(request):
    
    """Start a trip
    
    Args:
        request (Request): A request object containing the trip ID, vehicle ID, driver ID, and date/time started.

    Returns:
        Response: A response object containing the serialized trip-stop object.
    """
    
    data = request.data
    
    trip_id = data.get('trip')
    vehicle_id = data.get('vehicle')
    driver_id = data.get('driver')

    trip = Trip.objects.get(trip_id=trip_id)
    vehicle = Vehicle.objects.get(vehicle_id=vehicle_id)
    driver = Driver.objects.get(driver_id=driver_id)
    
    
    if trip is None or vehicle is None or driver is None:
        return Response({'message': 'Trip, vehicle, or driver does not exist'}, status=status.HTTP_400_BAD_REQUEST)
    
    try: 
    
        trips_taken = TripTaken.objects
        
        trips_taken.create(trip_id=trip_id, vehicle_id=vehicle_id, driver_id=driver_id)
        
        return Response({'message': 'Trip started successfully'}, status=status.HTTP_201_CREATED)
    
    except Exception as e:
        
        return Response({'message': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
    
    
@api_view(['GET'])
def get_all_trips_taken(request):
    
    try:
        trips_taken = TripTaken.objects.all()

        if trips_taken:
            serialized_data = []
            for trip_taken in trips_taken:
                
                no_of_passengers = Payment.objects.filter(trip_taken_id=trip_taken.trip_taken_id).count()
                
                data = {
                    'trip_taken_id': trip_taken.trip_taken_id,
                    'trip_id': trip_taken.trip.trip_id,
                    'trip_name': trip_taken.trip.trip_name,
                    'vehicle_id': trip_taken.vehicle.vehicle_id,
                    'license_no': trip_taken.vehicle.license_no,
                    'driver_id': trip_taken.driver.driver_id,
                    'fname': trip_taken.driver.fname,
                    'lname': trip_taken.driver.lname,
                    'date_time_started': trip_taken.date_time_started,
                    'date_time_ended': trip_taken.date_time_ended,
                    'has_ended': trip_taken.has_ended,
                    'has_started': trip_taken.has_started,
                    'no_of_passengers': no_of_passengers,
                }
                serialized_data.append(data)

            return Response({'message': 'Trips taken fetched successfully', 'data': serialized_data}, status=status.HTTP_200_OK)

        return Response({'message': 'No trips taken found.'}, status=status.HTTP_404_NOT_FOUND)

    except Exception as e:
        return Response({'message': f'Error fetching trips taken. {str(e)}'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
    




@api_view(['GET'])
def get_ongoing_trips(request):
    
    """Get all ongoing trips taken

    Returns:
        Response: A response object containing all the serialized ongoing trip-taken objects.
    """
        
    trips_taken = TripTaken.objects.filter(
        has_started=True,
        has_ended=False,
        date_time_ended=None,
    )
    
    try:
    
        if trips_taken:
            serialized_data = []
            for trip_taken in trips_taken:
                
                no_of_passengers = Payment.objects.filter(trip_taken_id=trip_taken.trip_taken_id).count()
                
                data = {
                    'trip_taken_id': trip_taken.trip_taken_id,
                    'trip_id': trip_taken.trip.trip_id,
                    'trip_name': trip_taken.trip.trip_name,
                    'vehicle_id': trip_taken.vehicle.vehicle_id,
                    'vehicle_name': trip_taken.vehicle.vehicle_name,
                    'license_no': trip_taken.vehicle.license_no,
                    'driver_id': trip_taken.driver.driver_id,
                    'fname': trip_taken.driver.fname,
                    'lname': trip_taken.driver.lname,
                    'date_time_started': trip_taken.date_time_started,
                    'date_time_ended': trip_taken.date_time_ended,
                    'trip_start_time': trip_taken.trip.trip_start_time,
                    'trip_end_time': trip_taken.trip.trip_end_time,
                    'has_ended': trip_taken.has_ended,
                    'has_started': trip_taken.has_started,
                    'no_of_passengers': no_of_passengers,
                }
                
                serialized_data.append(data)

            return Response({'message': 'Ongoing trips fetched successfully', 'data': serialized_data}, status=status.HTTP_200_OK)
        
        return Response({'message': 'No ongoing trips found.'}, status=status.HTTP_404_NOT_FOUND)
    
    except Exception as e:
        
        return Response({'message': 'Error fetching ongoing trips taken. Try again.'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
    
    
@api_view(['GET'])
def get_ongoing_trips_started_by_driver(request):
        
        """Get all ongoing trips started by a driver
        
        Args: request (Request): A request object containing the driver ID.
    
        Returns:
            Response: A response object containing all the serialized ongoing trip-taken objects created by a particular driver.
        """
        
        driver_id = request.query_params.get('driver_id')
        
        if driver_id is None:
            return Response({'message': 'Driver ID is required'}, status=status.HTTP_400_BAD_REQUEST)
        
        try:
                    
            trips_taken = TripTaken.objects.filter(
                has_started=True,
                has_ended=False,
                date_time_ended=None,
                driver_id=driver_id
            )
            
            if trips_taken:
                serialized_data = []
                for trip_taken in trips_taken:
                    
                    no_of_passengers = Payment.objects.filter(trip_taken_id=trip_taken.trip_taken_id).count()
                    
                    data = {
                        'trip_taken_id': trip_taken.trip_taken_id,
                        'trip_id': trip_taken.trip.trip_id,
                        'trip_name': trip_taken.trip.trip_name,
                        'vehicle_id': trip_taken.vehicle.vehicle_id,
                        'vehicle_name': trip_taken.vehicle.vehicle_name,
                        'license_no': trip_taken.vehicle.license_no,
                        'driver_id': trip_taken.driver.driver_id,
                        'fname': trip_taken.driver.fname,
                        'lname': trip_taken.driver.lname,
                        'date_time_started': trip_taken.date_time_started,
                        'date_time_ended': trip_taken.date_time_ended,
                        'trip_start_time': trip_taken.trip.trip_start_time,
                        'trip_end_time': trip_taken.trip.trip_end_time,
                        'has_ended': trip_taken.has_ended,
                        'has_started': trip_taken.has_started,
                        'no_of_passengers': no_of_passengers,
                    }
                    
                    serialized_data.append(data)
    
                return Response({'message': 'Ongoing trips fetched successfully', 'data': serialized_data}, status=status.HTTP_200_OK)
            
            return Response({'message': 'No ongoing trips found.'}, status=status.HTTP_404_NOT_FOUND)
        
        except Exception as e:
            
            return Response({'message': 'Error fetching ongoing trips taken. Try again.'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
    
    
@api_view(['GET'])
def get_trips_completed_by_driver(request):
    
    """Get all trips started by a driver
    
    Args: request (Request): A request object containing the driver ID.

    Returns:
        Response: A response object containing all the serialized objects of trips taken that were started by a particular driver.
    """
    
    
    driver_id = request.query_params.get('driver_id')
    
    if driver_id is None:
        return Response({'message': 'Driver ID is required'}, status=status.HTTP_400_BAD_REQUEST)
    
    try:
            
        trips_taken = TripTaken.objects.filter(driver_id=driver_id, has_ended=True, date_time_ended__isnull=False)
            
        if trips_taken:
            serialized_data = []
            for trip_taken in trips_taken:
                
                no_of_passengers = Payment.objects.filter(trip_taken_id=trip_taken.trip_taken_id).count()
                
                data = {
                    'trip_taken_id': trip_taken.trip_taken_id,
                    'trip_id': trip_taken.trip.trip_id,
                    'trip_name': trip_taken.trip.trip_name,
                    'vehicle_id': trip_taken.vehicle.vehicle_id,
                    'vehicle_name': trip_taken.vehicle.vehicle_name,
                    'license_no': trip_taken.vehicle.license_no,
                    'driver_id': trip_taken.driver.driver_id,
                    'fname': trip_taken.driver.fname,
                    'lname': trip_taken.driver.lname,
                    'date_time_started': trip_taken.date_time_started,
                    'date_time_ended': trip_taken.date_time_ended,
                    'has_ended': trip_taken.has_ended,
                    'has_started': trip_taken.has_started,
                    'no_of_passengers': no_of_passengers,
                }
                
                serialized_data.append(data)

            return Response({'message': 'Trips started by driver fetched successfully', 'data': serialized_data}, status=status.HTTP_200_OK)
        
        return Response({'message': 'No trips started found.'}, status=status.HTTP_404_NOT_FOUND)
        
    except Exception as e:
            
            return Response({'message': 'Error fetching trips started by driver. Try again.'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        

        
        
@api_view(['GET'])
def get_bus_user_ended_trips(request):
    
    """Get all trips taken by a bus user
    
    Args: request (Request): A request object containing the bus user ID.

    Returns:
        Response: A response object containing all the serialized objects of trips taken by a particular bus user.
    """
    
    bus_user_id = request.query_params.get('bus_user_id')
    
    if bus_user_id is None:
        return Response({'message': 'Bus user ID is required'}, status=status.HTTP_400_BAD_REQUEST)
    
    try:
        
        payment_objects = Payment.objects
        
        trips_paid_for = payment_objects.filter(bus_user_id=bus_user_id, trip_taken__has_ended=True, trip_taken__date_time_ended__isnull=False)
            
        if trips_paid_for:
            serialized_data = []
            for trip_paid_for in trips_paid_for:
                
                no_of_passengers = Payment.objects.filter(trip_taken_id=trip_paid_for.trip_taken.trip_taken_id).count()
                
                data = {
                    'trip_taken_id': trip_paid_for.trip_taken.trip_taken_id,
                    'trip_id': trip_paid_for.trip_taken.trip.trip_id,
                    'trip_name': trip_paid_for.trip_taken.trip.trip_name,
                    'vehicle_id': trip_paid_for.trip_taken.vehicle.vehicle_id,
                    'vehicle_name': trip_paid_for.trip_taken.vehicle.vehicle_name,
                    'license_no': trip_paid_for.trip_taken.vehicle.license_no,
                    'driver_id': trip_paid_for.trip_taken.driver.driver_id,
                    'stop_name': trip_paid_for.stop.stop_name,
                    'fname': trip_paid_for.trip_taken.driver.fname,
                    'lname': trip_paid_for.trip_taken.driver.lname,
                    'date_time_started': trip_paid_for.trip_taken.date_time_started,
                    'date_time_ended': trip_paid_for.trip_taken.date_time_ended,
                    'has_ended': trip_paid_for.trip_taken.has_ended,
                    'has_started': trip_paid_for.trip_taken.has_started,
                    'amount': trip_paid_for.amount,
                    'ref': trip_paid_for.ref,
                    'payment_date_time': trip_paid_for.payment_date_time,
                    'no_of_passengers': no_of_passengers,
                }
                
                serialized_data.append(data)

            return Response({'message': 'Trips taken by bus user fetched successfully', 'data': serialized_data}, status=status.HTTP_200_OK)
         
        
        return Response({'message': 'No trips have been taken by this bus user.'}, status=status.HTTP_404_NOT_FOUND)
        
    except Exception as e:
            
            return Response({'message': 'Error fetching trips taken by bus user. Try again.'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

@api_view(['GET']) 
def get_trip_passengers(request):
    
    """Get all passengers on a trip
    
    Args: request (Request): A request object containing the trip taken ID.

    Returns:
        Response: A response object containing all the serialized objects of passengers on a particular trip.
    """
    
    trip_taken_id = request.query_params.get('trip_taken_id')
    
    if trip_taken_id is None:
        return Response({'message': 'Trip taken ID is required'}, status=status.HTTP_400_BAD_REQUEST)
    
    try:
        
        payment_objects = Payment.objects
        
        passengers = payment_objects.filter(trip_taken_id=trip_taken_id)
            
        if passengers:
            serialized_data = []
            for passenger in passengers:
                
                data = {
                    'payment_id': passenger.payment_id,
                    'bus_user_id': passenger.bus_user.bus_user_id,
                    'fname': passenger.bus_user.fname,
                    'lname': passenger.bus_user.lname,
                    'ashesi_id': passenger.bus_user.ashesi_id,
                    'ashesi_email': passenger.bus_user.ashesi_email,
                    'momo_no': passenger.bus_user.momo_no,
                    'amount': passenger.amount,
                    'ref': passenger.ref,
                    'payment_date_time': passenger.payment_date_time,
                }
                
                serialized_data.append(data)

            return Response({'message': 'Passengers fetched successfully', 'data': serialized_data}, status=status.HTTP_200_OK)
         
        
        return Response({'message': 'No passengers found.'}, status=status.HTTP_404_NOT_FOUND)
        
    except Exception as e:
            
            return Response({'message': 'Error fetching passengers. Try again.'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        
        
@api_view(['GET'])
def get_bus_user_ongoing_trips(request):
    
    """Get all trips the bus user is currently on
    
    Args: request (Request): A request object containing the bus user ID.

    Returns:
        Response: A response object containing all the serialized objects of trips the bus user is currently on.
    """
    
    bus_user_id = request.query_params.get('bus_user_id')
    
    if bus_user_id is None:
        return Response({'message': 'Bus user ID is required'}, status=status.HTTP_400_BAD_REQUEST)
    
    try:
        
        payment_objects = Payment.objects
        
        trips_paid_for = payment_objects.filter(bus_user_id=bus_user_id, trip_taken__has_ended=False, trip_taken__date_time_ended__isnull=True)
        
            
        if trips_paid_for:
            serialized_data = []
            for trip_paid_for in trips_paid_for:
                
                no_of_passengers = Payment.objects.filter(trip_taken_id=trip_paid_for.trip_taken.trip_taken_id).count()
                
                data = {
                    'trip_taken_id': trip_paid_for.trip_taken.trip_taken_id,
                    'trip_id': trip_paid_for.trip_taken.trip.trip_id,
                    'trip_name': trip_paid_for.trip_taken.trip.trip_name,
                    'vehicle_id': trip_paid_for.trip_taken.vehicle.vehicle_id,
                    'vehicle_name': trip_paid_for.trip_taken.vehicle.vehicle_name,
                    'license_no': trip_paid_for.trip_taken.vehicle.license_no,
                    'driver_id': trip_paid_for.trip_taken.driver.driver_id,
                    'stop_name': trip_paid_for.stop.stop_name,
                    'fname': trip_paid_for.trip_taken.driver.fname,
                    'lname': trip_paid_for.trip_taken.driver.lname,
                    'date_time_started': trip_paid_for.trip_taken.date_time_started,
                    'trip_start_time': trip_paid_for.trip_taken.trip.trip_start_time,
                    'trip_end_time': trip_paid_for.trip_taken.trip.trip_end_time,
                    'amount': trip_paid_for.amount,
                    'ref': trip_paid_for.ref,
                    'payment_date_time': trip_paid_for.payment_date_time,
                    'no_of_passengers': no_of_passengers,
                }
                
                serialized_data.append(data)

            return Response({'message': 'Trips taken by bus user fetched successfully', 'data': serialized_data}, status=status.HTTP_200_OK)
         
        
        return Response({'message': 'This bus user is currently not on a trip.'}, status=status.HTTP_404_NOT_FOUND)
        
    except Exception as e:
            
            return Response({'message': 'Error fetching trips the bus user is on. Try again.'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        

@api_view(['PATCH'])
def end_trip(request):
    """End a trip
    
    Args:
        request (Request): A request object containing the trip ID, vehicle ID, driver ID, and date/time ended.

    Returns:
        Response: A response object containing the serialized trip-stop object.
    """
    
    data = request.data
    trip_taken_id = data.get('trip_taken_id')
    
    if trip_taken_id is None:
        return Response({'message': 'Trip taken ID is required'}, status=status.HTTP_400_BAD_REQUEST)
    
    try:
        trip_taken = TripTaken.objects.get(trip_taken_id=trip_taken_id)
        
        if trip_taken:
        
            # Update the TripTaken object
            trip_taken.has_ended = True
            trip_taken.date_time_ended = timezone.now()
            trip_taken.save()
        
            return Response({'message': 'Trip ended successfully'}, status=status.HTTP_200_OK)
        
        return Response({'message': 'Trip taken does not exist'}, status=status.HTTP_400_BAD_REQUEST)
        
    except Exception as e:
        return Response({'message': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)



@api_view(['DELETE'])
def delete_trip_taken(request):
    
    """Cancel a trip taken
    
    Args:
        request (Request): A request object containing the trip ID, vehicle ID, driver ID, and date/time started.

    Returns:
        Response: A response object containing the serialized trip-stop object.
    """
    
    data = request.data
    
    trip_taken_id = data.get('trip_taken_id')
    
    if trip_taken_id is None:
        return Response({'message': 'Trip taken ID is required'}, status=status.HTTP_400_BAD_REQUEST)
    
    try:
        
        trip_taken_mgr = TripTaken.objects
        
        trip_taken = trip_taken_mgr.get(trip_taken_id=trip_taken_id)
        
        if trip_taken is None:
            return Response({'message': 'Trip taken does not exist'}, status=status.HTTP_400_BAD_REQUEST)
        
        trip_taken.delete()
        
        return Response({'message': 'Trip cancelled successfully'}, status=status.HTTP_200_OK)
    
    except Exception as e:
        
        return Response({'message': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)







