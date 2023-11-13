from django.db import models

from django.contrib.auth.hashers import make_password, check_password
import django.contrib.auth.password_validation as validators
from django.http import HttpResponseBadRequest, HttpResponse
from rest_framework.response import Response

from django.contrib.auth.tokens import default_token_generator
from django.core.mail import send_mail
from django.utils.encoding import force_bytes, force_str
from django.utils.http import urlsafe_base64_encode, urlsafe_base64_decode
from django.utils.timezone import now
from rest_framework.authtoken.models import Token
from django.contrib.auth import authenticate
import logging


# BUS USER
class BusUserManager(models.Manager):
    
    def register_user(self, ashesiId, firstName, lastName, ashesiEmail, userPassword):
        """
        Register a new user.
        
        Args:
            ashesiID: The Ashesi ID number of the user.
            firstName: The user's first name. Can include all names but the surname.
            lastName: The user's surname.
            ashesiEmail: The user's Ashesi email. Domain is ashesi.edu.gh
            userPassword: The user's password. Will undergo validation and hashing.

        Returns:
            Object: If validate_password returns true.
            HttpResponse: If validate_password returns false.
        """
        
        try:
            validators.validate_password(userPassword)
        except Exception as e:
            return HttpResponseBadRequest(f"Password validation failed: {str(e)}")
        
        hashed_password = make_password(userPassword)
        
        self.create(
            ashesi_id = ashesiId,
            fname = firstName,
            lname = lastName,
            ashesi_email = ashesiEmail,
            passwd = hashed_password   
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

            # Generate a unique token for the activation link.
            # When the user clicks the activation link, django's default token generator's check_token function will
            # check if the token in the link was indeed generated from the user object.
            token = default_token_generator.make_token(user)
            
            encoded_user_id = urlsafe_base64_encode(force_bytes(user.pk))

            # Build the activation link
            activation_link = f"http://localhost/activate/{encoded_user_id}/{token}/"

        
            try:
                
                self.send_activation_email(user, activation_link)
                return True
            except Exception as e:
                
                print(f"Error sending activation email: {str(e)}")
                return False
        
        except self.model.DoesNotExist:
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
            from_email = 'kwakuosafo20@gmail.com'  
            to_email = user.ashesi_email

            send_mail(subject, message, from_email, to_email)
            
        except Exception as e:
            logging.error(f"Error sending activation email: {e}")
        
        
    def activate_account(self, request, user_idb64, token):
        
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

            # Check if the token is valid
            if default_token_generator.check_token(user, token):
                
                # Activate the user's account
                user.is_active = True
                user.save()
                
                return True

        except (ValueError, self.model.DoesNotExist):
            pass

            # If the user or token is invalid, return a bad request response
            return False
            
    
    def login (self, ashesiEmail, userPassword):
        
        """
        Log user in
        
        Args:
            ashesiID: The Ashesi ID number of the user.
            userPassword: The user's password. Will undergo validation and hashing.

        Returns:
        Object: The user
        """
        
        try:
            
            user = self.get(ashesi_email=ashesiEmail)
            
            if check_password(userPassword, user.passwd):
                return user
            else:
                return None
            
        except self.model.DoesNotExist:
            # User with the provided email does not exist
            return None