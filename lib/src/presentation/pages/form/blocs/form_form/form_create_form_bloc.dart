import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:geobase/src/domain/entities/entities.dart';
import 'package:geobase/src/presentation/pages/form/blocs/form_form/form_form_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class FormCreateFormBloc extends FormFormBloc {
  FormCreateFormBloc({
    required super.formService,
    required super.fieldTypeService,
  });

  @override
  Future<void> onSubmitting() async {

    final response = await formService.createForm(
      FieldTypeFormPostEntity(
        name: name.state.value,
        columns: columns.value
            .map(
              (e) => ColumnPostEntity(
                name: e.columnName.value,
                typeId: e.type.value!.id,
              ),
            )
            .toList(),
      ),
    );
    return response.fold(
      (failure) => emitFailure(
        failureResponse: failure.message,
      ),
      (_) => emitSuccess(
        successResponse: unit,
      ),
    );
  }
}
