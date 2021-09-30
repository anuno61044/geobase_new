import 'package:dartz/dartz.dart';

import 'package:geobase/src/domain/entities/entities.dart';

abstract class ICategoriesRepository {
  Future<Either<Failure, List<CategoryEntity>>> loadAllCategories();

  Future<Either<Failure, CategoryEntity>> getCategory(int categoryId);

  /// According to the current filters.
  Future<Either<Failure, List<CategoryEntity>>> loadCategoriesWhere();

  Future<Either<Failure, CategoryEntity>> addCategory(
      CategoryEntity newCategory);

  Future<Either<Failure, CategoryEntity>> updateCategory(
      CategoryEntity newCategory);

  Future<Either<Failure, Unit>> removeCategory(int categoryId);
}
