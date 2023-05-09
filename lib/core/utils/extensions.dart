extension StringExt on String {
  String capitalizeFirstChar() {
    if (isEmpty) {
      return this;
    }
    return this[0].toUpperCase() + substring(1);
  }
}
