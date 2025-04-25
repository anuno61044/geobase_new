import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geobase/injection.dart';
import 'package:geobase/src/domain/entities/entities.dart';
import 'package:geobase/src/domain/services/interfaces/interfaces.dart';
import 'dart:developer';

part 'form_list_cubit.freezed.dart';
part 'form_list_state.dart';

@injectable
class FormListCubit extends Cubit<FormListState> {
  FormListCubit(this.service) : super(const FormListState.initial());

  final IFieldTypeFormService service;

  Future<void> fetch() async {
    emit(const FormListState.fetchInProgress());
    final response = await service.loadAll();
    log('$response');

    response.fold(
      (error) => emit(
        FormListState.fetchFailure(
          error: error.message ?? error.toString(),
        ),
      ),
      (forms) => emit(
        forms.isEmpty
            ? const FormListState.fetchSuccessNotFound()
            : FormListState.fetchSuccess(forms: forms),
      ),
    );
  }
}
