/// Get last word from string. Used to get the final destination from a trip's name.
/// For example, if the trip name is "Kumasi - Accra", this function will return "Accra"
String getLastWord (String string) {
  List<String> words = string.split('-');

  String lastWord = words.isNotEmpty ? words.last : '';

  return lastWord;
}
