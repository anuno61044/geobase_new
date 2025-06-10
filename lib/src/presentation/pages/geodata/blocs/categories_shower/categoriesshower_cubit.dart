import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geobase/injection.dart';
import 'package:geobase/src/domain/entities/entities.dart';
import 'package:geobase/src/domain/services/interfaces/interfaces.dart';

part 'categoriesshower_cubit.freezed.dart';
part 'categoriesshower_state.dart';

@injectable
class CategoriesShowerCubit extends Cubit<CategoriesShowerState> {
  CategoriesShowerCubit(
    this.service,
  ) : super(const CategoriesShowerState.state());

  final ICategoryService service;

  Future<void> loadCategories({bool includeAllOption = true}) async {
    final either = await service.loadCategoriesWhere();
    final categories = either.fold(
        (l) => <CategoryGetEntity>[],
        (r) => [
              ...r,
              if (includeAllOption)
                CategoryGetEntity(
                    id: -1,
                    name: 'Todas',
                    description: null,
                    color: null,
                    icon: '',
                    columns: [])
            ]);
    if (!isClosed) {
      emit(state.copyWith(categories: categories));
    }
  }

  void changeCategory(int? category) {
    if (category == state.selected) return;
    emit(state.copyWith(selected: category));
  }

  void clear() {
    emit(state.copyWith(selected: null));
  }
}
