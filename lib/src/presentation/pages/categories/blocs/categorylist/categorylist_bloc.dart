import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geobase/injection.dart';
import 'package:geobase/src/domain/entities/entities.dart';
import 'package:geobase/src/domain/services/services.dart';
import 'package:rxdart/rxdart.dart';

part 'categorylist_bloc.freezed.dart';
part 'categorylist_event.dart';
part 'categorylist_state.dart';

@injectable
class CategoryListBloc extends Bloc<CategoryListEvent, CategoryListState> {
  CategoryListBloc(this.categoryService)
      : super(const CategoryListState.initial()) {
    on<_Fetched>(
      (event, emit) async {
        if (isClosed) return;
        emit(const CategoryListState.fetchInProgress());

        final response = await categoryService.loadCategoriesWhere(
          FilterCategoriesOptionsEntity(nameSubstring: event.query),
        );

        if (isClosed) return;

        await response.fold(
          (error) async => emit(
            CategoryListState.fetchFailure(
              error: error.message ?? error.toString(),
            ),
          ),
          (categories) async => emit(
            categories.isEmpty
                ? const CategoryListState.fetchSuccessNotFound()
                : CategoryListState.fetchSuccess(categories: categories),
          ),
        );
      },
      transformer: (events, mapper) {
        return events
            .debounceTime(const Duration(milliseconds: 300))
            .where((_) => !isClosed)
            .asyncExpand(mapper);
      },
    );
  }

  final ICategoryService categoryService;
}
