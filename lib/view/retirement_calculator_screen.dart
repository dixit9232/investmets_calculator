import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:investmets_calculator/widgets/custom-textfied.dart';

import '../global_variable.dart';
import '../providers/retirement-provider.dart';
import '../widgets/custom_elevated_button.dart';

class RetirementCalculatorScreen extends ConsumerStatefulWidget {
  const RetirementCalculatorScreen({super.key});

  @override
  ConsumerState<RetirementCalculatorScreen> createState() => _RetirementCalculatorScreenState();
}

class _RetirementCalculatorScreenState extends ConsumerState<RetirementCalculatorScreen> {
  final TextEditingController annualExpenseController = TextEditingController(text: "420000");
  final TextEditingController returnRate = TextEditingController(text: "12");
  final TextEditingController inflationRate = TextEditingController(text: "6");
  final TextEditingController currentAge = TextEditingController(text: '40');
  final TextEditingController retirementAge = TextEditingController(text: '60');
  final TextEditingController lifeExpectancy = TextEditingController(text: '80');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() => ref.read(retirementProvider.notifier).calculateRetirement(
          annualExpense: annualExpenseController.text,
          returnRate: returnRate.text,
          inflationRate: inflationRate.text,
          currentAge: currentAge.text,
          retirementAge: retirementAge.text,
          lifeExpectancy: lifeExpectancy.text,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Retirement Calculator"),
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
                  labelText: "Annual Expense amount",
                  textEditingController: annualExpenseController,
                  suffixIcon: Text(
                    inr,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                CustomTextField(
                  labelText: "Expected Return (p.a.)",
                  textEditingController: returnRate,
                  suffixIcon: Text(
                    "%",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                CustomTextField(
                  labelText: "Expected Inflation Rate (p.a.)",
                  textEditingController: inflationRate,
                  suffixIcon: Text(
                    "%",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                CustomTextField(
                  labelText: "Retirement Age (Year)",
                  textEditingController: retirementAge,
                  suffixIcon: Text(
                    "Yr.",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                CustomTextField(
                  labelText: "Current Age (Year)",
                  textEditingController: currentAge,
                  suffixIcon: Text(
                    "Yr.",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                CustomTextField(
                  labelText: "Life Expectancy (Year)",
                  textEditingController: lifeExpectancy,
                  suffixIcon: Text(
                    "Yr.",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                SizedBox(),
                SizedBox(
                  width: width(context) * 0.9,
                  child: Consumer(
                    builder: (context, ref, child) {
                      final calculationRef = ref.watch(retirementProvider);
                      return Column(
                        spacing: 20,
                        children: [
                          Row(
                            children: [Text("Annual Expense amount"), Spacer(), Text("${calculationRef.annualExpense} $inr")],
                          ),
                          Row(
                            children: [Text("Expected Return (p.a.)"), Spacer(), Text("${calculationRef.returnRate} %")],
                          ),
                          Row(
                            children: [Text("Inflation Rate (p.a.)"), Spacer(), Text("${calculationRef.inflationRate} %")],
                          ),
                          Row(
                            children: [Text("Retirement Age (Year)"), Spacer(), Text("${calculationRef.retirementAge} Yr.")],
                          ),
                          Row(
                            children: [Text("Current Age (Year)"), Spacer(), Text("${calculationRef.currentAge} Yr.")],
                          ),
                          Row(
                            children: [Text("Period for Retirement"), Spacer(), Text("${calculationRef.periodForRetirement} Yr.")],
                          ),
                          Row(
                            children: [Text("Life Expectancy"), Spacer(), Text("${calculationRef.lifeExpectancy} Yr.")],
                          ),
                          Row(
                            children: [Text("Period After Retirement"), Spacer(), Text("${calculationRef.periodAfterRetirement} Yr.")],
                          ),
                          Row(
                            children: [
                              Text(
                                "Annual Expense at Retirement Age",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Text(
                                "${calculationRef.annualExpenseAtRetirementAge} $inr",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Retirement Corpus Needed",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Text(
                                "${calculationRef.retirementCorpusNeeded} $inr",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Monthly Investment",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Text(
                                "${calculationRef.monthlyInvestment} $inr",
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
                      if (annualExpenseController.text.isNotEmpty && returnRate.text.isNotEmpty && currentAge.text.isNotEmpty && lifeExpectancy.text.isNotEmpty && retirementAge.text.isNotEmpty && inflationRate.text.isNotEmpty) {
                        ref.read(retirementProvider.notifier).calculateRetirement(annualExpense: annualExpenseController.text, returnRate: returnRate.text, inflationRate: inflationRate.text, currentAge: currentAge.text, retirementAge: retirementAge.text, lifeExpectancy: lifeExpectancy.text);
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
