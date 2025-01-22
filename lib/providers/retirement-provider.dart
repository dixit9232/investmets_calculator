import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final retirementProvider = StateNotifierProvider<RetirementNotifier, RetirementModel>((ref) {
  return RetirementNotifier();
});

class RetirementNotifier extends StateNotifier<RetirementModel> {
  RetirementNotifier() : super(RetirementModel());

  void calculateRetirement({
    required String annualExpense,
    required String returnRate,
    required String inflationRate,
    required String currentAge,
    required String retirementAge,
    required String lifeExpectancy,
  }) {
    NumberFormat numberFormat = NumberFormat("#,##,###");

    double pv = double.parse(annualExpense);
    double yearlyReturn = double.parse(returnRate) / 100;
    double inflationRateValue = double.parse(inflationRate) / 100;
    int currentAgeValue = int.parse(currentAge);
    int retirementAgeValue = int.parse(retirementAge);
    int lifeExpectancyValue = int.parse(lifeExpectancy);

    int yearsUntilRetirement = retirementAgeValue - currentAgeValue;
    int yearsAfterRetirement = lifeExpectancyValue - retirementAgeValue;

    double annualExpenseAtRetirementAge = pv * pow((1 + inflationRateValue), yearsUntilRetirement);

    double r = yearlyReturn - inflationRateValue;

    double retirementCorpusNeeded = annualExpenseAtRetirementAge * (1 - pow(1 + r, -yearsAfterRetirement)) / r * (1 / 1 + r);
    double monthlyInvestment = retirementCorpusNeeded / (((pow((1 + (yearlyReturn / 12)), (yearsUntilRetirement * 12)) - 1) / (yearlyReturn / 12)) * (1 + (yearlyReturn / 12)));
    String formattedAnnualExpense = numberFormat.format(pv.roundToDouble().toInt());
    String formattedAnnualExpenseAtRetirement = numberFormat.format(annualExpenseAtRetirementAge.roundToDouble().toInt());
    String formattedRetirementCorpusNeeded = numberFormat.format(retirementCorpusNeeded.roundToDouble().toInt());
    String formattedMonthlyInvestment = numberFormat.format(monthlyInvestment.roundToDouble().toInt());

    state = RetirementModel(
      annualExpenseAtRetirementAge: formattedAnnualExpenseAtRetirement,
      retirementCorpusNeeded: formattedRetirementCorpusNeeded,
      monthlyInvestment: formattedMonthlyInvestment,
      annualExpense: formattedAnnualExpense,
      returnRate: returnRate,
      inflationRate: inflationRate,
      currentAge: currentAge,
      lifeExpectancy: lifeExpectancy,
      retirementAge: retirementAge,
      periodForRetirement: yearsUntilRetirement.toString(),
      periodAfterRetirement: yearsAfterRetirement.toString(),
    );
  }
}

class RetirementModel {
  final String annualExpense;
  final String returnRate;
  final String inflationRate;
  final String retirementAge;
  final String currentAge;
  final String periodForRetirement;
  final String lifeExpectancy;
  final String periodAfterRetirement;
  final String annualExpenseAtRetirementAge;
  final String retirementCorpusNeeded;
  final String monthlyInvestment;

  RetirementModel({
    this.annualExpense = '',
    this.returnRate = '',
    this.inflationRate = '',
    this.retirementAge = '',
    this.currentAge = '',
    this.periodForRetirement = '',
    this.lifeExpectancy = '',
    this.periodAfterRetirement = '',
    this.annualExpenseAtRetirementAge = '',
    this.retirementCorpusNeeded = '',
    this.monthlyInvestment = '',
  });

  RetirementModel copyWith({
    String? annualExpense,
    String? returnRate,
    String? inflationRate,
    String? retirementAge,
    String? currentAge,
    String? periodForRetirement,
    String? lifeExpectancy,
    String? periodAfterRetirement,
    String? annualExpenseAtRetirementAge,
    String? retirementCorpusNeeded,
    String? monthlyInvestment,
  }) {
    return RetirementModel(
      annualExpense: annualExpense ?? this.annualExpense,
      returnRate: returnRate ?? this.returnRate,
      inflationRate: inflationRate ?? this.inflationRate,
      retirementAge: retirementAge ?? this.retirementAge,
      currentAge: currentAge ?? this.currentAge,
      periodForRetirement: periodForRetirement ?? this.periodForRetirement,
      lifeExpectancy: lifeExpectancy ?? this.lifeExpectancy,
      periodAfterRetirement: periodAfterRetirement ?? this.periodAfterRetirement,
      annualExpenseAtRetirementAge: annualExpenseAtRetirementAge ?? this.annualExpenseAtRetirementAge,
      retirementCorpusNeeded: retirementCorpusNeeded ?? this.retirementCorpusNeeded,
      monthlyInvestment: monthlyInvestment ?? this.monthlyInvestment,
    );
  }
}
