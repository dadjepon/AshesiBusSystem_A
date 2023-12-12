
/// This class is used to represent a driver.
class Driver {
  int driverId;
  String fname;
  String lname;
  String driverAshesiId;
  String phoneNumber;

  Driver(
    {
      required this.driverId,
      required this.fname,
      required this.lname,
      required this.driverAshesiId,
      required this.phoneNumber
    }
  );

  /// This method is used to convert the JSON returned from the API into a Driver object.
  /// The argument is a map of the user's details.
  /// The method returns a Driver object.
  factory Driver.fromJson(Map<String, dynamic> responseData) {
    return Driver (
      driverId: responseData['driver_id'],
      fname: responseData['fname'],
      lname: responseData['lname'],
      driverAshesiId: responseData['driver_ashesi_id'],
      phoneNumber: responseData['phone_number']
    );
  }
}