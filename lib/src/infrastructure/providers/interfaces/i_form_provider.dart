import 'package:geobase/src/infrastructure/models/models.dart';

abstract class IFieldTypeFormProvider {
  Future<List<FieldTypeFormGetModel>> getAll();
  Future<FieldTypeFormGetModel> getByFieldTypeId(int id);
  Future<int> create(FieldTypeFormPostModel model);
  Future<void> remove(int id);
}
