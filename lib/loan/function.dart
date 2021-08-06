import 'package:intl/intl.dart';

String checkNull(var value) {
  value = value.toString();
  if (value.isEmpty || value == null || value == "null") {
    return "-";
  }
  return value;
}

String millionNumber(var value) {
  try {
    print("parseNumber");
    // print(value);
    List parsedNumber = value.toString().split("");
    // print(parsedNumber);
    String newValue;
    if (parsedNumber.length < 11) {
      // print("in<7");
      final formatCurrency =
          new NumberFormat.currency(customPattern: '###,###,###,###');
      newValue = formatCurrency.format(value).toString();
      // print("in<7 2 $newValue");
    } else {
      final formatCurrency = new NumberFormat.compact();
      newValue = formatCurrency.format(value).toString();
    }
    return newValue;
  } catch (e) {
    return checkNull(value);
  }
}

String parseNumber(var value) {
  try {
    print("parseNumber");
    // print(value);
    List parsedNumber = value.toString().split("");
    // print(parsedNumber);
    String newValue;
    if (parsedNumber.length < 9) {
      // print("in<7");
      final formatCurrency =
          new NumberFormat.currency(customPattern: '###,###,###');
      newValue = formatCurrency.format(value).toString();
      // print("in<7 2 $newValue");
    } else {
      final formatCurrency = new NumberFormat.compact();
      newValue = formatCurrency.format(value).toString();
    }

    return newValue;
  } catch (e) {
    return checkNull(value);
  }
}

String parseThousandNumber(var value) {
  try {
    // print("parseNumber");
    // print(value);
    List parsedNumber = value.toString().split("");
    // print(parsedNumber);
    String newValue;
    if (parsedNumber.length < 4) {
      // print("in<7");
      final formatCurrency =
          new NumberFormat.currency(customPattern: '###,###,###');
      newValue = formatCurrency.format(value).toString();
      // print("in<7 2 $newValue");
    } else {
      final formatCurrency = new NumberFormat.compact();
      newValue = formatCurrency.format(value).toString();
    }

    return newValue;
  } catch (e) {
    return checkNull(value);
  }
}

String formatDate(DateTime date) {
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  final String formatted = formatter.format(date);
  return formatted;
}
