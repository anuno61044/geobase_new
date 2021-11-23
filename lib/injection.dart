import 'package:geobase/injection.config.dart';
import 'package:geobase/src/infrastructure/providers/sqlite/db_model.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

export 'package:get_it/get_it.dart';
export 'package:injectable/injectable.dart';

final GetIt getIt = GetIt.instance;

@injectableInit
void configureInjection(String env) {
  $initGetIt(getIt, environment: env);
  getIt<SharedPreferences>();
}
