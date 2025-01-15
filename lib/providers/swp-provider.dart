import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final swpProvider = StateNotifierProvider<SWPNotifier, SWPModel>((ref) {
  return SWPNotifier();
});

class SWPNotifier extends StateNotifier<SWPModel> {
  SWPNotifier() : super(SWPModel());

  void calculateSWP({
    required String totalInvestment,
    required String returnRate,
    required String timePeriod,
    required String withdrawalPerMonth,
  }) {
    double investment = double.parse(totalInvestment);
    double annualRate = double.parse(returnRate);
    int years = int.parse(timePeriod);
    double withdrawal = double.parse(withdrawalPerMonth);
    int totalMonths = years * 12;
    double monthlyRate = pow(1 + annualRate / 100, 1 / 12) - 1;

    double futureValue = investment * pow(1 + monthlyRate, totalMonths) - withdrawal * (pow(1 + monthlyRate, totalMonths) - 1) / monthlyRate;

    double totalWithdrawals = withdrawal * totalMonths;
    double estimatedReturns = (futureValue + totalWithdrawals) - investment;

    final formatter = NumberFormat('#,##,###');
    String formattedFutureValue = formatter.format(futureValue.roundToDouble().toInt());
    String formattedTotalWithdrawals = formatter.format(totalWithdrawals.roundToDouble().toInt());
    String formattedEstimatedReturn = formatter.format(estimatedReturns.roundToDouble().toInt());
    String formattedWithdrawalAmount = formatter.format(withdrawal.roundToDouble().toInt());
    String formattedTotalInvestment = formatter.format(investment.roundToDouble().toInt());

    state = SWPModel(
      withdrawalPerMonth: formattedWithdrawalAmount,
      timePeriod: timePeriod,
      returnRate: returnRate,
      futureValue: formattedFutureValue,
      estimatedReturn: formattedEstimatedReturn,
      totalInvestment: formattedTotalInvestment,
      totalWithdrawal: formattedTotalWithdrawals,
    );
  }
}

class SWPModel {
  final String totalInvestment;
  final String withdrawalPerMonth;
  final String returnRate;
  final String timePeriod;
  final String futureValue;
  final String totalWithdrawal;
  final String estimatedReturn;

  SWPModel({this.withdrawalPerMonth = "", this.totalInvestment = "", this.estimatedReturn = "", this.futureValue = "", this.totalWithdrawal = "", this.returnRate = "", this.timePeriod = ""});

  SWPModel copyWith({String? withdrawalPerMonth, String? totalInvestment, String? returnRate, String? timePeriod, String? futureValue, String? totalWithdrawal, String? estimatedReturn}) {
    return SWPModel(
        totalInvestment: totalInvestment ?? this.totalInvestment,
        withdrawalPerMonth: withdrawalPerMonth ?? this.withdrawalPerMonth,
        estimatedReturn: estimatedReturn ?? this.estimatedReturn,
        futureValue: futureValue ?? this.futureValue,
        totalWithdrawal: totalWithdrawal ?? this.totalWithdrawal,
        returnRate: returnRate ?? this.returnRate,
        timePeriod: timePeriod ?? this.timePeriod);
  }
}
