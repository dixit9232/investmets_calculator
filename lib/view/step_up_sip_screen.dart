import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:investmets_calculator/widgets/custom-textfied.dart';

import '../global_variable.dart';
import '../providers/step-up-sip-provider.dart';
import '../widgets/custom_elevated_button.dart';

class StepUpSIPCalculatorScreen extends ConsumerStatefulWidget {
  const StepUpSIPCalculatorScreen({super.key});

  @override
  ConsumerState<StepUpSIPCalculatorScreen> createState() => _StepUpSIPCalculatorScreenState();
}

class _StepUpSIPCalculatorScreenState extends ConsumerState<StepUpSIPCalculatorScreen> {
  final TextEditingController monthlyInvestmentController = TextEditingController(text: "10000");
  final TextEditingController returnRateController = TextEditingController(text: "12");
  final TextEditingController growthController = TextEditingController(text: "10");

  final TextEditingController timePeriodController = TextEditingController(text: "10");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() => ref.read(stepUpSIPProvider.notifier).calculateStepUpSIP(growthRate: growthController.text, monthlyInvestment: monthlyInvestmentController.text, returnRate: returnRateController.text, timePeriod: timePeriodController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Step-Up SIP Calculator"),
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
                  labelText: "Growth Rate (p.a.)",
                  textEditingController: growthController,
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
                      final calculationRef = ref.watch(stepUpSIPProvider);
                      return Column(
                        spacing: 20,
                        children: [
                          Row(
                            children: [Text("Monthly Investment"), Spacer(), Text("${calculationRef.monthlyInvestment} $inr")],
                          ),
                          Row(
                            children: [Text("Expected Return (p.a.)"), Spacer(), Text("${calculationRef.returnRate} %")],
                          ),
                          Row(
                            children: [Text("Growth Return (p.a.)"), Spacer(), Text("${calculationRef.growthRate} %")],
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
                      if (monthlyInvestmentController.text.isNotEmpty && returnRateController.text.isNotEmpty && timePeriodController.text.isNotEmpty && growthController.text.isNotEmpty) {
                        ref.read(stepUpSIPProvider.notifier).calculateStepUpSIP(growthRate: growthController.text, monthlyInvestment: monthlyInvestmentController.text, returnRate: returnRateController.text, timePeriod: timePeriodController.text);
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
