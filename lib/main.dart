import 'package:flutter/material.dart';
import 'package:radiationcalc/screens/calc_screen.dart';

void main(List<String> args) {
  runApp(const RadiationCalculator());
}

class RadiationCalculator extends StatelessWidget{
  const RadiationCalculator({super.key});
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();

    return MaterialApp(
      title: 'Radiation Calculator',
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: Colors.amber,
          secondary: Colors.red,
          background: Colors.blueGrey[50]
        ),
        textTheme: theme.textTheme.copyWith(
          titleSmall: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            
          ),
          displayMedium: TextStyle(
            color: Colors.red,
            backgroundColor: Colors.orange[100]
          )
        )
      ),
      home: const CalculatorScreen(),
      debugShowCheckedModeBanner: false,
    );
  }

}