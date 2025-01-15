import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final rdProvider = StateNotifierProvider<RDNotifier, RDModel>((ref) {
  return RDNotifier();
});

class RDNotifier extends StateNotifier<RDModel> {
  RDNotifier() : super(RDModel());

  void calculateRD({required String monthlyInvestment, required String returnRate, required String timePeriod}) {
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
    String formattedMonthlyInvestment = formatter.format(P.roundToDouble().toInt());

    state = RDModel(estimatedReturn: formattedEstimatedReturn, futureValue: formattedFutureValue, investedAmount: formattedInvestedAmount, monthlyInvestment: formattedMonthlyInvestment, returnRate: returnRate, timePeriod: timePeriod);
  }
}

class RDModel {
  final String monthlyInvestment;
  final String returnRate;
  final String timePeriod;
  final String futureValue;
  final String investedAmount;
  final String estimatedReturn;

  RDModel({this.monthlyInvestment = "", this.estimatedReturn = "", this.futureValue = "", this.investedAmount = "", this.returnRate = "", this.timePeriod = ""});

  RDModel copyWith({String? monthlyInvestment, String? returnRate, String? timePeriod, String? futureValue, String? investedAmount, String? estimatedReturn}) {
    return RDModel(
        monthlyInvestment: monthlyInvestment ?? this.monthlyInvestment,
        estimatedReturn: estimatedReturn ?? this.estimatedReturn,
        futureValue: futureValue ?? this.futureValue,
        investedAmount: investedAmount ?? this.investedAmount,
        returnRate: returnRate ?? this.returnRate,
        timePeriod: timePeriod ?? this.timePeriod);
  }
}
