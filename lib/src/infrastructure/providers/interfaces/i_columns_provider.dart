import 'package:geobase/src/infrastructure/models/models.dart';

abstract class IColumnsProvider {
  Future<List<ColumnGetModel>> getAllFromCategory(int categoryId);
  Future<List<ColumnGetModel>> getAllFromForm(int formId);
  Future<ColumnGetModel> getById(int id);
  Future<int> create(ColumnPostModel model);
  Future<int> edit(ColumnPutModel model);
  Future<void> remove(int id);
}
