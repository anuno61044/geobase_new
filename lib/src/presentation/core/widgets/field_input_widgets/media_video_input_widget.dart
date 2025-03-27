import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_lyform/flutter_lyform.dart';
import 'package:geobase/src/domain/entities/entities.dart';
import 'package:geobase/src/presentation/core/app.dart';
import 'package:geobase/src/presentation/core/utils/file_utilis.dart';
import 'package:geobase/src/presentation/core/widgets/field_input_widgets/field_input_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:permission_handler/permission_handler.dart';

class MediaVideoFieldInputWidget extends FieldInputWidget {
  const MediaVideoFieldInputWidget({
    super.key,
    required super.column,
    required super.inputBloc,
  });

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
            child: state.value.value != null
                ? ClipRRect(
                    key: Key(column.name),
                    borderRadius: BorderRadius.circular(100),
                    child: Image.file(
                      File(state.value.value.toString()),
                      width: 80,
                      height: 80,
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
                      Icons.camera_alt,
                      color: Colors.grey[800],
                    ),
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
            }
          },
        );
      },
    );
  }
}

Future<bool> _checkPermissions() async {
  // 1. Verificar estado actual de los permisos
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
      log('No tiene permiso del microfono');
      return false;
    }
  }

  return true;
}

Future<String?> _recordVideoFromCamera(BuildContext context) async {

  // Verificar permisos
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
    type: FileType.video,  // Cambiamos a video
    allowMultiple: false,  // Opcional: permitir solo un video
  );
  
  if ((result?.files.isNotEmpty ?? false) && result!.files.first.path != null) {
    final file = await saveFile(
      File(result.files.first.path!),
    );
    String? path = file?.path;
    log('ruta del video: $path');
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
                await _videoFromGallery()
                    .then((value) => Navigator.of(context).pop(value));
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text('Cámara'),
              onTap: () async {
                await _recordVideoFromCamera(context)
                    .then((value) => Navigator.of(context).pop(value));
              },
            ),
          ],
        ),
      );
    },
  );
}
