String? doubleStringToIntString(String? doubleString) {
  if (doubleString == null) {
    return doubleString;
  }
  return double.parse(doubleString).toInt().toString();
}
