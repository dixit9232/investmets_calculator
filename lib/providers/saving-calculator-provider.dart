import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final savingProvider = StateNotifierProvider<SavingNotifier, SavingModel>((ref) {
  return SavingNotifier();
});

class SavingNotifier extends StateNotifier<SavingModel> {
  SavingNotifier() : super(SavingModel());

  void calculateSaving({required String monthlyIncome, required String necessitiesPer, required String wantsPer, required String savingAndInvestmentPer}) {
    double mi = double.parse(monthlyIncome);
    double necessities = double.parse(necessitiesPer) / 100;
    double wants = double.parse(wantsPer) / 100;
    double savingInvestment = double.parse(savingAndInvestmentPer) / 100;
    double necessitiesValue = mi * necessities;
    double wantsValue = mi * wants;
    double savingInvestmentValue = mi * savingInvestment;

    NumberFormat numberFormat = NumberFormat("#,##,###");
    String formattedNecessities = numberFormat.format(necessitiesValue.roundToDouble().toInt());
    String formattedWants = numberFormat.format(wantsValue.roundToDouble().toInt());
    String formattedSavingAndInvestment = numberFormat.format(savingInvestmentValue.roundToDouble().toInt());
    String formattedMonthlyIncome = numberFormat.format(mi.roundToDouble().toInt());

    state = SavingModel(monthlyIncome: formattedMonthlyIncome, necessitiesPer: necessitiesPer, wantsPer: wantsPer, savingAndInvestmentPer: savingAndInvestmentPer, necessitiesValue: formattedNecessities, wantsValue: formattedWants, savingAndInvestmentValue: formattedSavingAndInvestment);
  }
}

class SavingModel {
  final String monthlyIncome;
  final String necessitiesPer;
  final String wantsPer;
  final String savingAndInvestmentPer;
  final String necessitiesValue;
  final String wantsValue;
  final String savingAndInvestmentValue;

  SavingModel({
    this.monthlyIncome = "",
    this.necessitiesPer = "",
    this.wantsPer = "",
    this.savingAndInvestmentPer = "",
    this.necessitiesValue = "",
    this.wantsValue = "",
    this.savingAndInvestmentValue = "",
  });

  SavingModel copyWith({
    String? monthlyIncome,
    String? necessitiesPer,
    String? wantsPer,
    String? savingAndInvestmentPer,
    String? necessitiesValue,
    String? wantsValue,
    String? savingAndInvestmentValue,
  }) {
    return SavingModel(
      monthlyIncome: monthlyIncome ?? this.monthlyIncome,
      necessitiesPer: necessitiesPer ?? this.necessitiesPer,
      wantsPer: wantsPer ?? this.wantsPer,
      savingAndInvestmentPer: savingAndInvestmentPer ?? this.savingAndInvestmentPer,
      necessitiesValue: necessitiesValue ?? this.necessitiesValue,
      wantsValue: wantsValue ?? this.wantsValue,
      savingAndInvestmentValue: savingAndInvestmentValue ?? this.savingAndInvestmentValue,
    );
  }
}
