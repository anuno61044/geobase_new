import 'dart:convert';

import 'package:flutter_lyform/flutter_lyform.dart';
import 'package:geobase/src/domain/entities/entities.dart';
import 'package:geobase/src/presentation/core/app.dart';
import 'package:geobase/src/presentation/core/widgets/commons/dropdown_field.dart';
import 'package:geobase/src/presentation/core/widgets/field_input_widgets/field_input_widget.dart';

class StaticSelectionFieldInputWidget extends FieldInputWidget {

  const StaticSelectionFieldInputWidget({
    super.key,
    required super.column,
    required super.inputBloc,
    this.onChanged,
  });
  final ValueChanged<String?>? onChanged;

  @override
  Widget build(BuildContext context) {
    List<String> items = [];
    if(column.type.extradata?['options'] != null) {
      items = getOptions(column.type.extradata?['options']);
    }
    else {
      items = (column.type as FieldTypeStaticSelectionGetEntity).options;
    }
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
              .map(
                (e) => DropdownMenuItem<String>(value: e, child: Text(e)),
              )
              .toList(),
          value: value,
          errorText: state.error,
          labelText: column.name,
          onChanged: (newValue) {
            inputBloc.dirty(state.value.copyWithValue(newValue));
            if (onChanged != null) {
              onChanged!(newValue);
            }
          },
        );
      },
    );
  }
}

List<String> getOptions(dynamic jsonList) {
  List<String>? options;
  dynamic jsonListMutable = jsonList;

  if (jsonListMutable == null) return [];
  if (jsonListMutable is String?) {
    jsonListMutable = json.decode(jsonListMutable!);
    if (jsonListMutable == null) return [];
  }
  if (jsonListMutable is List?) {
    options = jsonListMutable!.map((e) => e as String).toList();
  }
  return options ?? [];
}
