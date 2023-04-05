String? doubleStringToIntString(String? doubleString) {
  if (doubleString == null) {
    return doubleString;
  }
  return double.parse(doubleString).toInt().toString();
}

String formatAmount(String amount) {
  String priceInText = "";
  int counter = 0;
  for (int i = (amount.length - 1); i >= 0; i--) {
    counter++;
    String str = amount[i];
    if ((counter % 3) != 0 && i != 0) {
      priceInText = "$str$priceInText";
    } else if (i == 0) {
      priceInText = "$str$priceInText";
    } else {
      priceInText = ",$str$priceInText";
    }
  }
  return priceInText.trim();
}

String get periodOfDay {
  final dateTime = DateTime.now();

  if (dateTime.hour >= 16 && dateTime.hour <= 23) {
    return 'GOOD EVENING';
  } else if (dateTime.hour >= 12 && dateTime.hour <= 15) {
    return 'GOOD AFTERNOON';
  }
  return 'GOOD MORNING';
}
