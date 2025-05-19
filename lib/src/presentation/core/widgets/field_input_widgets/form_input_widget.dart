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
    // Check if the column has form columns directly
    if (column.type.extradata?['columns'] != null) {
      
      List<ColumnGetEntity> columns = [];

      for (Map<String, dynamic> col in column.type.extradata?['columns']) {
        columns.add(ColumnGetEntity.fromMap(col));
      }

      return _FormFieldsExpansion(
        columns: columns,
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

class _FormFieldsExpansion extends StatelessWidget {
  const _FormFieldsExpansion({
    required this.columns,
    required this.inputBloc,
    required this.column,
  });

  final List<ColumnGetEntity> columns;
  final LyInput<FieldValueEntity> inputBloc;
  final ColumnGetEntity column;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(column.name),
      children: [
        SizedBox(
          height: 200, // Ajusta según necesidad
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: columns.length,
            itemBuilder: (context, index) {
              final column = columns[index];
              return FieldRenderResolver.getInputWidget(
                column,
                LyInput<FieldValueEntity>(
                  pureValue: FieldValuePostEntity(
                    columnId: column.id,
                    value: null,
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) =>
                const SizedBox(height: 16), // Espacio entre items
          ),
        ),
      ],
    );
  }
}