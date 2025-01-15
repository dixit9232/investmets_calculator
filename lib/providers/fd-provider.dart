import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final fdProvider = StateNotifierProvider<FDNotifier, FDModel>((ref) {
  return FDNotifier();
});

class FDNotifier extends StateNotifier<FDModel> {
  FDNotifier() : super(FDModel());

  void calculateFD({required String totalInvestment, required String returnRate, required String timePeriod}) {
    double P = double.parse(totalInvestment);
    double r = double.parse(returnRate) / 100;
    int t = int.parse(timePeriod);

    double futureValue = P * pow((1 + r), (t));
    double investedAmount = P;
    double estimatedReturn = futureValue - investedAmount;

    final formatter = NumberFormat('#,##,###');
    String formattedFutureValue = formatter.format(futureValue.roundToDouble().toInt());
    String formattedP = formatter.format(P.roundToDouble().toInt());
    String formattedInvestedAmount = formatter.format(investedAmount.roundToDouble().toInt());
    String formattedEstimatedReturn = formatter.format(estimatedReturn.roundToDouble().toInt());

    state = FDModel(estimatedReturn: formattedEstimatedReturn, futureValue: formattedFutureValue, investedAmount: formattedInvestedAmount, totalInvestment: formattedP, returnRate: returnRate, timePeriod: timePeriod);
  }
}

class FDModel {
  final String totalInvestment;
  final String returnRate;
  final String timePeriod;
  final String futureValue;
  final String investedAmount;
  final String estimatedReturn;

  FDModel({this.totalInvestment = "", this.estimatedReturn = "", this.futureValue = "", this.investedAmount = "", this.returnRate = "", this.timePeriod = ""});

  FDModel copyWith({String? totalInvestment, String? returnRate, String? timePeriod, String? futureValue, String? investedAmount, String? estimatedReturn}) {
    return FDModel(
        totalInvestment: totalInvestment ?? this.totalInvestment,
        estimatedReturn: estimatedReturn ?? this.estimatedReturn,
        futureValue: futureValue ?? this.futureValue,
        investedAmount: investedAmount ?? this.investedAmount,
        returnRate: returnRate ?? this.returnRate,
        timePeriod: timePeriod ?? this.timePeriod);
  }
}
