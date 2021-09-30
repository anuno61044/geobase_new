import 'package:dartz/dartz.dart';

import 'package:geobase/src/domain/entities/entities.dart';

abstract class IGeoDataRepository {
  /// Loads all geodata from source without distinctions.
  Future<Either<Failure, List<GeoDataEntity>>> loadAllGeodata();

  Future<Either<Failure, GeoDataEntity>> loadGeodataById(int geoDataId);

  /// According to the current filters.
  Future<Either<Failure, List<GeoDataEntity>>> loadGeodataWhere();

  Future<Either<Failure, GeoDataEntity>> addGeodata(GeoDataEntity geoData);

  Future<Either<Failure, GeoDataEntity>> updateGeodata(GeoDataEntity geoData);

  Future<Either<Failure, Unit>> removeGeodata(int geoDataId);
}
