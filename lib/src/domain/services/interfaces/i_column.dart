import 'package:dartz/dartz.dart';

import 'package:geobase/src/domain/entities/entities.dart';

abstract class IColumnService {
  Future<Either<Failure, List<ColumnGetEntity>>> loadColumnsFromCategory(
    int categoryId,
  );

  Future<Either<Failure, ColumnGetEntity>> getColumn(int columnId);

  Future<Either<Failure, int>> createColumn(
    ColumnPostEntity newColumn,
  );

  Future<Either<Failure, int>> editColumn(
    ColumnPutEntity editedColumn,
  );

  Future<Either<Failure, Unit>> removeColumn(int columnId);
}