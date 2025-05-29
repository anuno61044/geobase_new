import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geobase/src/domain/entities/entities.dart';
import 'package:geobase/src/presentation/core/widgets/field_view_widgets/field_view_widget.dart';
import 'package:geobase/src/presentation/core/widgets/render_classes/render_classes.dart';

class FormFieldView extends FieldViewWidget {
  const FormFieldView({
    super.key,
    required super.fieldValue,
  });

  @override
  Widget build(BuildContext context) {
    // Obtenemos los valores del formulario como Map<int, FieldValuePostEntity>
    final Map<int, FieldValueGetEntity> formValues =
        (jsonDecode(fieldValue.value as String) as Map<String, dynamic>?)
                ?.map<int, FieldValueGetEntity>(
              (key, value) => MapEntry(
                  int.parse(key),
                  FieldValueGetEntity.fromMap(value as Map<String, dynamic>)),
            ) ??
            {};

    return ExpansionTile(
      // Título principal del formulario
      title: Text(
        fieldValue.column.name,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),

      // Campos internos del formulario
      children: formValues.entries.map((entry) {
        final fieldValue = entry.value;

        return Padding(
          padding: const EdgeInsets.only(left: 24.0, bottom: 8.0),
          child: FieldRenderResolver.getViewWidget(fieldValue),
        );
      }).toList(),
    );
  }
}
