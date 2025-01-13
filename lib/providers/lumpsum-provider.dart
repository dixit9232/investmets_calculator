import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final lumpsumProvider = StateNotifierProvider<LumpsumNotifier, LumpsumModel>((ref) {
  return LumpsumNotifier();
});

class LumpsumNotifier extends StateNotifier<LumpsumModel> {
  LumpsumNotifier() : super(LumpsumModel());

  void calculateLumpsum({required String totalInvestment, required String returnRate, required String timePeriod}) {
    double P = double.parse(totalInvestment);
    double r = double.parse(returnRate) / 100;
    int t = int.parse(timePeriod);

    double futureValue = P * pow((1 + r), (t));
    double investedAmount = P;
    double estimatedReturn = futureValue - investedAmount;

    final formatter = NumberFormat('#,##,###');
    String formattedFutureValue = formatter.format(futureValue.roundToDouble().toInt());
    String formattedInvestedAmount = formatter.format(investedAmount.roundToDouble().toInt());
    String formattedEstimatedReturn = formatter.format(estimatedReturn.roundToDouble().toInt());

    state = LumpsumModel(estimatedReturn: formattedEstimatedReturn, futureValue: formattedFutureValue, investedAmount: formattedInvestedAmount, totalInvestment: totalInvestment, returnRate: returnRate, timePeriod: timePeriod);
  }
}

class LumpsumModel {
  final String totalInvestment;
  final String returnRate;
  final String timePeriod;
  final String futureValue;
  final String investedAmount;
  final String estimatedReturn;

  LumpsumModel({this.totalInvestment = "", this.estimatedReturn = "", this.futureValue = "", this.investedAmount = "", this.returnRate = "", this.timePeriod = ""});

  LumpsumModel copyWith({String? totalInvestment, String? returnRate, String? timePeriod, String? futureValue, String? investedAmount, String? estimatedReturn}) {
    return LumpsumModel(
        totalInvestment: totalInvestment ?? this.totalInvestment,
        estimatedReturn: estimatedReturn ?? this.estimatedReturn,
        futureValue: futureValue ?? this.futureValue,
        investedAmount: investedAmount ?? this.investedAmount,
        returnRate: returnRate ?? this.returnRate,
        timePeriod: timePeriod ?? this.timePeriod);
  }
}
