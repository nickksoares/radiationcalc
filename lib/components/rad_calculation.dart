import 'package:flutter/material.dart';
import 'package:radiationcalc/models/rad_items.dart';

class RadiationCalculation extends StatefulWidget {
  const RadiationCalculation({super.key});

  @override
  State<RadiationCalculation> createState() => _RadiationCalculationState();
}

class _RadiationCalculationState extends State<RadiationCalculation> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _distanceController = TextEditingController();
  final TextEditingController _workingDistanceController =
      TextEditingController();
  final TextEditingController _measurementController = TextEditingController();
  final TextEditingController _transportIndexController =
      TextEditingController();

  RadiationCalculatorItems calculatorItems = RadiationCalculatorItems();

  bool isNumeric(String s) {
    return double.tryParse(s) != null;
  }

  @override
  void dispose() {
    _distanceController.dispose();
    _workingDistanceController.dispose();
    _measurementController.dispose();
    _transportIndexController.dispose();
    super.dispose();
  }

  void calculateAndDisplayResults() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        calculatorItems.distanceFromSource =
            double.tryParse(_distanceController.text);
        calculatorItems.workingDistance =
            double.tryParse(_workingDistanceController.text);
        calculatorItems.readingFromPoint =
            double.tryParse(_measurementController.text);
        calculatorItems.transportIndex =
            double.tryParse(_transportIndexController.text);
        calculatorItems.radiationSource = (calculatorItems.readingFromPoint! *
            (calculatorItems.distanceFromSource! *
                calculatorItems.distanceFromSource!));
        calculatorItems.radiationOnWork = (calculatorItems.radiationSource! /
            (calculatorItems.workingDistance! *
                calculatorItems.workingDistance!));
        calculatorItems.actingForRisk100 =
            (100 / (calculatorItems.radiationOnWork! / 1000)) * 60;
        calculatorItems.actingForRisk250 =
            (250 / (calculatorItems.radiationOnWork! / 1000)) * 60;
        calculatorItems.safeRadiationSource =
            calculatorItems.transportIndex! * 10;
        calculatorItems.safeRadiationOnSite = calculatorItems.radiationSource! /
            (calculatorItems.workingDistance! *
                calculatorItems.workingDistance!);
        calculatorItems.safeForRisk100 =
            (100 / (calculatorItems.safeRadiationOnSite! / 1000));
        calculatorItems.safeForRisk250 =
            (250 / (calculatorItems.safeRadiationOnSite! / 1000));
      });
    }
  }

  void restoreDefaults() {
    setState(() {
      _distanceController.clear();
      _measurementController.clear();
      _workingDistanceController.clear();
      _transportIndexController.clear();
      calculatorItems.workingDistance! * 0;
      calculatorItems.readingFromPoint! * 0;
      calculatorItems.transportIndex! * 0;
      calculatorItems.distanceFromSource! * 0;
      calculatorItems.radiationSource! * 0;
      calculatorItems.radiationOnWork! * 0;
      calculatorItems.actingForRisk100! * 0;
      calculatorItems.actingForRisk250! * 0;
      calculatorItems.safeRadiationSource! * 0;
      calculatorItems.safeRadiationOnSite! * 0;
      calculatorItems.safeForRisk100! * 0;
      calculatorItems.safeForRisk250! * 0;
    });
  }

  ElevatedButton restoreDefaultsBtn() {
    return ElevatedButton(
      onPressed: restoreDefaults,
      child: const Text('Restaurar'),
    );
  }

  ElevatedButton showResultsBtn() {
    return ElevatedButton(
        onPressed: calculateAndDisplayResults, child: const Text('Calcular'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de Exposição à Radiação'),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _distanceController,
                decoration: const InputDecoration(
                    hintText: 'Distância onde foi feita a medição {m}'),
                validator: (value) =>
                    isNumeric(value!) ? null : 'Favor inserir um valor válido',
              ),
              TextFormField(
                controller: _workingDistanceController,
                decoration: const InputDecoration(
                    hintText: 'Distância onde será atuação {m}'),
                validator: (value) =>
                    isNumeric(value!) ? null : 'Favor inserir um valor válido',
              ),
              TextFormField(
                controller: _measurementController,
                decoration: const InputDecoration(hintText: 'Medição {uS/h}'),
                validator: (value) =>
                    isNumeric(value!) ? null : 'Favor inserir um valor válido',
              ),
              TextFormField(
                controller: _transportIndexController,
                decoration:
                    const InputDecoration(hintText: 'Índice de transporte'),
                validator: (value) =>
                    isNumeric(value!) ? null : 'Favor inserir um valor válido',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    showResultsBtn(),
                    restoreDefaultsBtn(),
                  ],
                ),
              ),
              Text(
                  'Radiação no local de atuação {uS/h}: ${calculatorItems.radiationOnWork}'),
              Text(
                  'Radiação a 1m da fonte {uS/h}: ${calculatorItems.radiationSource}'),
              Text(
                  'Tempo de atuação para dose de 100mS {h}: ${calculatorItems.actingForRisk100} H'),
              Text(
                  'Tempo de atuação para dose de 250mS {h}: ${calculatorItems.actingForRisk250} H'),
              const SizedBox(
                child:
                    Text(':::::::Considerando o Índice de Transporte:::::::::'),
              ),
              Text(
                  'Radiação no local de atuação: {uS/h} ${calculatorItems.safeRadiationOnSite}'),
              Text(
                  'Radiação a 1m da fonte {uS/h}: ${calculatorItems.safeRadiationSource}'),
              Text(
                  'Tempo de atuação para dose de 100mS {h}: ${calculatorItems.safeForRisk100} H'),
              Text(
                  'Tempo de atuação para dose de 250mS {h}: ${calculatorItems.safeForRisk100} H'),
            ],
          ),
        ),
      ),
    );
  }
}
