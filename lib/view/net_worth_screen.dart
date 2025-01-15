import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:investmets_calculator/widgets/custom-textfied.dart';

import '../global_variable.dart';
import '../providers/net-worth-provider.dart';

class NetWorthCalculatorScreen extends ConsumerStatefulWidget {
  const NetWorthCalculatorScreen({super.key});

  @override
  ConsumerState<NetWorthCalculatorScreen> createState() => _NetWorthCalculatorScreenState();
}

class _NetWorthCalculatorScreenState extends ConsumerState<NetWorthCalculatorScreen> {
  final TextEditingController totalAssetsController = TextEditingController(text: " 1600000");
  final TextEditingController totalLiabilitiesController = TextEditingController(text: " 1350000");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() => ref.read(netWorthProvider.notifier).calculateNetWorth(totalAssets: totalAssetsController.text, totalLiabilities: totalLiabilitiesController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Net Worth Calculator"),
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
                  labelText: "Total Assets",
                  textEditingController: totalAssetsController,
                  suffixIcon: Text(
                    inr,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                CustomTextField(
                  labelText: "Total Liabilities",
                  textEditingController: totalLiabilitiesController,
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
                      final calculationRef = ref.watch(netWorthProvider);
                      return Column(
                        spacing: 20,
                        children: [
                          Row(
                            children: [Text("Total Assets"), Spacer(), Text("${calculationRef.totalAssets} $inr")],
                          ),
                          Row(
                            children: [Text("Total Liabilities"), Spacer(), Text("${calculationRef.totalLiabilities} $inr")],
                          ),
                          Row(
                            children: [
                              Text(
                                "Net Worth",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Text(
                                "${calculationRef.netWorth} $inr",
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
                      if (totalAssetsController.text.isNotEmpty && totalLiabilitiesController.text.isNotEmpty) {
                        ref.read(netWorthProvider.notifier).calculateNetWorth(totalAssets: totalAssetsController.text, totalLiabilities: totalLiabilitiesController.text);
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
