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
    this.onChangedToParent,
  });

  final void Function(Object?)? onChangedToParent;

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
        return _DynamicFormList(
          column: column,
          inputBloc: inputBloc,
          onChangedToParent: onChangedToParent,
          isEditMode: false,
        );
      }

      List<Map<int, FieldValueGetEntity>> inputList = [];

      final rawList = fieldValue.value as List;
      inputList = rawList.map<Map<int, FieldValueGetEntity>>((item) {
        final map = jsonDecode(item as String) as Map<String, dynamic>;
        return map.map<int, FieldValueGetEntity>((key, value) {
          return MapEntry(
            int.parse(key),
            FieldValueGetEntity.fromMap(value as Map<String, dynamic>),
          );
        });
      }).toList();

      return _DynamicFormList(
        column: column,
        inputBloc: inputBloc,
        onChangedToParent: onChangedToParent,
        initialValues: inputList,
        isEditMode: true,
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

class _DynamicFormList extends StatefulWidget {
  const _DynamicFormList({
    required this.inputBloc,
    required this.column,
    required this.onChangedToParent,
    this.initialValues,
    required this.isEditMode,
  });

  final LyInput<FieldValueEntity> inputBloc;
  final ColumnGetEntity column;
  final void Function(Object?)? onChangedToParent;
  final List<Map<int, FieldValueGetEntity>>? initialValues;
  final bool isEditMode;

  @override
  State<_DynamicFormList> createState() => _DynamicFormListState();
}

class _DynamicFormListState extends State<_DynamicFormList> {
  final List<Map<ColumnGetEntity, LyInput<FieldValueEntity>>> _formList = [];

  List<ColumnGetEntity> get subColumns =>
      (widget.column.type.extradata?['columns'] as List)
          .map((col) => ColumnGetEntity.fromMap(col as Map<String, dynamic>))
          .toList();

  void _addForm() {
    final Map<ColumnGetEntity, LyInput<FieldValueEntity>> newInputs = {
      for (final col in subColumns)
        col: FieldRenderResolver.getInputBloc(
              col,
              FieldValuePostEntity(columnId: col.id, value: null),
            ) ??
            LyInput<FieldValueEntity>(
              pureValue: FieldValuePostEntity(columnId: col.id, value: null),
            )
    };

    setState(() {
      _formList.add(newInputs);
      _updateInputBloc();
    });
  }

  void _removeForm(int index) {
    setState(() {
      _formList.removeAt(index);
      _updateInputBloc();
    });
  }

  void _updateInputBloc() {
  final List<Map<int, FieldValueGetEntity>> value = _formList.map((form) {
    return form.map((col, input) {
      final val = FieldValueGetEntity(
        column: col,
        geodataId: 1,
        id: 1,
        value: input.value.value,
      );
      return MapEntry(col.id, val);
    });
  }).toList();

  FieldValueEntity updated;

  if (widget.isEditMode) {
    FieldValuePutEntity putValue = widget.inputBloc.value as FieldValuePutEntity;
    updated = FieldValuePutEntity(
      id: putValue.id,
      geodataId: putValue.geodataId,
      columnId: widget.column.id,
      value: value.map((e) => jsonEncode(
        e.map((k, v) => MapEntry(
          k.toString(),
          v.toMap(),
        )),
      )).toList(),
    );
  } else {
    updated = FieldValuePostEntity(
      columnId: widget.column.id,
      value: value.map((e) => jsonEncode(
        e.map((k, v) => MapEntry(
          k.toString(),
          v.toMap(),
        )),
      )).toList(),
    );
  }

  widget.inputBloc.dirty(updated);
  widget.onChangedToParent?.call(value);
}


  @override
  void initState() {
    super.initState();

    if (widget.initialValues != null && widget.initialValues!.isNotEmpty) {
      for (final formMap in widget.initialValues!) {
        final mapped = <ColumnGetEntity, LyInput<FieldValueEntity>>{};
        for (final entry in formMap.entries) {
          final colId = entry.key;
          final fieldVal = entry.value;
          final column = subColumns.firstWhere((col) => col.id == colId);

          mapped[column] = FieldRenderResolver.getInputBloc(
                column,
                FieldValuePutEntity(
                  geodataId: fieldVal.geodataId,
                  id: fieldVal.id,
                  value: fieldVal.value,
                  columnId: colId,
                ),
              ) ??
              LyInput<FieldValueEntity>(
                pureValue: FieldValuePutEntity(
                  geodataId: fieldVal.geodataId,
                  id: fieldVal.id,
                  value: fieldVal.value,
                  columnId: colId,
                ),
              );
        }
        _formList.add(mapped);
      }
    } else {
      _addForm(); // Si no hay datos iniciales, agrega uno vacío
    }

    _updateInputBloc();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(widget.column.name),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              ..._formList.asMap().entries.map((entry) {
                final inputs = entry.value;
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: inputs.entries.map((field) {
                        final col = field.key;
                        final input = field.value;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: FieldRenderResolver.getInputWidget(
                            col,
                            input,
                            onChanged: (val) {
                              input.dirty(input.value.copyWithValue(val));
                              _updateInputBloc();
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                );
              }),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text('Agregar'),
                    onPressed: _addForm,
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.delete),
                    label: const Text('Eliminar'),
                    onPressed: _formList.length > 1
                        ? () => _removeForm(_formList.length - 1)
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
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
