import 'package:flutter/material.dart';
import 'package:radiationcalc/screens/calc_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main(List<String> args) {
  runApp(const RadiationCalculator());
}

class RadiationCalculator extends StatelessWidget {
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
          surface: Colors.blueGrey[50],
        ),
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      home: const CalculatorScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
