import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lyform/flutter_lyform.dart';
import 'package:geobase/src/domain/entities/entities.dart';
import 'package:geobase/src/presentation/core/widgets/blocs/dynamic_form_cubit/dynamic_form_cubit.dart';
import 'package:geobase/src/presentation/core/widgets/commons/dropdown_field.dart';
import 'package:geobase/src/presentation/core/widgets/field_input_widgets/field_input_widget.dart';
import 'package:geobase/src/presentation/core/widgets/render_classes/reflect.dart';

class FormFieldInputWidget extends FieldInputWidget {
  const FormFieldInputWidget({
    super.key,
    required super.column,
    required super.inputBloc,
    this.onChangedToParent,
  });

  final void Function(Object?)? onChangedToParent;

  @override
  Widget build(BuildContext context) {
    final FieldValueEntity fieldValue = inputBloc.value;

    final bool isEditMode = fieldValue is! FieldValuePostEntity;

    List<Map<int, FieldValueGetEntity>>? initialValues;

    if (isEditMode) {
      try {
        final rawList = fieldValue.value as List;
        initialValues = rawList.map<Map<int, FieldValueGetEntity>>((item) {
          final map = jsonDecode(item as String) as Map<String, dynamic>;
          return map.map<int, FieldValueGetEntity>((key, value) {
            return MapEntry(
              int.parse(key),
              FieldValueGetEntity.fromMap(value as Map<String, dynamic>),
            );
          });
        }).toList();
      } catch (e, st) {
        log('Error al deserializar subformularios: $e\n$st');
      }
    }

    return BlocProvider(
      create: (_) => DynamicFormCubit(
        column: column,
        isEditMode: isEditMode,
        initialValues: initialValues,
      ),
      child: BlocBuilder<DynamicFormCubit, DynamicFormState>(
        builder: (context, state) {
          final cubit = context.read<DynamicFormCubit>();

          // Serializar el valor para guardar en el inputBloc
          final serializedValue = cubit.toSerializedList();

          final updatedValue = isEditMode
              ? FieldValuePutEntity(
                  id: (inputBloc.value as FieldValuePutEntity).id,
                  geodataId: (inputBloc.value as FieldValuePutEntity).geodataId,
                  columnId: column.id,
                  value: serializedValue,
                )
              : FieldValuePostEntity(
                  columnId: column.id,
                  value: serializedValue,
                );

          inputBloc.dirty(updatedValue);
          onChangedToParent?.call(serializedValue);

          return ExpansionTile(
            key: key,
            title: Text(column.name),
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    for (int i = 0; i < state.forms.length; i++)
                      _buildFormCard(context, state.forms[i], i),

                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: cubit.addForm,
                      icon: const Icon(Icons.add),
                      label: Text('Agregar ${column.type.name}'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFormCard(BuildContext context,
      Map<ColumnGetEntity, LyInput<FieldValueEntity>> form, int index) {
    final cubit = context.read<DynamicFormCubit>();

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            for (final entry in form.entries)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: FieldRenderResolver.getInputWidget(
                  entry.key,
                  entry.value,
                  onChanged: (val) {
                    entry.value.dirty(entry.value.value.copyWithValue(val));
                  },
                ),
              ),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => cubit.removeForm(index),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

