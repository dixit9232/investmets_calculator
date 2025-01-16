import 'package:flutter/material.dart';
import 'package:investmets_calculator/view/SWP_calculator.dart';
import 'package:investmets_calculator/view/cagr_calculator_screen.dart';
import 'package:investmets_calculator/view/emi_calculator.dart';
import 'package:investmets_calculator/view/fd_calculator_screen.dart';
import 'package:investmets_calculator/view/goal_planning_lumpsum_calculator_screen.dart';
import 'package:investmets_calculator/view/lumpsum_calculator.dart';
import 'package:investmets_calculator/view/net_worth_screen.dart';
import 'package:investmets_calculator/view/rd_calculator_screen.dart';
import 'package:investmets_calculator/view/saving_calculator_screen.dart';
import 'package:investmets_calculator/view/sip_calculator_screen.dart';
import 'package:investmets_calculator/view/step_up_sip_screen.dart';

import 'goal_planning_sip_calculator_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SipCalculatorScreen(),
                        ));
                  },
                  child: Text(
                    "SIP Calculator",
                    style: TextTheme.of(context).bodyMedium?.copyWith(color: Colors.white),
                  )),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SWPCalculatorScreen(),
                        ));
                  },
                  child: Text(
                    "SWP Calculator",
                    style: TextTheme.of(context).bodyMedium?.copyWith(color: Colors.white),
                  )),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LumpsumCalculatorScreen(),
                        ));
                  },
                  child: Text(
                    "Lumpsum Calculator",
                    style: TextTheme.of(context).bodyMedium?.copyWith(color: Colors.white),
                  )),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GoalPlanningCalculatorLumpsumScreen(),
                        ));
                  },
                  child: Text(
                    "Goal Planning Calculator (Lumpsum)",
                    style: TextTheme.of(context).bodyMedium?.copyWith(color: Colors.white),
                  )),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GoalPlanningCalculatorSIPScreen(),
                        ));
                  },
                  child: Text(
                    "Goal Planning Calculator (SIP)",
                    style: TextTheme.of(context).bodyMedium?.copyWith(color: Colors.white),
                  )),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EMICalculatorScreen(),
                        ));
                  },
                  child: Text(
                    "Loan Calculator",
                    style: TextTheme.of(context).bodyMedium?.copyWith(color: Colors.white),
                  )),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CAGRCalculatorScreen(),
                        ));
                  },
                  child: Text(
                    "CAGR Calculator",
                    style: TextTheme.of(context).bodyMedium?.copyWith(color: Colors.white),
                  )),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SavingCalculatorScreen(),
                        ));
                  },
                  child: Text(
                    "Saving Calculator",
                    style: TextTheme.of(context).bodyMedium?.copyWith(color: Colors.white),
                  )),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NetWorthCalculatorScreen(),
                        ));
                  },
                  child: Text(
                    "Net Worth Calculator",
                    style: TextTheme.of(context).bodyMedium?.copyWith(color: Colors.white),
                  )),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FDCalculatorScreen(),
                        ));
                  },
                  child: Text(
                    "FD Calculator",
                    style: TextTheme.of(context).bodyMedium?.copyWith(color: Colors.white),
                  )),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RDCalculatorScreen(),
                        ));
                  },
                  child: Text(
                    "RD Calculator",
                    style: TextTheme.of(context).bodyMedium?.copyWith(color: Colors.white),
                  )),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StepUpSIPCalculatorScreen(),
                        ));
                  },
                  child: Text(
                    "Step up SIP Calculator",
                    style: TextTheme.of(context).bodyMedium?.copyWith(color: Colors.white),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
