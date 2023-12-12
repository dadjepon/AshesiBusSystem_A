# AshesiBusSystem_A
AshesiBusSystem_A

SYSTEM IMPLEMENTATION

This system consists of three components: a mobile frontend built with Flutter, a web application built with React and a REST API built with Django Rest Framework. 

The Mobile App
Flutter is a Dart framework used for building multi-platform applications from a single codebase, making it suitable for this agile project (as they require quick development). It will also increase reach among the Ashesi staff members, catering to both Android and iOS users. Flutter’s fast provision will ensure the quick execution of functionalities like starting and joining trips, and making payment. Libraries used include:

Shared preferences:  For local storage of user data as user ID. This allows for the retrieval of user specific-data such as trips taken.
http: Allows the Flutter app to make requests to an API endpoint.

The Django Rest Framework
Django Rest Framework (DRF) is a powerful framework that abstracts common tasks associated with REST APIs. For example, SELECT queries are abstracted into get and filter methods. This is suitable for building applications quickly without sacrificing code readability and cleanliness. Again, its in-built security features like those for authentication secure one’s API. Its routing capabilities allow you to easily generate endpoint URLs. Last but not the least, it supports the integration of third party libraries like paystack (which was needed to allow passengers to pay for trips).

Paystack: Paystack is a payment gateway that supports mobile money transactions. Its API has an easy integration process, making it suitable. 
