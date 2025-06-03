import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lyform/flutter_lyform.dart';
import 'package:geobase/src/domain/entities/entities.dart';
import 'package:geobase/src/presentation/core/app.dart';
import 'package:geobase/src/presentation/core/utils/file_utilis.dart';
import 'package:geobase/src/presentation/core/widgets/field_input_widgets/field_input_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

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
        return ListTile(
          title: Text(
            state.value.value != null
                ? '${state.value.value.split('/').last}'
                : '',
          ),
          subtitle: Text(column.name),
          leading: CircleAvatar(
            radius: 50,
            backgroundColor: Colors.transparent,
            child: Icon(
              Icons.video_camera_back,
              color: state.value.value != null
                  ? Colors.green[700]
                  : Colors.grey[800],
            ),
          ),
          trailing: state.error != null
              ? Icon(
                  Icons.info_outline_rounded,
                  color: Colors.red.withOpacity(0.5),
                )
              : null,
          onTap: () async {
            final result = await _showPicker(context);
            if (result != null && state.value.value != result) {
              inputBloc.dirty(state.value.copyWithValue(result));
              onChanged?.call(result);
            }
          },
        );
      },
    );
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
