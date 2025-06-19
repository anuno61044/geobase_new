import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geobase/src/presentation/core/widgets/field_view_widgets/field_view_widget.dart';
import 'package:open_file/open_file.dart';

class MediaImageFieldView extends FieldViewWidget {
  const MediaImageFieldView({
    super.key,
    required super.fieldValue,
  });

  @override
  Widget build(BuildContext context) {
    String? path = fieldValue.value as String?;

    return ListTile(
      leading: path != null && File(path).existsSync()
          ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                File(path),
                width: 56,
                height: 56,
                fit: BoxFit.cover,
              ),
            )
          : const Icon(Icons.image_not_supported, size: 56),
      title: Text(
        path != null ? '[${path.split('/').last}]' : '',
      ),
      subtitle: Text(
        '${fieldValue.column.name}'
        '(${fieldValue.column.type.metaType}.${fieldValue.column.type.name})',
      ),
      onTap: () async {
        if (path is String && path.isNotEmpty) {
          final outputFile = await OpenFile.open(path);
          log(outputFile.type.toString());
        }
      },
    );
  }
}
