import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lyform/flutter_lyform.dart';
import 'package:geobase/injection.dart';
import 'package:geobase/src/domain/entities/entities.dart';
import 'package:geobase/src/presentation/core/app.dart';
import 'package:geobase/src/presentation/core/widgets/commons/dropdown_field.dart';
import 'package:geobase/src/presentation/core/widgets/field_input_widgets/field_input_widget.dart';
import 'package:geobase/src/presentation/core/widgets/render_classes/reflect.dart';

class FormFieldInputWidget extends FieldInputWidget {
  const FormFieldInputWidget({
    super.key,
    required super.column,
    required super.inputBloc,
  });

  @override
  Widget build(BuildContext context) {
    Map<ColumnGetEntity, LyInput<FieldValueEntity>> columnInputsMap = {};
    // Check if the column has form columns directly
    if (column.type.extradata?['columns'] != null) {
      final List<ColumnGetEntity> columns = (column.type.extradata?['columns']
              as List)
          .map((col) => ColumnGetEntity.fromMap(col as Map<String, dynamic>))
          .toList();

      final FieldValueEntity fieldValue = inputBloc.value;

      if (fieldValue is FieldValuePostEntity) {
        columnInputsMap = Map.fromEntries(
          columns.map(
            (e) => MapEntry(
              e,
              FieldRenderResolver.getInputBloc(
                    e,
                    FieldValuePostEntity(
                        value: null, columnId: e.id),
                  ) ??
                  LyInput<FieldValueEntity>(
                    pureValue: FieldValuePostEntity(
                      columnId: e.id,
                      value: null,
                    ),
                  ),
            ),
          ),
        );
      } else if (fieldValue is FieldValuePutEntity) {
        Map<int, FieldValueGetEntity> inputValues = {};
        if(fieldValue.value is String) {
          inputValues = deserializeFieldValues(fieldValue.value as String);
        }
        else {
          inputValues = fieldValue.value as Map<int, FieldValueGetEntity>;
        }

        columnInputsMap = Map.fromEntries(
          columns.map(
            (e) => MapEntry(
              e,
              FieldRenderResolver.getInputBloc(
                    e,
                    FieldValuePutEntity(
                        geodataId: inputValues[e.id]!.geodataId,
                        id: inputValues[e.id]!.id,
                        value: inputValues[e.id]!.value,
                        columnId: e.id),
                  ) ??
                  LyInput<FieldValueEntity>(
                    pureValue: FieldValuePutEntity(
                        geodataId: inputValues[e.id]!.geodataId,
                        id: inputValues[e.id]!.id,
                        value: inputValues[e.id]!.value,
                        columnId: e.id),
                  ),
            ),
          ),
        );
      }

      return _FormFieldsExpansion(
        columnInputsMap: columnInputsMap,
        inputBloc: inputBloc,
        column: column,
      );
    } else {
      // Fallback to dropdown if no form columns are available
      return _buildDropdown([], context);
    }
  }

  Widget _buildDropdown(List<String> items, BuildContext context) {
    return LyInputBuilder<FieldValueEntity>(
      lyInput: inputBloc,
      builder: (context, state) {
        final value = state.value.value as String?;
        if (value != null && !items.contains(value)) {
          items.add(value);
        }
        return DropdownButtonFormFieldWidget<String>(
          key: key,
          items: items
              .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
              .toList(),
          value: state.value.value as String?,
          errorText: state.error,
          labelText: column.name,
          onChanged: (newValue) => inputBloc.dirty(
            state.value.copyWithValue(newValue),
          ),
        );
      },
    );
  }
}

class _FormFieldsExpansion extends StatefulWidget {
  const _FormFieldsExpansion({
    required this.inputBloc,
    required this.column,
    required this.columnInputsMap,
  });

  final LyInput<FieldValueEntity> inputBloc;
  final ColumnGetEntity column;
  final Map<ColumnGetEntity, LyInput<FieldValueEntity>> columnInputsMap;

  @override
  State<_FormFieldsExpansion> createState() => _FormFieldsExpansionState();
}

class _FormFieldsExpansionState extends State<_FormFieldsExpansion> {
  late final Map<ColumnGetEntity, LyInput<FieldValueEntity>> columnInputsMap;
  Map<int, FieldValueGetEntity> formValues = {};

  @override
  void initState() {
    super.initState();
    columnInputsMap = widget.columnInputsMap; // conserva las instancias
    formValues = columnInputsMap.map((key, value) => MapEntry(key.id, FieldValueGetEntity(column: key, value: columnInputsMap[key]!.value.value, id: 1, geodataId: 1)));
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(widget.column.name),
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: columnInputsMap.entries.map((entry) {
              final column = entry.key;
              final input = entry.value;

              if(widget.inputBloc.value is FieldValuePutEntity) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: FieldRenderResolver.getInputWidget(
                    column,
                    input,
                    onChanged: (value) => setState(() {
                      formValues[column.id] = FieldValueGetEntity(
                        value: value,
                        column: column,
                        geodataId: 1,
                        id: 1,
                      );
                      widget.inputBloc.dirty(
                        FieldValuePutEntity(
                          value: formValues,
                          columnId: widget.column.id,
                          id: (widget.inputBloc.value as FieldValuePutEntity).id,
                          geodataId: (widget.inputBloc.value as FieldValuePutEntity).geodataId,
                        ),
                      );
                    }),
                  ),
                );
              }
              else {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: FieldRenderResolver.getInputWidget(
                    column,
                    input,
                    onChanged: (value) => setState(() {
                      formValues[column.id] = FieldValueGetEntity(
                        value: value,
                        column: column,
                        geodataId: 1,
                        id: 1,
                      );
                      widget.inputBloc.dirty(
                        FieldValuePostEntity(
                          value: formValues,
                          columnId: widget.column.id,
                        ),
                      );
                    }),
                  ),
                );
              }
              
            }).toList(),
          ),
        ),
      ],
    );
  }
}

Map<int, FieldValueGetEntity> deserializeFieldValues(String jsonValue) {
  try {
    // Paso 1: Decodificar el String JSON a un Map
    final Map<String, dynamic> valueMap =
        json.decode(jsonValue) as Map<String, dynamic>;

    // Paso 2: Mapear cada entrada a un Map<int, FieldValueGetEntity>
    final Map<int, FieldValueGetEntity> result = {};

    valueMap.forEach((key, value) {
      final columnData = value as Map<String, dynamic>;
      final column =
          ColumnGetEntity.fromMap(columnData['column'] as Map<String, dynamic>);

      // Crear el objeto FieldValueGetEntity completo
      final fieldValue = FieldValueGetEntity(
        value: columnData['value'],
        id: columnData['id'] as int,
        geodataId: columnData['geodataId'] as int,
        column: column,
      );

      // Usar column.id como clave (o columnData['id'] si prefieres)
      result[column.id] = fieldValue;
    });

    return result;
  } catch (e) {
    log('Error deserializando FieldValueGetEntity: $e');
    return {}; // Retorna un mapa vacío en caso de error
  }
}
