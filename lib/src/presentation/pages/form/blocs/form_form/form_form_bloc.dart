import 'dart:developer';
import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:geobase/src/domain/services/services.dart';
import 'package:geobase/src/presentation/core/utils/utils.dart';
import 'package:geobase/src/presentation/pages/form/blocs/column/column_field_bloc.dart';

abstract class FormFormBloc extends FormBloc<Unit, String> {
  FormFormBloc({
    required this.formService,
    required this.fieldTypeService,
  }) {
    addFieldBlocs(
      fieldBlocs: [
        name,
        columns,
      ],
    );
  }

  // fields
  final IFieldTypeFormService formService;

  final IFieldTypeService fieldTypeService;

  // fieldBlocs
  late final name = TextFieldBloc(
    asyncValidatorDebounceTime: const Duration(seconds: 1),
    asyncValidators: [_nameIsTaken],
    validators: [
      StringValidator.required,
    ],
  );

  final ListFieldBloc<ColumnFieldBloc, dynamic> columns = ListFieldBloc();

  // validators

  Future<String?> _nameIsTaken(String? value) async {
    final either = await fieldTypeService.loadAll();
    return either.fold(
      (failure) {
        emitFailure(failureResponse: failure.message);
        return null;
      },
      (types) {
        return types.any((e) => e.name == value) ? 'The name is taken.' : null;
      },
    );
  }

  String? columnNameTakenValidator(String? name) {
    // if (name?.isEmpty ?? true) return null;
    return columns.state.fieldBlocs.any((e) => e.columnName.state.value == name)
        ? 'No puede haber columnas con igual nombre.'
        : null;
  }

  //actions
  Future<void> addNewColumn() async {
    final either = await fieldTypeService.loadAll();
    either.fold(
      (failure) {
        log(failure.toString());
        emitFailure(failureResponse: failure.toString());
      },
      (types) {
        columns.addFieldBloc(
          ColumnFieldBloc(
            columnName: TextFieldBloc(
              validators: [
                StringValidator.required,
                columnNameTakenValidator,
              ],
            ),
            type: SelectFieldBloc(
              items: types,
              validators: [
                DynamicValidator.required,
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> removeColumn(int index) async {
    columns.removeFieldBlocAt(index);
  }
}
