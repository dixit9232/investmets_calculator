import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final goalPlanningLumpsumProvider = StateNotifierProvider<LumpsumGoalPlanningNotifier, LumpsumGoalPlanningModel>((ref) {
  return LumpsumGoalPlanningNotifier();
});

class LumpsumGoalPlanningNotifier extends StateNotifier<LumpsumGoalPlanningModel> {
  LumpsumGoalPlanningNotifier() : super(LumpsumGoalPlanningModel());

  void calculateLumpsumGoalPlanning({required String futureValue, required String returnRate, required String timePeriod}) {
    double fv = double.parse(futureValue);
    double r = double.parse(returnRate) / 100;
    int t = int.parse(timePeriod);

    double presentValue = fv / pow(1 + r, t);
    final NumberFormat numberFormat = NumberFormat("#,##,###");
    String investingAmount = numberFormat.format(presentValue.roundToDouble().toInt());

    state = LumpsumGoalPlanningModel(investingAmountToday: investingAmount, futureValue: futureValue, returnRate: returnRate, timePeriod: timePeriod);
  }
}

class LumpsumGoalPlanningModel {
  final String investingAmountToday;
  final String returnRate;
  final String timePeriod;
  final String futureValue;

  LumpsumGoalPlanningModel({this.investingAmountToday = "", this.futureValue = "", this.returnRate = "", this.timePeriod = ""});

  LumpsumGoalPlanningModel copyWith({
    String? investingAmountToday,
    String? returnRate,
    String? timePeriod,
    String? futureValue,
  }) {
    return LumpsumGoalPlanningModel(investingAmountToday: investingAmountToday ?? this.investingAmountToday, futureValue: futureValue ?? this.futureValue, returnRate: returnRate ?? this.returnRate, timePeriod: timePeriod ?? this.timePeriod);
  }
}
