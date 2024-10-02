extension KineticsUtils on double {
  String convertToTwoDecimalString() {
    if (this == 0) {
      return '0';
    }
    return toStringAsFixed(2);
  }

  double convertToTwoDecimal() {
    if (this == 0) {
      return 0;
    }
    return double.parse(toStringAsFixed(2));
  }
}
