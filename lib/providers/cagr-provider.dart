import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final cagrProvider = StateNotifierProvider<CAGRNotifier, CAGRModel>((ref) {
  return CAGRNotifier();
});

class CAGRNotifier extends StateNotifier<CAGRModel> {
  CAGRNotifier() : super(CAGRModel());

  void calculateCAGR({
    required String presentValue,
    required String futureValue,
    required String timePeriod,
  }) {
    double pv = double.parse(presentValue);
    double fv = double.parse(futureValue);
    double t = double.parse(timePeriod);

    double cagr = (pow((fv / pv), (1 / t)) - 1) * 100;

    NumberFormat numberFormat = NumberFormat('#,##,###');

    String formattedPV = numberFormat.format(pv);
    String formattedFV = numberFormat.format(fv);

    state = CAGRModel(
      cagr: cagr.toStringAsFixed(1),
      presentValue: formattedPV,
      futureValue: formattedFV,
      timePeriod: timePeriod,
    );
  }
}

class CAGRModel {
  final String cagr;
  final String presentValue;
  final String futureValue;
  final String timePeriod;

  CAGRModel({this.cagr = "", this.presentValue = "", this.futureValue = "", this.timePeriod = ""});

  CAGRModel copyWith({
    String? cagr,
    String? presentValue,
    String? timePeriod,
    String? futureValue,
  }) {
    return CAGRModel(cagr: cagr ?? this.cagr, presentValue: presentValue ?? this.presentValue, futureValue: futureValue ?? this.futureValue, timePeriod: timePeriod ?? this.timePeriod);
  }
}
