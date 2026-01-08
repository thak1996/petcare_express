class StringHelper {
  static String formatUserName(String fullName) {
    if (fullName.isEmpty) return 'Usuário';
    List<String> parts = fullName
        .trim()
        .split(' ')
        .where((s) => s.isNotEmpty)
        .toList();
    if (parts.length == 1) return _capitalize(parts[0]);
    String firstName = _capitalize(parts[0]);
    String secondNameAbbreviated = "${parts[1][0].toUpperCase()}.";
    String restOfName = "";
    if (parts.length > 2) {
      Iterable<String> capitalizedRest = parts
          .sublist(2)
          .map((word) => _capitalize(word));
      restOfName = " ${capitalizedRest.join(' ')}";
    }
    return "$firstName $secondNameAbbreviated$restOfName";
  }

  static String _capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }
}
