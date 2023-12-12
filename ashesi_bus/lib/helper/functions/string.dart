String getLastWord (String string) {
  List<String> words = string.split('-');

  String lastWord = words.isNotEmpty ? words.last : '';

  return lastWord;
}