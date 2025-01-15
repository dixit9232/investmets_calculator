import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final goalPlanningSIPProvider = StateNotifierProvider<SIPGoalPlanningNotifier, SIPGoalPlanningModel>((ref) {
  return SIPGoalPlanningNotifier();
});

class SIPGoalPlanningNotifier extends StateNotifier<SIPGoalPlanningModel> {
  SIPGoalPlanningNotifier() : super(SIPGoalPlanningModel());

  void calculateSIPGoalPlanning({required String futureValue, required String returnRate, required String timePeriod}) {
    double fv = double.parse(futureValue);
    double r = (double.parse(returnRate) / 100) / 12;
    int t = int.parse(timePeriod) * 12;

    double presentValue = fv / (((pow(1 + r, t) - 1) / r) * (1 + r));
    final NumberFormat numberFormat = NumberFormat("#,##,###");
    String investingAmount = numberFormat.format(presentValue.roundToDouble().toInt());

    state = SIPGoalPlanningModel(investingAmountToday: investingAmount, futureValue: futureValue, returnRate: returnRate, timePeriod: timePeriod);
  }
}

class SIPGoalPlanningModel {
  final String investingAmountToday;
  final String returnRate;
  final String timePeriod;
  final String futureValue;

  SIPGoalPlanningModel({this.investingAmountToday = "", this.futureValue = "", this.returnRate = "", this.timePeriod = ""});

  SIPGoalPlanningModel copyWith({
    String? investingAmountToday,
    String? returnRate,
    String? timePeriod,
    String? futureValue,
  }) {
    return SIPGoalPlanningModel(investingAmountToday: investingAmountToday ?? this.investingAmountToday, futureValue: futureValue ?? this.futureValue, returnRate: returnRate ?? this.returnRate, timePeriod: timePeriod ?? this.timePeriod);
  }
}
