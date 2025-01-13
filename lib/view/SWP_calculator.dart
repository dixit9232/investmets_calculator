import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:investmets_calculator/providers/swp-provider.dart';
import 'package:investmets_calculator/widgets/custom-textfied.dart';

import '../global_variable.dart';

class SWPCalculatorScreen extends ConsumerStatefulWidget {
  const SWPCalculatorScreen({super.key});

  @override
  ConsumerState<SWPCalculatorScreen> createState() => _SWPCalculatorScreenState();
}

class _SWPCalculatorScreenState extends ConsumerState<SWPCalculatorScreen> {
  final TextEditingController totalInvestmentController = TextEditingController(text: " 1000000");
  final TextEditingController withdrawalPerMonthController = TextEditingController(text: "10000");
  final TextEditingController returnRateController = TextEditingController(text: "8");
  final TextEditingController timePeriodController = TextEditingController(text: "10");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(
      () => ref.read(swpProvider.notifier).calculateSWP(totalInvestment: totalInvestmentController.text, withdrawalPerMonth: withdrawalPerMonthController.text, returnRate: returnRateController.text, timePeriod: timePeriodController.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SWP (Systematic Withdrawal Plan) Calculator"),
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
                  labelText: "Total Investment",
                  textEditingController: totalInvestmentController,
                  suffixIcon: Text(
                    inr,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                CustomTextField(
                  labelText: "Withdrawal per month",
                  textEditingController: withdrawalPerMonthController,
                  suffixIcon: Text(
                    inr,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                CustomTextField(
                  labelText: "Expected Return (p.a.)",
                  textEditingController: returnRateController,
                  suffixIcon: Text(
                    "%",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                CustomTextField(
                  labelText: "Time period",
                  textEditingController: timePeriodController,
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
                      final calculationRef = ref.watch(swpProvider);
                      return Column(
                        spacing: 20,
                        children: [
                          Row(
                            children: [Text("Total Investment"), Spacer(), Text("${calculationRef.totalInvestment} $inr")],
                          ),
                          Row(
                            children: [Text("Withdrawal per month"), Spacer(), Text("${calculationRef.withdrawalPerMonth} $inr")],
                          ),
                          Row(
                            children: [Text("Expected Return (p.a.)"), Spacer(), Text("${calculationRef.returnRate} %")],
                          ),
                          Row(
                            children: [Text("Time period (years)"), Spacer(), Text("${calculationRef.timePeriod} Yr.")],
                          ),
                          Row(
                            children: [
                              Text(
                                "Future Value",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Text(
                                "${calculationRef.futureValue} $inr",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Row(
                            children: [Text("Total Withdrawal"), Spacer(), Text("${calculationRef.totalWithdrawal} $inr")],
                          ),
                          Row(
                            children: [Text("Estimated Return"), Spacer(), Text("${calculationRef.estimatedReturn} $inr")],
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(),
                SizedBox(),
                ElevatedButton(
                    onPressed: () {
                      if (totalInvestmentController.text.isNotEmpty && returnRateController.text.isNotEmpty && timePeriodController.text.isNotEmpty && withdrawalPerMonthController.text.isNotEmpty) {
                        ref.read(swpProvider.notifier).calculateSWP(totalInvestment: totalInvestmentController.text, withdrawalPerMonth: withdrawalPerMonthController.text, returnRate: returnRateController.text, timePeriod: timePeriodController.text);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Fill the Field")));
                      }
                    },
                    child: Text(
                      "Calculate",
                      style: TextTheme.of(context).bodyMedium?.copyWith(color: Colors.white),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
