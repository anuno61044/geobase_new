import 'package:dartz/dartz.dart';

import 'package:geobase/src/domain/entities/entities.dart';

abstract class IFieldTypeFormRepository {
  Future<Either<Failure, List<FieldTypeFormGetEntity>>> loadForms();

  Future<Either<Failure, FieldTypeFormGetEntity>> getFromFieldType(
    int fieldTypeId,
  );

  Future<Either<Failure, int>> addFieldTypeForm(
    FieldTypeFormPostEntity newForm,
  );

  Future<Either<Failure, Unit>> removeForm(int fieldTypeId);
}
