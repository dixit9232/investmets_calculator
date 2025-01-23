import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:investmets_calculator/widgets/custom-textfied.dart';

import '../global_variable.dart';
import '../providers/goal-planning-sip-provider.dart';
import '../widgets/custom_elevated_button.dart';

class GoalPlanningCalculatorSIPScreen extends ConsumerStatefulWidget {
  const GoalPlanningCalculatorSIPScreen({super.key});

  @override
  ConsumerState<GoalPlanningCalculatorSIPScreen> createState() => _GoalPlanningCalculatorSIPScreenState();
}

class _GoalPlanningCalculatorSIPScreenState extends ConsumerState<GoalPlanningCalculatorSIPScreen> {
  final TextEditingController futureValueController = TextEditingController(text: " 10000000");
  final TextEditingController returnRateController = TextEditingController(text: "12");
  final TextEditingController timePeriodController = TextEditingController(text: "10");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() => ref.read(goalPlanningSIPProvider.notifier).calculateSIPGoalPlanning(futureValue: futureValueController.text, returnRate: returnRateController.text, timePeriod: timePeriodController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Goal Planning Calculator (SIP)"),
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
                  labelText: "Future Value",
                  textEditingController: futureValueController,
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
                      final calculationRef = ref.watch(goalPlanningSIPProvider);
                      return Column(
                        spacing: 20,
                        children: [
                          Row(
                            children: [Text("Target Amount"), Spacer(), Text("${calculationRef.futureValue} $inr")],
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
                                "Amount to be invested monthly",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Text(
                                "${calculationRef.investingAmountToday} $inr",
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
                      if (futureValueController.text.isNotEmpty && returnRateController.text.isNotEmpty && timePeriodController.text.isNotEmpty) {
                        ref.read(goalPlanningSIPProvider.notifier).calculateSIPGoalPlanning(futureValue: futureValueController.text, returnRate: returnRateController.text, timePeriod: timePeriodController.text);
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
