import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:gtoserviceapp/models/calculator.dart';
import 'package:gtoserviceapp/screens/main/main_screen.dart';
import 'package:gtoserviceapp/services/api/api.dart';
import 'package:gtoserviceapp/theme/theme.dart';
import 'package:provider/provider.dart';


void setup() {
  GetIt.I.registerSingleton<API>(API());
}

void main() {
  setup();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<CalculatorModel>(create: (_) => CalculatorModel()),
    ],
    child: GTOServiceApp(),
  ));
}

class GTOServiceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GTO Service',
      theme: buildTheme(),
      home: MainScreen(),
    );
  }
}
