from django.db import models
from django.core.exceptions import ObjectDoesNotExist
import os
import secrets
import hashlib
from urllib.parse import urlencode


from django.contrib.auth.hashers import make_password, check_password
import django.contrib.auth.password_validation as validators
from django.http import HttpResponseBadRequest, HttpResponse
from rest_framework.response import Response

from django.contrib.auth.tokens import default_token_generator
from django.core.mail import send_mail
from django.conf import settings
from django.utils.encoding import force_bytes, force_str
from django.utils.http import urlsafe_base64_encode, urlsafe_base64_decode
from django.utils.timezone import now
from rest_framework.authtoken.models import Token
from django.contrib.auth import authenticate
import logging

from firebase_admin import auth

# Set the DJANGO_SETTINGS_MODULE environment variable
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "abs.settings")


# BUS USER
class BusUserManager(models.Manager):
    
    def register_user(self, ashesiId, firstName, lastName, ashesiEmail, momoNo, userPassword):
        """
        Register a new user.
        
        Args:
            ashesiID: The Ashesi ID number of the user.
            firstName: The user's first name. Can include all names but the surname.
            lastName: The user's surname.
            ashesiEmail: The user's Ashesi email. Domain is ashesi.edu.gh
            momoNo: The user's mobile money number.
            userPassword: The user's password. Will undergo validation and hashing.

        Returns:
            Object: If validate_password returns true.
            HttpResponse: If validate_password returns false.
        """
        
        try:
            validators.validate_password(userPassword)
        except Exception as e:
            return HttpResponseBadRequest(f"Password validation failed: {str(e)}")
        
        hashed_password = make_password(userPassword, hasher='argon2')
    
        self.create(
            ashesi_id = ashesiId,
            fname = firstName,
            lname = lastName,
            ashesi_email = ashesiEmail,
            momo_no = momoNo,
            passwd = hashed_password   
        )
                
        return True
    
    def register_admin(self, ashesiId, firstName, lastName, ashesiEmail, momoNo, userPassword):
        """
        Register a new admin. Admins are created by the superuser. Their is_admin field is set to true.
        
        Args:
            ashesiID: The Ashesi ID number of the user.
            firstName: The user's first name. Can include all names but the surname.
            lastName: The user's surname.
            ashesiEmail: The user's Ashesi email. Domain is ashesi.edu.gh
            momoNo: The user's mobile money number.
            userPassword: The user's password. Will undergo validation and hashing.

        Returns:
            Object: If validate_password returns true.
            HttpResponse: If validate_password returns false. 
        
        """
        
        try:
            validators.validate_password(userPassword)
        except Exception as e:
            return HttpResponseBadRequest(f"Password validation failed: {str(e)}")
        
        hashed_password = make_password(userPassword, hasher='argon2')
        
        self.create(
            ashesi_id = ashesiId,
            fname = firstName,
            lname = lastName,
            ashesi_email = ashesiEmail,
            momo_no = momoNo,
            passwd = hashed_password,
            is_admin = True
        )
        
        return True
        
            
   
    
    
    def verify_account(self, ashesiEmail):
        
        """
        Verifies account by sending an activation link to the user.
        The activation link base 64 encoded string generated from the user's id
        and a token generated from the user's object.
        
        Returns:
        Boolean: True if the email is successfully sent, and false if otherwise
        """
        
        try:
            
            user = self.get(ashesi_email=ashesiEmail)

            
            encoded_user_id = urlsafe_base64_encode(force_bytes(user.pk))

            # Build the activation link
            activation_link = f"http://localhost:8000/bus_user/activate?{urlencode({'uid': encoded_user_id})}"


        
            try:
                self.send_activation_email(user, activation_link)
                return True
            
            except Exception as e:
                logging.error(f"Error sending activation email: {str(e)}")
                return False
        
        except ObjectDoesNotExist:
        # User with the provided email does not exist
            return False
        
        
    def send_activation_email(self, user, activation_link):
        
        """
        Send an email to users to activate their account
        
        Args:
            user: The recepient of the activation email.
            activation_link: Contains a base 64 encoded version of the user's id and a token generated
            from the user object.
        """
        
        try:
            subject = 'Activate Your AshBus Account'
            message = f'Click the following link to activate your account:\n\n{activation_link}'
            to_email = user.ashesi_email

            send_mail(
                subject=subject, 
                message=message, 
                from_email= settings.EMAIL_HOST_USER, 
                recipient_list=[to_email]
            )
            
        except Exception as e:
            logging.error(f"Error sending activation email: {e}")
        
        
    def activate_account(self, user_idb64):
        
        """
        Decodes the base 64 encoded string in the activation link to get the user id. It then finds the user
        with this id. Finally, it checks if the token in the link was generated from the user object obtained.
        
        Returns:
        HttpResponse: If the token in the link was generated from the user whose id has been encoded in the link.
        HttpResponseBadRequest: If activation link is invalid
        """
        try:
            
            # Decode the user ID from base64
            user_id = force_str(urlsafe_base64_decode(user_idb64))
            
            # Get the user from the database
            user = self.get(pk=user_id)

            # Check if user exists and is not active
            if user and not user.is_active:
                
                # Activate the user's account
                user.is_active = True
                user.save()
                
                return True
            
            else:
                return False

        except (ValueError, ObjectDoesNotExist):
            pass

            
            
    
    def login (self, ashesiEmail, userPassword):
        
        """
        Log user in
        
        Args:
            ashesiEmail: The Ashesi email of the user.
            userPassword: The user's password. 

        Returns:
        Object: The user
        """
        
        try:
            user = self.get(ashesi_email=ashesiEmail)
        except self.model.DoesNotExist:
            return None
        
        if check_password(userPassword, user.passwd) and user.is_active:
            
            user.last_login = now()
            user.save()
            
            return user
            
        
        else:
            return None
        
        
    def admin_login(self, ashesiEmail, userPassword):
        
        """
        Log user in
        
        Args:
            ashesiEmail: The Ashesi email of the user.
            userPassword: The user's password. 

        Returns:
        Object: The user
        """
        
        try:
            user = self.get(ashesi_email=ashesiEmail)
        except self.model.DoesNotExist:
            return None
        
        if check_password(userPassword, user.passwd) and user.is_active and user.is_admin:
            
            user.last_login = now()
            user.save()
            
            return user
            
        
        else:
            return None
    
    