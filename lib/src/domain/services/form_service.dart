import 'package:dartz/dartz.dart';
import 'package:geobase/injection.dart';
import 'package:geobase/src/domain/entities/entities.dart';
import 'package:geobase/src/domain/repositories/i_form_repository.dart';
import 'package:geobase/src/domain/services/interfaces/interfaces.dart';

@Injectable(as: IFieldTypeFormService)
class FieldTypeFormService implements IFieldTypeFormService {
  const FieldTypeFormService({
    required this.repository,
  });

  final IFieldTypeFormRepository repository;

  @override
  Future<Either<Failure, int>> createForm(FieldTypeFormPostEntity form) async {
    return repository.addFieldTypeForm(form);
  }

  @override
  Future<Either<Failure, FieldTypeFormGetEntity>> loadById(int fieldTypeId) async {
    return repository.getFromFieldType(fieldTypeId);
  }

  @override
  Future<Either<Failure, Unit>> removeForm(int fieldTypeId) async {
    return repository.removeForm(fieldTypeId);
  }

  @override
  Future<Either<Failure, List<FieldTypeFormGetEntity>>> loadAll() {
    return repository.loadForms();
  }
}
