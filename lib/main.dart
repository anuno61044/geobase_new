import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:geobase/injection.dart';
import 'package:geobase/src/infrastructure/core/extensions/sqlite_db_extension.dart';
import 'package:geobase/src/infrastructure/providers/sqlite/db_model.dart';
import 'package:geobase/src/presentation/core/app.dart';

Future main() async {
  await initializeApp();

  runApp(GeoBaseApp());
}

Future initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  configureInjection(Environment.prod);

  await getIt<GeobaseModel>().initialize();

  //TODO: initialize reflectable here
  Bloc.observer = getIt<BlocObserver>();
}
