import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:investmets_calculator/widgets/custom-textfied.dart';

import '../global_variable.dart';
import '../providers/cagr-provider.dart';
import '../widgets/custom_elevated_button.dart';

class CAGRCalculatorScreen extends ConsumerStatefulWidget {
  const CAGRCalculatorScreen({super.key});

  @override
  ConsumerState<CAGRCalculatorScreen> createState() => _CAGRCalculatorScreenState();
}

class _CAGRCalculatorScreenState extends ConsumerState<CAGRCalculatorScreen> {
  final TextEditingController fvController = TextEditingController(text: "3000");
  final TextEditingController pvController = TextEditingController(text: "1000");
  final TextEditingController timePeriodController = TextEditingController(text: "10");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() => ref.read(cagrProvider.notifier).calculateCAGR(presentValue: pvController.text, futureValue: fvController.text, timePeriod: timePeriodController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CAGR Calculator"),
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
                  labelText: " Present Value",
                  textEditingController: pvController,
                  suffixIcon: Text(
                    inr,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                CustomTextField(
                  labelText: "Future Value",
                  textEditingController: fvController,
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
                      final calculationRef = ref.watch(cagrProvider);
                      return Column(
                        spacing: 20,
                        children: [
                          Row(
                            children: [Text("Beginning Value"), Spacer(), Text("${calculationRef.presentValue} $inr")],
                          ),
                          Row(
                            children: [Text("Ending Value"), Spacer(), Text("${calculationRef.futureValue} %")],
                          ),
                          Row(
                            children: [Text("Time period (years)"), Spacer(), Text("${calculationRef.timePeriod} Yr.")],
                          ),
                          Row(
                            children: [
                              Text(
                                "Monthly CAGR value",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Text(
                                "${calculationRef.cagr} %",
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
                    if (pvController.text.isNotEmpty && fvController.text.isNotEmpty && timePeriodController.text.isNotEmpty) {
                      ref.read(cagrProvider.notifier).calculateCAGR(presentValue: pvController.text, futureValue: fvController.text, timePeriod: timePeriodController.text);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Fill the Field")));
                    }
                  },
                  text: "Calculate",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
