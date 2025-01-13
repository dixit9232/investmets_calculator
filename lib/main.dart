import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:investmets_calculator/view/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            useMaterial3: true,
            primaryColor: Colors.purple,
            elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.purpleAccent), padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 20, horizontal: 50)))),
            textTheme: TextTheme(bodyLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.normal), bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.normal), labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
        home: HomeScreen(),
      ),
    );
  }
}
