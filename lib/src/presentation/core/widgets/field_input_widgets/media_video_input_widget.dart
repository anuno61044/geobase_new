import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lyform/flutter_lyform.dart';
import 'package:geobase/src/domain/entities/entities.dart';
import 'package:geobase/src/presentation/core/utils/file_utilis.dart';
import 'package:geobase/src/presentation/core/widgets/field_input_widgets/field_input_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class MediaVideoFieldInputWidget extends FieldInputWidget {
  const MediaVideoFieldInputWidget({
    super.key,
    required super.column,
    required super.inputBloc,
    this.onChanged,
  });

  final void Function(Object?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return LyInputBuilder<FieldValueEntity>(
      lyInput: inputBloc,
      builder: (context, state) {
        final path = state.value.value as String?;

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
                  : Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(45),
                    ),
                    width: 80,
                    height: 80,
                    child: Icon(
                      Icons.video_camera_back_rounded,
                      color: Colors.grey[800],
                    ),
                  ),
              title: Text(path != null ? path.split('/').last : ''),
              subtitle: Text(column.name),
              trailing: state.error != null
                  ? Icon(Icons.info_outline_rounded,
                      color: Colors.red.withOpacity(0.5))
                  : null,
              onTap: () async {
                final result = await _showPicker(context);
                if (result != null && result != path) {
                  inputBloc.dirty(state.value.copyWithValue(result));
                  onChanged?.call(result);
                }
              },
              onLongPress: () {
                if (path != null) {
                  OpenFile.open(path);
                }
              },
            );
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


Future<bool> _checkPermissions() async {
  final cameraStatus = await Permission.camera.status;
  final micStatus = await Permission.microphone.status;

  if (!cameraStatus.isGranted) {
    final cameraResult = await Permission.camera.request();
    if (!cameraResult.isGranted) {
      log('No tiene permiso de la cámara');
      return false;
    }
  }

  if (!micStatus.isGranted) {
    final micResult = await Permission.microphone.request();
    if (!micResult.isGranted) {
      log('No tiene permiso del micrófono');
      return false;
    }
  }

  return true;
}

Future<String?> _recordVideoFromCamera(BuildContext context) async {
  final hasPermission = await _checkPermissions();

  if (!hasPermission) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Permisos denegados')),
    );
    return null;
  }

  try {
    final XFile? videoFile = await ImagePicker().pickVideo(
      source: ImageSource.camera,
      maxDuration: const Duration(minutes: 5),
    );

    if (videoFile?.path != null) {
      final file = await saveFile(File(videoFile!.path));
      return file?.path;
    }
  } catch (e) {
    log('Error al grabar video: $e');
  }

  return null;
}

Future<String?> _videoFromGallery() async {
  final FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.video,
    allowMultiple: false,
  );

  if ((result?.files.isNotEmpty ?? false) && result!.files.first.path != null) {
    final file = await saveFile(
      File(result.files.first.path!),
    );
    log('ruta del video: ${file?.path}');
    return file?.path;
  }
  return null;
}

Future<String?> _showPicker(BuildContext context) async {
  return showModalBottomSheet<String?>(
    context: context,
    builder: (BuildContext bc) {
      return SafeArea(
        child: Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Galería'),
              onTap: () async {
                final path = await _videoFromGallery();
                Navigator.of(context).pop(path);
              },
            ),
            ListTile(
              leading: const Icon(Icons.videocam),
              title: const Text('Cámara'),
              onTap: () async {
                final path = await _recordVideoFromCamera(context);
                Navigator.of(context).pop(path);
              },
            ),
          ],
        ),
      );
    },
  );
}
