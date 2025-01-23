import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:investmets_calculator/providers/saving-calculator-provider.dart';
import 'package:investmets_calculator/widgets/custom-textfied.dart';

import '../global_variable.dart';
import '../widgets/custom_elevated_button.dart';

class SavingCalculatorScreen extends ConsumerStatefulWidget {
  const SavingCalculatorScreen({super.key});

  @override
  ConsumerState<SavingCalculatorScreen> createState() => _SavingCalculatorScreenState();
}

class _SavingCalculatorScreenState extends ConsumerState<SavingCalculatorScreen> {
  final TextEditingController monthlyIncomeController = TextEditingController(text: "100000");
  final TextEditingController necessitiesController = TextEditingController(text: "50");
  final TextEditingController wantsController = TextEditingController(text: "30");
  final TextEditingController savingAndInvestmentController = TextEditingController(text: "20");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() => ref.read(savingProvider.notifier).calculateSaving(monthlyIncome: monthlyIncomeController.text, necessitiesPer: necessitiesController.text, savingAndInvestmentPer: savingAndInvestmentController.text, wantsPer: wantsController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Saving Calculator"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 20,
              children: [
                CustomTextField(
                  labelText: "Monthly Income",
                  textEditingController: monthlyIncomeController,
                  suffixIcon: Text(
                    inr,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                CustomTextField(
                  labelText: "Necessities",
                  textEditingController: necessitiesController,
                  suffixIcon: Text(
                    "%",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                CustomTextField(
                  labelText: "Wants",
                  textEditingController: wantsController,
                  suffixIcon: Text(
                    "%",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                CustomTextField(
                  labelText: "Saving and Investment",
                  textEditingController: savingAndInvestmentController,
                  suffixIcon: Text(
                    "%",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                SizedBox(),
                SizedBox(
                  width: width(context) * 0.9,
                  child: Consumer(
                    builder: (context, ref, child) {
                      final calculationRef = ref.watch(savingProvider);
                      return Column(
                        spacing: 20,
                        children: [
                          Row(
                            children: [Text("Monthly Income"), Spacer(), Text("${calculationRef.monthlyIncome} $inr")],
                          ),
                          Row(
                            children: [Text("Necessities"), Spacer(), Text("${calculationRef.necessitiesPer} %")],
                          ),
                          Row(
                            children: [Text("Wants"), Spacer(), Text("${calculationRef.wantsPer} %")],
                          ),
                          Row(
                            children: [Text("Saving and Investment"), Spacer(), Text("${calculationRef.savingAndInvestmentPer} %")],
                          ),
                          Row(
                            children: [
                              Text(
                                "Necessities Value",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Text(
                                "${calculationRef.necessitiesValue} $inr",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Wants Value",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Text(
                                "${calculationRef.wantsValue} $inr",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Saving and Investment Value",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Text(
                                "${calculationRef.savingAndInvestmentValue} $inr",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(),
                SizedBox(),
                CustomElevatedButton(
                    onClick: () {
                      if (monthlyIncomeController.text.isNotEmpty && savingAndInvestmentController.text.isNotEmpty && wantsController.text.isNotEmpty && necessitiesController.text.isNotEmpty) {
                        ref.read(savingProvider.notifier).calculateSaving(monthlyIncome: monthlyIncomeController.text, necessitiesPer: necessitiesController.text, savingAndInvestmentPer: savingAndInvestmentController.text, wantsPer: wantsController.text);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Fill the Field")));
                      }
                    },
                    text: "Calculate")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
