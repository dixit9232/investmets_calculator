import 'package:flutter/material.dart';
import 'package:investmets_calculator/view/SWP_calculator.dart';
import 'package:investmets_calculator/view/cagr_calculator_screen.dart';
import 'package:investmets_calculator/view/emi_calculator.dart';
import 'package:investmets_calculator/view/fd_calculator_screen.dart';
import 'package:investmets_calculator/view/goal_planning_lumpsum_calculator_screen.dart';
import 'package:investmets_calculator/view/lumpsum_calculator.dart';
import 'package:investmets_calculator/view/net_worth_screen.dart';
import 'package:investmets_calculator/view/rd_calculator_screen.dart';
import 'package:investmets_calculator/view/retirement_calculator_screen.dart';
import 'package:investmets_calculator/view/saving_calculator_screen.dart';
import 'package:investmets_calculator/view/sip_calculator_screen.dart';
import 'package:investmets_calculator/view/step_up_sip_screen.dart';
import 'package:investmets_calculator/widgets/custom_elevated_button.dart';
import 'package:investmets_calculator/widgets/responsive.dart';

import 'goal_planning_sip_calculator_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    List<String> calcName = [
      'SIP Calculator',
      'SWP Calculator',
      'Lumpsum Calculator',
      'Goal Planning (Lumpsum) Calculator',
      'Goal Planning (SIP) Calculator',
      'EMI Calculator',
      'CAGR Calculator',
      'Saving Calculator',
      'Net Worth Calculator',
      'FD Calculator',
      'RD Calculator',
      'Step-up SIP Calculator',
      'Retirement Calculator',
    ];
    List navigator = [
      SipCalculatorScreen(),
      SWPCalculatorScreen(),
      LumpsumCalculatorScreen(),
      GoalPlanningCalculatorLumpsumScreen(),
      GoalPlanningCalculatorSIPScreen(),
      EMICalculatorScreen(),
      CAGRCalculatorScreen(),
      SavingCalculatorScreen(),
      NetWorthCalculatorScreen(),
      FDCalculatorScreen(),
      RDCalculatorScreen(),
      StepUpSIPCalculatorScreen(),
      RetirementCalculatorScreen(),
    ];

    return Scaffold(
      body: Center(
        child: GridView.builder(
          itemCount: navigator.length,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: Responsive.isDesktop(context)
                  ? 3
                  : Responsive.isTablet(context)
                      ? 2
                      : 1,
              childAspectRatio: 8),
          itemBuilder: (context, index) => Center(
            child: CustomElevatedButton(
                onClick: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => navigator[index],
                      ));
                },
                text: calcName[index]),
          ),
        ),
      ),
    );
  }
}
