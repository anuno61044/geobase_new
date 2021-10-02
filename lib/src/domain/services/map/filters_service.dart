import 'package:dartz/dartz.dart';

import 'package:geobase/injection.dart';
import 'package:geobase/src/domain/entities/entities.dart';
import 'package:geobase/src/domain/repositories/repositories.dart';
import 'package:geobase/src/domain/services/services.dart';

@LazySingleton(as: IMapFiltersOptionsService)
class MapFiltersService implements IMapFiltersOptionsService {
  MapFiltersService(
    this.filterRepository,
  );

  final IMapFilterRepository filterRepository;

  @override
  Future<Either<Failure, FilterDataOptions>> loadFilterOptions() async {
    // return Right(FilterDataOptions.clean());
    return filterRepository.loadDefaultFilterOptions();
  }

  @override
  Future<Either<Failure, Unit>> setFilterOptions(
    FilterDataOptions filters,
  ) async {
    return filterRepository.setDefaultFilterOptions(filters);
  }
}
