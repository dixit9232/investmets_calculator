import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final emiProvider = StateNotifierProvider<EMINotifier, EMIModel>((ref) {
  return EMINotifier();
});

class EMINotifier extends StateNotifier<EMIModel> {
  EMINotifier() : super(EMIModel());

  void calculateEMI({
    required String loanAmount,
    required String rateOfInterest,
    required String timePeriod,
  }) {
    double p = double.parse(loanAmount);
    double annualRate = double.parse(rateOfInterest);
    double years = double.parse(timePeriod);

    double r = annualRate / 12 / 100;
    double n = years * 12;

    double emi = (p * r * pow(1 + r, n)) / (pow(1 + r, n) - 1);

    final NumberFormat numberFormat = NumberFormat("#,##,###");
    String emiAmount = numberFormat.format(emi.roundToDouble().toInt());

    state = EMIModel(
      emiAmount: emiAmount,
      rateOfInterest: rateOfInterest,
      loanAmount: loanAmount,
      timePeriod: timePeriod,
    );
  }
}

class EMIModel {
  final String emiAmount;
  final String loanAmount;
  final String rateOfInterest;
  final String timePeriod;

  EMIModel({this.emiAmount = "", this.rateOfInterest = "", this.loanAmount = "", this.timePeriod = ""});

  EMIModel copyWith({
    String? emiAmount,
    String? loanAmount,
    String? timePeriod,
    String? rateOfInterest,
  }) {
    return EMIModel(emiAmount: emiAmount ?? this.emiAmount, rateOfInterest: rateOfInterest ?? this.rateOfInterest, loanAmount: loanAmount ?? this.loanAmount, timePeriod: timePeriod ?? this.timePeriod);
  }
}
