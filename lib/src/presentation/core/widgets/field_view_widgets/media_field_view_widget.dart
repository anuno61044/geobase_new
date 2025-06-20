import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geobase/src/presentation/core/widgets/field_view_widgets/field_view_widget.dart';
import 'package:open_file/open_file.dart';

class MediaFieldView extends FieldViewWidget {
  const MediaFieldView({
    super.key,
    required super.fieldValue,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        fieldValue.value != null ? '${fieldValue.value.split('/').last}' : '',
      ),
      subtitle: Text(
        '${fieldValue.column.name}'
        '(${fieldValue.column.type.metaType}.${fieldValue.column.type.name})',
      ),
      onTap: () async {
        if ((fieldValue.value is String?) && fieldValue.value != null) {
          final outputFile = await OpenFile.open(fieldValue.value as String);
          log(outputFile.type.toString());
        }
      },
    );
  }
}
