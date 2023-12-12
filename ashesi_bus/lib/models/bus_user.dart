
/// This class is used to represent a bus user.
class BusUser {
  int busUserId;
  String fname;
  String lname;
  String emailAddress;
  String momoNo;
  String ashesiId;

  BusUser(
    {
      required this.busUserId,
      required this.fname,
      required this.lname,
      required this.emailAddress,
      required this.momoNo,
      required this.ashesiId, 
    }
  );

  /// This method is used to convert the JSON returned from the API into a BusUser object.
  /// The argument is a map of the user's details.
  /// The method returns a BusUser object.
  factory BusUser.fromJson(Map<String, dynamic> responseData) {
    return BusUser (
      busUserId: responseData['bus_user_id'],
      fname: responseData['fname'],
      lname: responseData['lname'],
      emailAddress: responseData['ashesi_email'],
      momoNo: responseData['momo_no'],
      ashesiId: responseData['ashesi_id'],
    );
  }
}