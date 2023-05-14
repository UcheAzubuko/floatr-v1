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

int percent({required int percentage, required int amount}) =>
    ((percentage / 100) * amount).toInt();

String get periodOfDay {
  final dateTime = DateTime.now();

  if (dateTime.hour >= 16 && dateTime.hour <= 23) {
    return 'GOOD EVENING';
  } else if (dateTime.hour >= 12 && dateTime.hour <= 15) {
    return 'GOOD AFTERNOON';
  }
  return 'GOOD MORNING';
}

String formatNigerianPhoneNumber(String number) {
  // Remove any non-digit characters from the number
  number = number.replaceAll(RegExp(r'\D'), '');

  // Add the country code prefix if it's not already present
  if (!number.startsWith('234') && !number.startsWith('+234')) {
    number = '+234${number.substring(number.startsWith('0') ? 1 : 0)}';
  }

  // Check if the number is a valid Nigerian phone number
  if (!RegExp(r'^(\+?234)[7-9]\d{9}$').hasMatch(number)) {
    return number;
  }

  // Remove any existing plus sign and spaces from the number
  number = number.replaceAll(RegExp(r'[+\s]'), '');

  // Format the number as +234XXXXXXXXXX
  return '+234${number.substring(3)}';
}

int daysToWeeks(int days) => days ~/ 7;

