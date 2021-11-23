import 'package:dartz/dartz.dart';
import 'package:geobase/src/domain/entities/entities.dart';
import 'package:geobase/src/domain/repositories/repositories.dart';
import 'package:geobase/src/infrastructure/core/changes_notifier_streamcontroller.dart';
import 'package:geobase/src/infrastructure/core/error_handling.dart';
import 'package:geobase/src/infrastructure/core/extensions/extensions.dart';
import 'package:geobase/src/infrastructure/providers/interfaces/i_local_preferences_provider.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IConfigurationRepository)
class ConfigurationRepository implements IConfigurationRepository {
  ConfigurationRepository(
    this.provider,
  ) {
    _changesUserPreferencesNotifier =
        ObjectChangeNotifier<UserPreferencesEntity>();
  }

  late final ObjectChangeNotifier<UserPreferencesEntity>
      _changesUserPreferencesNotifier;

  final ILocalPreferencesProvider provider;

  @override
  Stream<UserPreferencesEntity> get onUserPrefChanged =>
      _changesUserPreferencesNotifier.stream;

  @override
  Future<Either<Failure, MapConfigurationEntity>>
      loadMapConfigurations() async {
    try {
      final response = await provider.loadMapConfig();
      return Right(response.toEntity());
    } catch (e) {
      return catchMethod(e);
    }
  }

  @override
  Future<Either<Failure, Unit>> setMapConfigurations(
    MapConfigurationEntity configuration,
  ) async {
    try {
      await provider.saveMapConfig(configuration.toModel());
      return const Right(unit);
    } catch (e) {
      return catchMethod(e);
    }
  }

  @override
  Future<Either<Failure, UserPreferencesEntity>> loadUserPreferences() async {
    try {
      final result = await provider.loadUserPrefs();
      return Right(result.toEntity());
    } catch (e) {
      return catchMethod(e);
    }
  }

  @override
  Future<Either<Failure, Unit>> editUserPreferences(
    UserPreferencesEntity preferences,
  ) async {
    try {
      await provider.saveUserPrefs(preferences.toModel());
      _changesUserPreferencesNotifier.add(
        UserPreferencesEntity(
          showLocation: preferences.showLocation,
        ),
      );
      return const Right(unit);
    } catch (e) {
      return catchMethod(e);
    }
  }
}
