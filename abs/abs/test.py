
import datetime
import os
from django.conf import settings
from django.contrib.auth.hashers import make_password
from django.core.mail import send_mail
from django.contrib.auth.tokens import default_token_generator
import logging


# Set the DJANGO_SETTINGS_MODULE environment variable
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "settings")
    

if __name__ == '__main__':
    
    print(0)
    
   

