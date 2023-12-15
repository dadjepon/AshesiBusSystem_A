# AshesiBusSystem_A

## SYSTEM IMPLEMENTATION

This system consists of three components: a mobile frontend built with Flutter, a web application built with React, and a REST API built with Django Rest Framework.

### The Mobile App

Flutter is a Dart framework used for building multi-platform applications from a single codebase, making it suitable for this agile project (as they require quick development). It will also increase reach among the Ashesi staff members, catering to both Android and iOS users. Flutter’s fast provision will ensure the quick execution of functionalities like starting and joining trips, and making payment. Libraries used include:

- **Shared preferences:** For local storage of user data as user ID. This allows for the retrieval of user-specific data such as trips taken.
- **http:** Allows the Flutter app to make requests to an API endpoint.

### The Django Rest Framework

Django Rest Framework (DRF) is a powerful framework that abstracts common tasks associated with REST APIs. For example, SELECT queries are abstracted into get and filter methods. This is suitable for building applications quickly without sacrificing code readability and cleanliness. Again, its in-built security features like those for authentication secure one’s API. Its routing capabilities allow you to easily generate endpoint URLs. Last but not least, it supports the integration of third-party libraries like paystack (which was needed to allow passengers to pay for trips).

- **Paystack:** Paystack is a payment gateway that supports mobile money transactions. Its API has an easy integration process, making it suitable.

### The React Framework
Choosing React for our web application was a strategic decision driven by its component-based architecture, efficient virtual DOM implementation, and declarative syntax that enhances code readability. The vast ecosystem and active community around React provided us with many resources, from documentation to third-party libraries, accelerating our development process. React's seamless integration with the backend was facilitated by using Axios, a widely adopted HTTP client. Leveraging Axios, we established smooth communication between the front and backend, ensuring efficient data retrieval and updates. This streamlined our application's performance and allowed us to implement responsive and dynamic user interfaces. React's robust features and compatibility with tools like Axios have empowered us to build a scalable, maintainable, and performant web application.

*This is a link to [admin console](https://ashesibus-304d2.web.app/).*

---

*This is a link to a [Google Document](https://docs.google.com/document/d/1D9xNJdMf5j3DboYF6D96KzdraKXdgwmT/edit?usp=sharing&ouid=104244419653743082763&rtpof=true&sd=true) containing information about this system.*
