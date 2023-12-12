/// This function validates an email based on a regular expression pattern.
bool isEmailValid(String email) {
  
  // Regular expression pattern for email validation
  final RegExp emailRegex =
      RegExp(r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}$');

  return emailRegex.hasMatch(email);
}

/// This function validates a password based on a regular expression pattern.
bool isPasswordValid(String password) {

  // Define the regular expression pattern for password validation
  // This example enforces at least 8 characters with at least one uppercase letter, one lowercase letter, and one digit.
  RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');

  return regex.hasMatch(password);
}

/// This function validates a phone number based on a regular expression pattern.
bool isValidPhoneNumber(String value) {
  final RegExp mobileNumberRegex = RegExp(r'^[0-9]{10}$');
  return mobileNumberRegex.hasMatch(value);
}