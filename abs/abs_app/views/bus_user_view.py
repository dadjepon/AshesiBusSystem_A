from abs_app.models import BusUser
from abs_app.serializers import BusUserSerializer
from rest_framework import status
from rest_framework.response import Response
from rest_framework.decorators import api_view
from firebase_admin import auth


# {"ashesi_email": "kwakuosafo20@gmail.com", "ashesi_id": "38522024", "passwd": "Mariamjade1@", "fname": "Kwaku", "lname": "Osafo"}
    
@api_view(['POST'])
def register_and_verify (request):
    
    serializer = BusUserSerializer(data=request.data)
        
    if serializer.is_valid():
        
        bus_user = BusUser.objects
        data = serializer.validated_data
                
        # check for correctness of data types, constraints, etc.
        # The data must match the rules defined in the serializer class. 
        # This serializer was created from a model
                    
        # the double asterisks unpacks the content of the dictionary, serializer.validated_data, and
        # passes them as individual arguments to the register_user function. Parameters in the request must
        # be the same as those in the function, register_user.
                
        register = bus_user.register_user(
            data.get('ashesi_id'),
            data.get('fname'),
            data.get('lname'),
            data.get('ashesi_email'),
            data.get('momo_no'),
            data.get('passwd')
        )
                
        if register:
                    
            verify = bus_user.verify_account(data.get('ashesi_email'))
                
            if verify:        
                return Response({'message': 'Registered successfully. An account activation link has been sent to your email. Click on it to activate your account'}, status=status.HTTP_201_CREATED)
                
            else: 
                return Response({'message': 'Error sending verification email.'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
                
        return Response ({'message': 'Registration error. Try again.'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
    

@api_view(['POST'])      
def admin_register_and_verify(request):
    
    serializer = BusUserSerializer(data=request.data)
        
    if serializer.is_valid():
        
        bus_user = BusUser.objects
        data = serializer.validated_data
                
        # check for correctness of data types, constraints, etc.
        # The data must match the rules defined in the serializer class. 
        # This serializer was created from a model
                    
        # the double asterisks unpacks the content of the dictionary, serializer.validated_data, and
        # passes them as individual arguments to the register_user function. Parameters in the request must
        # be the same as those in the function, register_user.
                
        register = bus_user.register_admin(
            data.get('ashesi_id'),
            data.get('fname'),
            data.get('lname'),
            data.get('ashesi_email'),
            data.get('momo_no'),
            data.get('passwd')
        )
                
        if register:
                    
            verify = bus_user.verify_account(data.get('ashesi_email'))
                
            if verify:        
                return Response({'message': 'Registered successfully. An account activation link has been sent to your email. Click on it to activate your account'}, status=status.HTTP_201_CREATED)
                
            else: 
                return Response({'message': 'Error sending verification email.'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
                
        return Response ({'message': 'Registration error. Try again.'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

            
@api_view(['GET'])
def activate(request):
    
    bus_user = BusUser.objects
    user_idb64 = request.query_params.get('uid')
                
    activate = bus_user.activate_account(user_idb64)
                    
    if activate:
        return Response({'message': 'Account activated'}, status=status.HTTP_200_OK)
                
    return Response({'message': 'Account activation failed'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

    
    
    
@api_view(['POST'])
def login(request):
    
    bus_user = BusUser.objects
    data = request.data
    
    user = bus_user.login(
        ashesiEmail=data.get('ashesi_email'),
        userPassword=data.get('passwd')
    )
    
    if user:
        
        user_data = {
            'bus_user_id': user.bus_user_id,
            'ashesi_id': user.ashesi_id,
            'ashesi_email': user.ashesi_email,
            'fname': user.fname,
            'lname': user.lname,
            'momo_no': user.momo_no
        }
        
        return Response({'message': 'Login successful', 'data': user_data}, status=status.HTTP_200_OK)

    return Response({'message': 'Login failed'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
                

@api_view(['POST'])            
def admin_login(request):
    
    bus_user = BusUser.objects
    data = request.data
    
    user = bus_user.admin_login(
        ashesiEmail=data.get('ashesi_email'),
        userPassword=data.get('passwd')
    )
    
    if user:
        
        user_data = {
            'bus_user_id': user.bus_user_id,
            'ashesi_id': user.ashesi_id,
            'ashesi_email': user.ashesi_email,
            'fname': user.fname,
            'lname': user.lname,
            'momo_no': user.momo_no
        }
        
        return Response({'message': 'Login successful', 'data': user_data}, status=status.HTTP_200_OK)

    return Response({'message': 'Login failed'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)