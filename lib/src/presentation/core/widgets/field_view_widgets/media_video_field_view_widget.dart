import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geobase/src/presentation/core/widgets/field_view_widgets/field_view_widget.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class MediaVideoFieldView extends FieldViewWidget {
  const MediaVideoFieldView({
    super.key,
    required super.fieldValue,
  });

  @override
  Widget build(BuildContext context) {
    final path = fieldValue.value as String?;

    return FutureBuilder<String?>(
      future: _getVideoThumbnail(path),
      builder: (context, snapshot) {
        final thumbPath = snapshot.data;

        return ListTile(
          leading: thumbPath != null && File(thumbPath).existsSync()
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    File(thumbPath),
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                  ),
                )
              : const Icon(Icons.videocam, size: 56),
          title: Text(
            path != null ? '[${path.split('/').last}]' : '',
          ),
          subtitle: Text(
            '${fieldValue.column.name} '
            '(${fieldValue.column.type.metaType}.${fieldValue.column.type.name})',
          ),
          onTap: () async {
            if (path != null && path.isNotEmpty) {
              final result = await OpenFile.open(path);
              log(result.type.toString());
            }
          },
        );
      },
    );
  }

  Future<String?> _getVideoThumbnail(String? videoPath) async {
    if (videoPath == null || !File(videoPath).existsSync()) return null;

    try {
      final tempDir = await getTemporaryDirectory();
      final thumbPath = await VideoThumbnail.thumbnailFile(
        video: videoPath,
        thumbnailPath: tempDir.path,
        imageFormat: ImageFormat.PNG,
        maxHeight: 128,
        quality: 75,
      );
      return thumbPath;
    } catch (e) {
      log('Error al generar miniatura de video: $e');
      return null;
    }
  }
}
