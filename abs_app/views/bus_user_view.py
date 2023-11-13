from rest_framework.views import APIView
from abs_app.models import BusUser
from abs_app.serializers import BusUserSerializer
from rest_framework import status
from rest_framework.response import Response
from rest_framework.decorators import api_view
from abs_app.managers.bus_user_manager import BusUserManager


    
@api_view(['POST'])
def register_and_verify (request):
        
    bus_user_manager = BusUserManager()
    serializer = BusUserSerializer(data=request.data)
        
    print (request.data)
         
    # check for correctness of data types, constraints, etc.
    # The data must match the rules defined in the serializer class. 
    # This serializer was created from a model
    if serializer.is_valid():
                
        # the double asterisks unpacks the content of the dictionary, serializer.validated_data, and
        # passes them as individual arguments to the register_user function. Parameters in the request must
        # be the same as those in the function, register_user.
            
        serializer.save()
        register = bus_user_manager.register_user(
            ashesiId = serializer.validated_data['ashesi_id'],
            ashesiEmail= serializer.validated_data['ashesi_email'],
            firstName= serializer.validated_data['fname'],
            lastName= serializer.validated_data['lname'],
            userPassword= serializer.validated_data['passwd']
        )
            
        if register:
                
            verify = bus_user_manager.verify_account(serializer.validated_data['ashesi_email'])
            
            if verify:
            
                return Response({'message': 'User registered successfully. An account activation link has been sent to your email'}, status=status.HTTP_201_CREATED)
            
            else: 
                return Response({'message': 'Error sending verification email.'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
            
        return Response ({'message': 'Registration error. Try again.'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
    
    return Response({'message': 'Invalid data', 'errors': serializer.errors}, status=status.HTTP_400_BAD_REQUEST)
                 
            
@api_view(['POST'])
def activate (request):
        
    bus_user_manager = BusUserManager()
    serializer = BusUserSerializer(data=request.data)
            
    if serializer.is_valid():
                
        activate = bus_user_manager.activate_account(**serializer.validated_data)
                
        if activate:
            return Response({'message': 'Account activated'}, status=status.HTTP_200_OK)
        
        
    return Response({'message': 'Invalid data', 'errors': serializer.errors}, status=status.HTTP_400_BAD_REQUEST)
                
    
@api_view(['POST'])
def login (request):
        
    bus_user_manager = BusUserManager()
    serializer = BusUserSerializer(data=request.data)
            
    if serializer.is_valid():
                
        user = bus_user_manager.login(**serializer.validated_data)
                
        if user:                   
            return Response({'message': 'Login successful', 'user': BusUserSerializer(user).data}, status=status.HTTP_200_OK)
                
        else:
            return Response({'message': 'Invalid credentials'}, status=status.HTTP_401_UNAUTHORIZED)

    return Response({'message': 'Invalid data', 'errors': serializer.errors}, status=status.HTTP_400_BAD_REQUEST)
                