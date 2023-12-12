from abs_app.models import Payment, BusUser, Stop, TripTaken
from abs_app.serializers import PaymentSerializer
from rest_framework.decorators import api_view
import requests
from rest_framework import status
from django.http import JsonResponse
from rest_framework.response import Response
from django.conf import settings
import os



def get_network_provider (phone_number):
    
    """Get the network provider for a phone number.
    
    Args:
        phone_number (str): A phone number.
    
    Returns:
        str: The network provider for the phone number.
    """
    
    phone_number = str(phone_number)
    
    if phone_number.startswith('024') or phone_number.startswith('054') or phone_number.startswith('055') or phone_number.startswith('059'):
        return 'mtn'
    
    elif phone_number.startswith('020') or phone_number.startswith('050'):
        return 'vod'
    
    elif phone_number.startswith('026') or phone_number.startswith('056'):
        return 'tgo'
    
    else:
        return None


@api_view(['POST'])
def create_charge(request):
    """
    Create a charge for a mobile money payment.
    Send an email and amount to the ChargeAPI endpoint along with a mobile_money object.

    Returns:
        response (Response): A response object containing the charge ID.
    """
    
    # Set the DJANGO_SETTINGS_MODULE environment variable
    os.environ.setdefault("DJANGO_SETTINGS_MODULE", "abs.settings")


    # Set the headers for all payment requests
    headers = {
        'Authorization': f'Bearer {settings.PAYSTACK_SECRET_KEY}',
        'Content-Type': 'application/json',
    }
    
    data = request.data
    
    bus_user_id = data.get('bus_user')
    trip_taken_id = data.get('trip_taken')
    amount = data.get('amount')
    stop = data.get('stop')
    
    bus_user_objects = BusUser.objects
    trip_taken_objects = TripTaken.objects
    stop_objects = Stop.objects
    
    bus_user = bus_user_objects.get(bus_user_id=bus_user_id)
    trip_taken = trip_taken_objects.get(trip_taken_id=trip_taken_id)
    stop = stop_objects.get(stop_id=stop)
    
    if bus_user is None or trip_taken is None:
        return Response({'message': 'Bus user or trip taken does not exist'}, status=status.HTTP_400_BAD_REQUEST)
    
    try:
        payment_objects = Payment.objects
        
        # Create payment record
        payment_objects.create(
            bus_user=bus_user,
            trip_taken=trip_taken,
            amount=amount,
            stop=stop
        )
        
        payment = payment_objects.get(bus_user_id=bus_user_id, trip_taken=trip_taken_id, amount=amount)
        
        payload = {
            'email': payment.bus_user.ashesi_email,
            'amount': amount * 100,  # amounts are represented in subunit of currency. Example: 100 pesewas is 1 cedi.
            'currency': settings.PAYMENT_CURRENCY,
            'mobile_money': {
                'phone': payment.bus_user.momo_no,
                'provider': get_network_provider(payment.bus_user.momo_no),
            }
        }
        
        response = requests.post(settings.PAYSTACK_INITIALIZE_URL, json=payload, headers=headers)
        response.raise_for_status()
        paystack_response = response.json()
        
        # Check the status in the Paystack API response
        if 'status' in paystack_response and paystack_response['status'] is True:
            
            if 'data' in paystack_response and 'authorization_url' in paystack_response['data']:
                
                payment.ref = paystack_response['data']['reference']
                payment.save()
                
                # Payment initiation successful
                return Response({'message': 'Payment initiation successful', 'data': paystack_response['data']}, status=status.HTTP_200_OK)
            
        # Payment initiation failed
        return Response({'message': 'Payment initiation failed', 'paystack_response': paystack_response}, status=status.HTTP_400_BAD_REQUEST)
        
    except Exception as e:
        print(e)
        return Response({'message': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


    
    

@api_view(['POST'])
def complete_transaction_for_voda(response):
        
        """
        Complete a transaction for a mobile money payment for Vodafone.
    
        Returns:
            _type_: _description_
        """
        
        if response is None:
            return Response({'message': 'Response is required'}, status=status.HTTP_400_BAD_REQUEST)
        
        try:
            
            if 'data' in response and 'status' in response['data']:
                
                if response['data']['status'] == 'success':
                    
                    payment_objects = Payment.objects
                    
                    payment = payment_objects.get(ref=response['data']['reference'])
                    
                    if payment is None:
                        return Response({'message': 'Payment does not exist'}, status=status.HTTP_400_BAD_REQUEST)
                    
                    payment.status = 'success'
                    payment.save()
                    
                    return Response({'message': 'Payment successful'}, status=status.HTTP_200_OK)
                
                else:
                    return Response({'message': 'Payment failed'}, status=status.HTTP_400_BAD_REQUEST)
                
        except Exception as e:
            return Response({'message': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        