from django.http import HttpResponse, HttpResponseBadRequest
from abs_app.models import Stop
from abs_app.serializers import StopSerializer
from rest_framework import status
from rest_framework.response import Response
from rest_framework.decorators import api_view


@api_view(['POST'])
def create_stop (request):
    
    """Create a stop.
    
    Args:
        request (Request): A request object containing the stop.

    Returns:
        Response: A response object containing the serialized stop object.
    """
        
    serializer = StopSerializer(data=request.data)
        
    if serializer.is_valid():
        serializer.save()
        return Response({'message': 'Stop created successfully'}, status=status.HTTP_201_CREATED)
    
    else:
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)        
        
                
        

@api_view(['GET'])
def get_stop_by_id(request):
    
    """Get a stop with a given stop ID.
    
    Args:
        request (Request): A request object containing the stop ID.

    Returns:
        Response: A response object containing the serialized stop object.
    """
    
    stop_objects = Stop.objects
    stop_id = request.query_params.get('stop_id')
    
    if stop_id is None:
        return HttpResponseBadRequest("Stop ID is required")
    
    stop = stop_objects.get(stop_id=stop_id)
    
    if stop:
        return Response({'message': 'Stop fetched successfully', 'data': StopSerializer(stop).data}, status=status.HTTP_200_OK)
    
    return Response({'message': 'Error fetching stop. Try again.'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


@api_view(['DELETE'])
def delete_stop(request):
    
    """Delete a stop with a given stop ID.
    
    Args:
        request (Request): A request object containing the stop ID.

    Returns:
        Response: A response containing a message indicating whether the stop was deleted successfully.
    """
    
    stop_objects = Stop.objects
    stop_id = request.query_params.get('stop_id')
    
    if stop_id is None:
        return HttpResponseBadRequest("Stop ID is required")
    
    stop = stop_objects.get(stop_id=stop_id)
    
    if stop is None:
        return HttpResponseBadRequest("Stop does not exist")
    
    delete = stop.delete()
    
    if delete:
        return Response({'message': 'Stop deleted successfully'}, status=status.HTTP_200_OK)
    
    return Response({'message': 'Error deleting stop. Try again.'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
