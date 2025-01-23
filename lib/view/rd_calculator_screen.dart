import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:investmets_calculator/widgets/custom-textfied.dart';

import '../global_variable.dart';
import '../providers/rd-provider.dart';
import '../widgets/custom_elevated_button.dart';

class RDCalculatorScreen extends ConsumerStatefulWidget {
  const RDCalculatorScreen({super.key});

  @override
  ConsumerState<RDCalculatorScreen> createState() => _RDCalculatorScreenState();
}

class _RDCalculatorScreenState extends ConsumerState<RDCalculatorScreen> {
  final TextEditingController monthlyInvestmentController = TextEditingController(text: "10000");
  final TextEditingController returnRateController = TextEditingController(text: "12");
  final TextEditingController timePeriodController = TextEditingController(text: "10");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() => ref.read(rdProvider.notifier).calculateRD(monthlyInvestment: monthlyInvestmentController.text, returnRate: returnRateController.text, timePeriod: timePeriodController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RD Calculator"),
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
                  labelText: "Monthly Investment",
                  textEditingController: monthlyInvestmentController,
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
                      final calculationRef = ref.watch(rdProvider);
                      return Column(
                        spacing: 20,
                        children: [
                          Row(
                            children: [Text("Total Investment"), Spacer(), Text("${calculationRef.monthlyInvestment} $inr")],
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
                            children: [Text("Invested Amount"), Spacer(), Text("${calculationRef.investedAmount} $inr")],
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
                CustomElevatedButton(
                    onClick: () {
                      if (monthlyInvestmentController.text.isNotEmpty && returnRateController.text.isNotEmpty && timePeriodController.text.isNotEmpty) {
                        ref.read(rdProvider.notifier).calculateRD(monthlyInvestment: monthlyInvestmentController.text, returnRate: returnRateController.text, timePeriod: timePeriodController.text);
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
