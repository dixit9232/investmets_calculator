import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:investmets_calculator/widgets/custom-textfied.dart';

import '../global_variable.dart';
import '../providers/emi-provider.dart';

class EMICalculatorScreen extends ConsumerStatefulWidget {
  const EMICalculatorScreen({super.key});

  @override
  ConsumerState<EMICalculatorScreen> createState() => _EMICalculatorScreenState();
}

class _EMICalculatorScreenState extends ConsumerState<EMICalculatorScreen> {
  final TextEditingController totalLoanAmountController = TextEditingController(text: "1000000");
  final TextEditingController interestRateController = TextEditingController(text: "12");
  final TextEditingController timePeriodController = TextEditingController(text: "10");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() => ref.read(emiProvider.notifier).calculateEMI(loanAmount: totalLoanAmountController.text, rateOfInterest: interestRateController.text, timePeriod: timePeriodController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("EMI Calculator"),
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
                  labelText: " Total loan amount",
                  textEditingController: totalLoanAmountController,
                  suffixIcon: Text(
                    inr,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                CustomTextField(
                  labelText: "Rate of interest (p.a.)",
                  textEditingController: interestRateController,
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
                      final calculationRef = ref.watch(emiProvider);
                      return Column(
                        spacing: 20,
                        children: [
                          Row(
                            children: [Text("Loan Amount"), Spacer(), Text("${calculationRef.loanAmount} $inr")],
                          ),
                          Row(
                            children: [Text("Interest Rate (p.a.)"), Spacer(), Text("${calculationRef.rateOfInterest} %")],
                          ),
                          Row(
                            children: [Text("Time period (years)"), Spacer(), Text("${calculationRef.timePeriod} Yr.")],
                          ),
                          Row(
                            children: [
                              Text(
                                "Monthly EMI value",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Text(
                                "${calculationRef.emiAmount} $inr",
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
                ElevatedButton(
                    onPressed: () {
                      if (totalLoanAmountController.text.isNotEmpty && interestRateController.text.isNotEmpty && timePeriodController.text.isNotEmpty) {
                        ref.read(emiProvider.notifier).calculateEMI(loanAmount: totalLoanAmountController.text, rateOfInterest: interestRateController.text, timePeriod: timePeriodController.text);
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
