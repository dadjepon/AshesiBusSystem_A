from django.utils import timezone
from django.db import models
from abs_app.managers.bus_user_mgr import BusUserManager

# Create your models here.

class Vehicle (models.Model):
    vehicle_id = models.AutoField(primary_key=True)
    vehicle_name = models.CharField(max_length=255, default=None)
    license_no = models.CharField(max_length=255, unique=True, default=None)
    model = models.CharField(max_length=255, default=None)
    is_available = models.BooleanField(default=True, null=False)
    
class Trip (models.Model):
    trip_id = models.AutoField(primary_key=True)
    trip_name = models.TextField(max_length=500, default=None, null=False)
    trip_start_time = models.TimeField(default=None, null=False)
    trip_end_time = models.TimeField(default=None, null=False)
    
class Driver (models.Model):
    driver_id = models.AutoField(primary_key=True)
    driver_ashesi_id = models.CharField(max_length=255, unique=True, default=None)
    fname = models.CharField(max_length=255, null=False)
    lname = models.name = models.CharField(max_length=255, null=False)
    phone_number = models.CharField(max_length=20, unique=True, null=False, default=None)
    
class BusUser (models.Model):
    bus_user_id = models.AutoField(primary_key=True)
    fname = models.CharField(max_length=255, null=False, default=None)
    lname = models.CharField(max_length=255, null=False, default=None)
    passwd = models.CharField (max_length=255, null=False, default=None)
    ashesi_id = models.CharField(max_length=255, unique=True)
    ashesi_email = models.EmailField(max_length=255, unique=True, null=False, default=None)
    momo_no = models.CharField(max_length=20, unique=True, null=False, default=None)
    is_active = models.BooleanField(default=False)
    is_admin = models.BooleanField(default=False)
    last_login = models.DateTimeField(default=None, null=True)
    objects = BusUserManager()
    
class Stop(models.Model):
    stop_id = models.AutoField(primary_key=True)
    stop_name = models.TextField(max_length=500, default=None, null=False)
    price = models.DecimalField(max_digits=10, decimal_places=2, default=3)
    
class Payment(models.Model):
    payment_id = models.AutoField(primary_key=True)
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    status = models.CharField(max_length=255, default='Pending')
    ref = models.CharField(max_length=255, default=None, null=True)
    bus_user = models.ForeignKey(BusUser, on_delete=models.CASCADE, related_name='payment')
    trip_taken = models.ForeignKey('TripTaken', on_delete=models.CASCADE, related_name='payment')
    stop = models.ForeignKey(Stop, on_delete=models.SET_DEFAULT, related_name='payment', default=None)
    payment_date_time = models.DateTimeField(auto_now_add=True)
    
    
class TripStop(models.Model):
    trip_stop_id = models.AutoField(primary_key=True, default=None)
    trip = models.ForeignKey(Trip, on_delete=models.CASCADE, related_name='trip_stop')
    stop = models.ForeignKey(Stop, on_delete=models.CASCADE, related_name='trip_stop')
    
    
class TripTaken (models.Model):
    trip_taken_id = models.AutoField(primary_key=True, default=None)
    trip = models.ForeignKey(Trip, on_delete=models.CASCADE, related_name='trip_taken')
    driver = models.ForeignKey(Driver, on_delete=models.CASCADE, related_name='trip_taken')
    vehicle = models.ForeignKey(Vehicle, on_delete=models.CASCADE, related_name='trip_taken')
    date_time_started = models.DateTimeField(auto_now_add=True)
    date_time_ended = models.DateTimeField(default=None, null=True)
    has_started = models.BooleanField(default=True)
    has_ended = models.BooleanField(default=False)

    
class ParkingSpace (models.Model):
    parking_space_id = models.AutoField(primary_key=True, default=None)
    parking_space_name = models.CharField(max_length=255, default=None)
    vehicle = models.ForeignKey(Vehicle, on_delete=models.SET_DEFAULT, related_name='parking_space', default=None, null=True)
    

class DriversLicense(models.Model):
    license_id = models.AutoField(primary_key=True)
    driver = models.ForeignKey(Driver, on_delete=models.CASCADE)
    license_number = models.CharField(max_length=255, unique=True)
    issue_date = models.DateField()
    expiry_date = models.DateField()
    is_verified = models.BooleanField(default=False)
