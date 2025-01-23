import 'package:flutter/material.dart';
import 'package:investmets_calculator/global_variable.dart';
import 'package:investmets_calculator/widgets/responsive.dart';
import 'package:simple_animated_button/simple_animated_button.dart';

class CustomElevatedButton extends StatelessWidget {
  final Function() onClick;
  final String text;

  const CustomElevatedButton({super.key, required this.onClick, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedLayerButton(
        buttonHeight: 50,
        buttonWidth: Responsive.isDesktop(context)
            ? width(context) * 0.3
            : Responsive.isTablet(context)
                ? width(context) * 0.4
                : width(context) * 0.9,
        animationDuration: Duration(milliseconds: 100),
        animationCurve: Curves.bounceInOut,
        topDecoration: BoxDecoration(color: Color(0xffe6eef8), border: Border.all(color: Color(0xff2963a0), width: 1)),
        baseDecoration: BoxDecoration(color: Color(0xff20446c)),
        onClick: onClick,
        topLayerChild: Text(
          text,
          style: TextTheme.of(context).bodyMedium?.copyWith(color: Color(0xff224f82)),
        ));
  }
}
