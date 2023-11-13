from rest_framework import serializers
from abs_app.models import Vehicle, Trip, BusUser, Driver, Stop, Payment, TripTaken, TripStop

class VehicleSerializer (serializers.ModelSerializer):
    class Meta:    
        model = Vehicle
        fields = '__all__'
        
        
class TripSerializer (serializers.ModelSerializer):
    class Meta:
        model = Trip
        fields = '__all__'
        
class BusUserSerializer (serializers.ModelSerializer):
    class Meta:
        model = BusUser
        fields = '__all__'
        
class DriverSerializer (serializers.ModelSerializer):
    class Meta:
        model = Driver
        fields = '__all__'

            
class StopSerializer (serializers.ModelSerializer):
    class Meta:
        model = Stop
        fields = '__all__'
        
class PaymentSerializer (serializers.ModelSerializer):
    class Meta:
        model = Payment
        fields = '__all__'
        
class TripTakenSerializer (serializers.ModelSerializer):
    class Meta:
        model = TripTaken
        fields = '__all__'
        
class TripStopSerializer (serializers.ModelSerializer):
    class Meta:
        model = TripStop
        fields = '__all__'