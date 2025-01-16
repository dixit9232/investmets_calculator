import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final stepUpSIPProvider = StateNotifierProvider<StepUpSIPNotifier, StepUpSIPModel>((ref) {
  return StepUpSIPNotifier();
});

class StepUpSIPNotifier extends StateNotifier<StepUpSIPModel> {
  StepUpSIPNotifier() : super(StepUpSIPModel());

  void calculateStepUpSIP({
    required String monthlyInvestment,
    required String returnRate,
    required String timePeriod,
    required String growthRate,
  }) {
    double initialInvestment = double.parse(monthlyInvestment);
    double gr = double.parse(growthRate) / 100;
    double rateOfInterest = double.parse(returnRate) / 100;
    int period = int.parse(timePeriod) * 12;

    double monthlyRate = rateOfInterest / 12;
    double investedAmount = 0.0;
    double currentBalance = 0;
    double monthlyReturn = 0.00;
    NumberFormat numberFormat = NumberFormat('#,##,###');

    for (int month = 0; month < period; month++) {
      double monthlyInvestment = initialInvestment;
      if (month > 0 && month % 12 == 0) {
        monthlyInvestment *= (1 + gr);
        initialInvestment = monthlyInvestment;
      }
      monthlyReturn = (currentBalance + monthlyInvestment) * monthlyRate;
      currentBalance += monthlyReturn + monthlyInvestment;
      investedAmount += monthlyInvestment;
    }

    state = state.copyWith(
      growthRate: growthRate,
      monthlyInvestment: numberFormat.format(initialInvestment),
      returnRate: returnRate,
      timePeriod: timePeriod,
      futureValue: numberFormat.format(currentBalance.roundToDouble().toInt()),
      investedAmount: numberFormat.format(investedAmount.roundToDouble().toInt()),
      estimatedReturn: numberFormat.format((currentBalance - investedAmount).roundToDouble().toInt()),
    );
  }
}

class StepUpSIPModel {
  final String monthlyInvestment;
  final String returnRate;
  final String growthRate;
  final String timePeriod;
  final String futureValue;
  final String investedAmount;
  final String estimatedReturn;

  StepUpSIPModel({this.monthlyInvestment = "", this.estimatedReturn = "", this.futureValue = "", this.investedAmount = "", this.returnRate = "", this.timePeriod = "", this.growthRate = ""});

  StepUpSIPModel copyWith({String? monthlyInvestment, String? returnRate, String? timePeriod, String? futureValue, String? investedAmount, String? estimatedReturn, String? growthRate}) {
    return StepUpSIPModel(
        growthRate: growthRate ?? this.growthRate,
        monthlyInvestment: monthlyInvestment ?? this.monthlyInvestment,
        estimatedReturn: estimatedReturn ?? this.estimatedReturn,
        futureValue: futureValue ?? this.futureValue,
        investedAmount: investedAmount ?? this.investedAmount,
        returnRate: returnRate ?? this.returnRate,
        timePeriod: timePeriod ?? this.timePeriod);
  }
}
