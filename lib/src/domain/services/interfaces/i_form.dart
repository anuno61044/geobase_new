import 'package:dartz/dartz.dart';
import 'package:geobase/src/domain/entities/entities.dart';

abstract class IFieldTypeFormService {
  Future<Either<Failure, FieldTypeFormGetEntity>> loadById(
    int fieldTypeId,
  );

  Future<Either<Failure, List<FieldTypeFormGetEntity>>> loadAll();

  Future<Either<Failure, int>> createForm(
    FieldTypeFormPostEntity form,
  );

  Future<Either<Failure, Unit>> removeForm(int fieldTypeId);
}
