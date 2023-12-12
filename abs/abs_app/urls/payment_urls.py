from django.urls import path
from abs_app.views.payment_view import create_charge, complete_transaction_for_voda


urlpatterns = [
    path('payment/create_charge/', create_charge, name='create_charge'),
]
