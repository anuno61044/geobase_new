import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lyform/flutter_lyform.dart';
import 'package:geobase/src/domain/entities/entities.dart';
import 'package:geobase/src/presentation/core/widgets/render_classes/reflect.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dynamic_form_state.dart';
part 'dynamic_form_cubit.freezed.dart';

class DynamicFormCubit extends Cubit<DynamicFormState> {
  DynamicFormCubit({
    required this.column,
    this.initialValues,
    required this.isEditMode,
  }) : super(const DynamicFormState(forms: [])) {
    _initializeForms();
  }

  final ColumnGetEntity column;
  final bool isEditMode;
  final List<Map<int, FieldValueGetEntity>>? initialValues;

  List<ColumnGetEntity> get subColumns {
    // Verificar si extradata tiene columnas
    if (column.type.extradata?['columns'] != null) {
      return (column.type.extradata!['columns'] as List)
          .map((e) => ColumnGetEntity.fromMap(e as Map<String, dynamic>))
          .toList();
    }

    // Si no, verificar si column.type tiene la propiedad columns
    if (column.type is FieldTypeFormGetEntity) {
      return (column.type as FieldTypeFormGetEntity).columns;
    }

    // Si no hay ninguna, retornar lista vacía
    return [];
  }

  void _initializeForms() {
    if (initialValues != null && initialValues!.isNotEmpty) {
      final forms = <Map<ColumnGetEntity, LyInput<FieldValueEntity>>>[];

      for (final valueMap in initialValues!) {
        final form = <ColumnGetEntity, LyInput<FieldValueEntity>>{};

        for (final subColumn in subColumns) {
          final value = valueMap[subColumn.id];

          final input = FieldRenderResolver.getInputBloc(
            subColumn,
            value != null
                ? FieldValuePutEntity(
                    columnId: subColumn.id,
                    geodataId: value.geodataId,
                    id: value.id,
                    value: value.value,
                  )
                : FieldValuePostEntity(
                    columnId: subColumn.id,
                    value: null,
                  ),
          );

          if (input != null) {
            form[subColumn] = input;
          }
        }

        forms.add(form);
      }

      emit(DynamicFormState(forms: forms));
    } else {
      addForm();
    }
  }

  void addForm() {
    final newForm = <ColumnGetEntity, LyInput<FieldValueEntity>>{};

    for (final col in subColumns) {
      final input = FieldRenderResolver.getInputBloc(
        col,
        FieldValuePostEntity(columnId: col.id, value: null),
      );

      if (input != null) {
        newForm[col] = input;
      }
    }

    emit(DynamicFormState(forms: [...state.forms, newForm]));
  }

  void removeForm(int index) {
    final newForms =
        List<Map<ColumnGetEntity, LyInput<FieldValueEntity>>>.from(state.forms);
    newForms.removeAt(index);
    emit(state.copyWith(forms: newForms));

    // Forzar reconstrucción de todos los widgets
    emit(state.copyWith());
  }

  List<String> toSerializedList() {
    return state.forms.map((form) {
      final Map<String, dynamic> mapToSerialize = form.map(
        (col, input) {
          final val = FieldValueGetEntity(
            column: col,
            geodataId: 1, // Puedes ajustar estos valores según tu lógica real
            id: 1,
            value: input.value.value,
          );
          return MapEntry(col.id.toString(), val.toMap());
        },
      );
      return jsonEncode(mapToSerialize);
    }).toList();
  }

  void onFieldChanged() {
    emit(DynamicFormState(forms: [...state.forms]));
  }
}
