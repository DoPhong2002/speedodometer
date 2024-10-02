import 'kinetics_utils.dart';

extension UnitUtil on double {
  double convertUnit(String speedUnit) {
    switch (speedUnit) {
      case 'Mph' || 'Mi':
        return (this * 0.621371).convertToTwoDecimal();
      case 'Knot' || 'Nmi':
        return (this * 0.539957).convertToTwoDecimal();
      default:
        return convertToTwoDecimal();
    }
  }
}
