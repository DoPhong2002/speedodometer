import 'package:intl/intl.dart';

extension TimeUtils on String? {
  String convertToHHmm() {
    if (this == null || this == '') {
      return '';
    }
    final DateTime originalDateTime = DateTime.parse(this ?? '1/1/1970');

    final String formattedTime = DateFormat('HH:mm').format(originalDateTime);

    return formattedTime;
  }

  String convertToAPM() {
    if (this == null || this == '') {
      return '';
    }

    final DateTime dateTime = DateTime.parse(this ?? '1/1/1970');
    final DateTime now = DateTime.now();

    final String hour = DateFormat('h').format(dateTime);
    final String period = DateFormat('a').format(dateTime);

    final String hourNow = DateFormat('h').format(now);

    if (hour == hourNow) {
      return 'Now';
    }

    return '$hour${period.toUpperCase()}';
  }

  String convertToMMMd() {
    if (this == null || this == '') {
      return '';
    }
    final DateTime dateTime = DateTime.parse(this ?? '1/1/1970');

    final String formattedDate = DateFormat('MMM, d').format(dateTime);

    return formattedDate;
  }

  String convertTohhmmaEEEEdMMM() {
    if (this == null || this == '') {
      return '';
    }
    final DateTime dateTime = DateTime.parse(this ?? '1/1/1970');

    final String formattedDate =
        DateFormat('hh:mm a - EEEE, d MMM').format(dateTime);

    return formattedDate;
  }

  String convertToHHmmMMyyyy() {
    if (this == null || this == '') {
      return '';
    }
    final DateTime dateTime = DateTime.parse(this ?? '1/1/1970');

    final String formattedDate =
        DateFormat('HH:mm - dd/MM/yyyy').format(dateTime);

    return formattedDate;
  }

  String convertToHMMSS() {
    if (this == null || this == '') {
      return '';
    }
    final seconds = int.parse(this ?? '0');
    final hours = (seconds / 3600).floor();
    final minutes = ((seconds % 3600) / 60).floor();
    final secondsRemaining = seconds % 60;

    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secondsRemaining.toString().padLeft(2, '0')}';
  }
}
