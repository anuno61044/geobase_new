import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geobase/src/domain/entities/entities.dart';
import 'package:geobase/src/domain/repositories/repositories.dart';
import 'package:geobase/injection.dart';

part 'form_selector_cubit.freezed.dart';
part 'form_selector_state.dart';

@injectable
class FormSelectorCubit extends Cubit<FormSelectorState> {
  FormSelectorCubit(this._formRepository)
      : super(const FormSelectorState.initial());

  final IFieldTypeFormRepository _formRepository;

  Future<void> loadFormForColumn(ColumnGetEntity column) async {
    try {
      emit(const FormSelectorState.loading());

      // Aquí asumo que el extradata de la columna contiene el form_id
      final formId = column.type.id;
      if (formId == null) {
        emit(const FormSelectorState.empty());
        return;
      }

      final Either<Failure, FieldTypeFormGetEntity> result =
          await _formRepository.getFromFieldType(formId);

      result.fold(
        (failure) => emit(FormSelectorState.error(failure.toString())),
        (form) => emit(FormSelectorState.loaded(form)),
      );
    } catch (e) {
      emit(FormSelectorState.error(e.toString()));
    }
  }
}
