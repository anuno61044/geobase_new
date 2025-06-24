import 'package:flutter/services.dart';
import 'package:geobase/injection.dart';
import 'package:geobase/main.reflectable.dart';
import 'package:geobase/src/infrastructure/core/extensions/sqlite_db_extension.dart';
import 'package:geobase/src/infrastructure/providers/sqlite/db_model.dart';
import 'package:geobase/src/presentation/core/app.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  await initializeApp();

  // Limpiar preferencias al iniciar
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();

  runApp(GeoBaseApp());
}

Future initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  configureInjection(Environment.prod);

  await GeobaseModel().initialize();

  initializeReflectable();

  // Bloc.observer = getIt<BlocObserver>();
}
