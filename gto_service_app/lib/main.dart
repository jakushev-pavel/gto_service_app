import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:gtoserviceapp/models/calculator.dart';
import 'package:gtoserviceapp/screens/main/main_screen.dart';
import 'package:gtoserviceapp/services/api/api.dart';
import 'package:gtoserviceapp/services/auth/auth.dart';
import 'package:gtoserviceapp/services/navigation/navigation.dart';
import 'package:gtoserviceapp/services/repo/calculator.dart';
import 'package:gtoserviceapp/services/repo/event.dart';
import 'package:gtoserviceapp/services/repo/local_admin.dart';
import 'package:gtoserviceapp/services/repo/org.dart';
import 'package:gtoserviceapp/services/repo/referee.dart';
import 'package:gtoserviceapp/services/repo/secretary.dart';
import 'package:gtoserviceapp/services/repo/sport_object.dart';
import 'package:gtoserviceapp/services/repo/trial.dart';
import 'package:gtoserviceapp/services/repo/user.dart';
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
  GetIt.I.registerSingleton<OrgRepo>(OrgRepo());
  GetIt.I.registerSingleton<LocalAdminRepo>(LocalAdminRepo());
  GetIt.I.registerSingleton<EventRepo>(EventRepo());
  GetIt.I.registerSingleton<UserRepo>(UserRepo());
  GetIt.I.registerSingleton<SecretaryRepo>(SecretaryRepo());
  GetIt.I.registerSingleton<SportObjectRepo>(SportObjectRepo());
  GetIt.I.registerSingleton<RefereeRepo>(RefereeRepo());
  GetIt.I.registerSingleton<CalculatorRepo>(CalculatorRepo());
  GetIt.I.registerSingleton<TrialRepo>(TrialRepo());

  GetIt.I.registerSingleton<Navigation>(Navigation());

  await Storage.I.init();
}

class GTOServiceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Navigation.I.navigatorKey,
      title: 'GTO Service',
      theme: buildTheme(),
      home: MainScreen(),
    );
  }
}
