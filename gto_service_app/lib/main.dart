import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:gtoserviceapp/models/calculator.dart';
import 'package:gtoserviceapp/screens/main/main_screen.dart';
import 'package:gtoserviceapp/services/api/api.dart';
import 'package:gtoserviceapp/services/auth/auth.dart';
import 'package:gtoserviceapp/services/storage/storage.dart';
import 'package:gtoserviceapp/theme/theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<CalculatorModel>(create: (_) => CalculatorModel()),
    ],
    child: GTOServiceApp(),
  ));
}

setup() async {
  GetIt.I.registerSingleton<API>(API());
  GetIt.I.registerSingleton<Storage>(Storage());
  GetIt.I.registerSingleton<Auth>(Auth());

  await Storage.I.init();
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
