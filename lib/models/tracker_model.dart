import 'dart:convert';

import 'package:intl/intl.dart';

class TrackerModel {
  final String id;
  final String title;
  final int type;
  final DateTime startDate;
  final int price;
  final bool notificatable;

  String get typeVal {
    if (type == 0) {
      return 'Weekly';
    } else if (type == 1) {
      return 'Monthly';
    } else {
      return 'Yearly';
    }
  }

  String calculateNextPaymentDate() {
    DateTime today = DateTime.now();
    Duration duration;

    switch (type) {
      case 0:
        duration = const Duration(days: 7);
        break;
      case 1:
        duration = const Duration(
            days:
                30); 
        break;
      case 2:
        duration = const Duration(
            days:
                365);
        break;
      default:
        return '-';
    }

    DateTime nextPayment = startDate;
    while (nextPayment.isBefore(today)) {
      nextPayment = nextPayment.add(duration);
    }

    return DateFormat('dd.MM.yyyy').format(nextPayment);
  }

  TrackerModel(
      {required this.id,
      required this.title,
      required this.type,
      required this.startDate,
      required this.price,
      required this.notificatable});

  factory TrackerModel.fromJson(Map<String, dynamic> json) => TrackerModel(
        id: json['id'],
        title: json['title'],
        type: json['type'],
        startDate: DateTime.parse(json['startDate']),
        price: json['price'],
        notificatable: json['notificatable'],
      );

  String toJson() => jsonEncode({
        'id': id,
        'title': title,
        'type': type,
        'startDate': startDate.toString(),
        'price': price,
        'notificatable': notificatable
      });
}
