import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final goalPlanningProvider = StateNotifierProvider<GoalPlanningNotifier, GoalPlanningModel>((ref) {
  return GoalPlanningNotifier();
});

class GoalPlanningNotifier extends StateNotifier<GoalPlanningModel> {
  GoalPlanningNotifier() : super(GoalPlanningModel());

  void calculateGoalPlanning({required String futureValue, required String returnRate, required String timePeriod}) {
    double fv = double.parse(futureValue);
    double r = double.parse(returnRate) / 100;
    int t = int.parse(timePeriod);

    double presentValue = fv / pow(1 + r, t);
    final NumberFormat numberFormat = NumberFormat("#,##,###");
    String investingAmount = numberFormat.format(presentValue.roundToDouble().toInt());

    state = GoalPlanningModel(investingAmountToday: investingAmount, futureValue: futureValue, returnRate: returnRate, timePeriod: timePeriod);
  }
}

class GoalPlanningModel {
  final String investingAmountToday;
  final String returnRate;
  final String timePeriod;
  final String futureValue;

  GoalPlanningModel({this.investingAmountToday = "", this.futureValue = "", this.returnRate = "", this.timePeriod = ""});

  GoalPlanningModel copyWith({
    String? investingAmountToday,
    String? returnRate,
    String? timePeriod,
    String? futureValue,
  }) {
    return GoalPlanningModel(investingAmountToday: investingAmountToday ?? this.investingAmountToday, futureValue: futureValue ?? this.futureValue, returnRate: returnRate ?? this.returnRate, timePeriod: timePeriod ?? this.timePeriod);
  }
}
