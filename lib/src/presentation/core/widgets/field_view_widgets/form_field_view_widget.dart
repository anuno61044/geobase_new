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
    final List<Map<int, FieldValueGetEntity>> formValues = [];

    for (final item in fieldValue.value) {
      final Map<int, FieldValueGetEntity> subFormValue =
          (jsonDecode(item as String) as Map<String, dynamic>?)
                  ?.map<int, FieldValueGetEntity>(
                (key, value) => MapEntry(
                  int.parse(key),
                  FieldValueGetEntity.fromMap(value as Map<String, dynamic>),
                ),
              ) ??
              {};
      formValues.add(subFormValue);
    }

    return ExpansionTile(
      title: Text(
        fieldValue.column.name,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
      children: formValues.asMap().entries.map((entry) {
        final subFormFields = entry.value;

        return Padding(
          padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: subFormFields.entries.map((fieldEntry) {
                  final fieldValue = fieldEntry.value;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: FieldRenderResolver.getViewWidget(fieldValue),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
