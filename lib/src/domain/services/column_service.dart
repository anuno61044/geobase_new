import 'package:dartz/dartz.dart';
import 'package:geobase/injection.dart';
import 'package:geobase/src/domain/entities/entities.dart';
import 'package:geobase/src/domain/repositories/repositories.dart';
import 'package:geobase/src/domain/services/interfaces/interfaces.dart';

@LazySingleton(as: IColumnService)
class ColumnsService implements IColumnService {
  ColumnsService(
    this.columnsRepository,
    this.geodataRepository,
  );

  final IColumnRepository columnsRepository;
  final IGeodataRepository geodataRepository;

  @override
  Future<Either<Failure, List<ColumnGetEntity>>> loadColumnsFromCategory(
    int categoryId,
  ) async {
    return columnsRepository.loadColumnsFromCategory(categoryId);
  }

  @override
  Future<Either<Failure, ColumnGetEntity>> getColumn(int columnId) async {
    return columnsRepository.getColumn(columnId);
  }

  @override
  Future<Either<Failure, int>> createColumn(
    ColumnPostEntity newColumn,
  ) async {
    return columnsRepository.addColumn(newColumn);
  }

  @override
  Future<Either<Failure, Unit>> removeColumn(int columnId) async {
    return columnsRepository.removeColumn(columnId);
  }

  @override
  Future<Either<Failure, int>> editColumn(
    ColumnPutEntity editedColumn,
  ) async {
    return columnsRepository.editColumn(editedColumn);
  }

}