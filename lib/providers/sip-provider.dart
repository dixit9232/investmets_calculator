import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final sipProvider = StateNotifierProvider<SIPNotifier, SIPModel>((ref) {
  return SIPNotifier();
});

class SIPNotifier extends StateNotifier<SIPModel> {
  SIPNotifier() : super(SIPModel());

  void calculateSIP({required String monthlyInvestment, required String returnRate, required String timePeriod}) {
    double P = double.parse(monthlyInvestment);
    double r = double.parse(returnRate) / 100;
    int t = int.parse(timePeriod);
    int n = 12;

    double futureValue = P * (pow((1 + r / n), n * t) - 1) / (r / n) * (1 + r / n);
    double investedAmount = P * n * t;
    double estimatedReturn = futureValue - investedAmount;

    final formatter = NumberFormat('#,##,###');
    String formattedFutureValue = formatter.format(futureValue.roundToDouble().toInt());
    String formattedInvestedAmount = formatter.format(investedAmount.roundToDouble().toInt());
    String formattedEstimatedReturn = formatter.format(estimatedReturn.roundToDouble().toInt());

    state = SIPModel(estimatedReturn: formattedEstimatedReturn, futureValue: formattedFutureValue, investedAmount: formattedInvestedAmount, monthlyInvestment: monthlyInvestment, returnRate: returnRate, timePeriod: timePeriod);
  }
}

class SIPModel {
  final String monthlyInvestment;
  final String returnRate;
  final String timePeriod;
  final String futureValue;
  final String investedAmount;
  final String estimatedReturn;

  SIPModel({this.monthlyInvestment = "", this.estimatedReturn = "", this.futureValue = "", this.investedAmount = "", this.returnRate = "", this.timePeriod = ""});

  SIPModel copyWith({String? monthlyInvestment, String? returnRate, String? timePeriod, String? futureValue, String? investedAmount, String? estimatedReturn}) {
    return SIPModel(
        monthlyInvestment: monthlyInvestment ?? this.monthlyInvestment,
        estimatedReturn: estimatedReturn ?? this.estimatedReturn,
        futureValue: futureValue ?? this.futureValue,
        investedAmount: investedAmount ?? this.investedAmount,
        returnRate: returnRate ?? this.returnRate,
        timePeriod: timePeriod ?? this.timePeriod);
  }
}
