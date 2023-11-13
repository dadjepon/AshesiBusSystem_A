from django.db import models
from abs_app.managers.bus_user_manager import BusUserManager
from abs_app.managers.trip_stop_manager import TripStopManager

# Create your models here.

class Vehicle (models.Model):
    license_no = models.AutoField(primary_key=True)
    color = models.CharField(max_length=255, default=None)
    model = models.CharField(max_length=255, default=None)
    objects = BusUserManager()
    
class Trip (models.Model):
    trip_id = models.AutoField(primary_key=True)
    trip_name = models.CharField(max_length=1, unique=True, default=None)
    
class Driver (models.Model):
    driver_id = models.AutoField(primary_key=True)
    fname = models.CharField(max_length=255, null=False)
    lname = models.name = models.CharField(max_length=255, null=False)
    
class BusUser (models.Model):
    bus_user_id = models.AutoField(primary_key=True)
    fname = models.CharField(max_length=255, null=False)
    lname = models.CharField(max_length=255, null=False)
    passwd = models.CharField (max_length=255, null=False)
    ashesi_id = models.CharField(max_length=255, unique=True)
    ashesi_email = models.EmailField(max_length=255, unique=True)
    is_active = models.BooleanField(default=False)
    
class Stop(models.Model):
    stop_id = models.AutoField(primary_key=True)
    stop_name = models.TextField(max_length=500)
    
class Payment(models.Model):
    payment_id = models.AutoField(primary_key=True)
    payment_date_time = models.DateTimeField()
    bus_user_id = models.ForeignKey(BusUser, on_delete=models.CASCADE, related_name='busUser')
    
    
class TripStop(models.Model):
    trip_id = models.ForeignKey(Trip, on_delete=models.CASCADE, related_name='trip_stops')
    stop_id = models.ForeignKey(Stop, on_delete=models.CASCADE, related_name='stop')
    objects = TripStopManager()
    
    
class TripTaken (models.Model):
    trip_id = models.ForeignKey(Trip, on_delete=models.CASCADE, related_name='trip_taken')
    driver_id = models.ForeignKey(Driver, on_delete=models.CASCADE, related_name='driver')
    vehicle_id = models.ForeignKey(Vehicle, on_delete=models.CASCADE, related_name='vehicle')
    date_time_started = models.DateTimeField(auto_now_add=True)
    has_started = models.BooleanField(default=False)
    has_ended = models.BooleanField(default=False)

    
    
