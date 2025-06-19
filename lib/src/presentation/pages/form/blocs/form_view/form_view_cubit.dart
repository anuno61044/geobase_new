import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geobase/injection.dart';
import 'package:geobase/src/domain/entities/entities.dart';
import 'package:geobase/src/domain/services/services.dart';

part 'form_view_cubit.freezed.dart';
part 'form_view_state.dart';

@injectable
class FormViewCubit extends Cubit<FormViewState> {
  FormViewCubit(
    this.formService,
  ) : super(const FormViewState.fetchInProgress());

  final IFieldTypeFormService formService;

  Future<void> fetch(int formId) async {
    emit(const FormViewState.fetchInProgress());
    final result = await formService.loadById(formId);
    emit(
      result.fold(
        (error) => FormViewState.fetchFailure(error: error.toString()),
        (form) => FormViewState.fetchSuccess(form: form),
      ),
    );
  }

  Future<bool> remove(int fieldTypeId) async {
    try {
      await formService.removeForm(fieldTypeId);
      return true;
    } catch (e) {
      log('$e');
      return false;
    }
  }
}
