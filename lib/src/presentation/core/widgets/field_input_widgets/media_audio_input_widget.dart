import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lyform/flutter_lyform.dart';
import 'package:geobase/src/domain/entities/entities.dart';
import 'package:geobase/src/presentation/core/utils/file_utilis.dart';
import 'package:geobase/src/presentation/core/widgets/field_input_widgets/field_input_widget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';

class MediaAudioFieldInputWidget extends FieldInputWidget {
  const MediaAudioFieldInputWidget({
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
            backgroundColor: Theme.of(context).primaryColor,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(45),
              ),
              width: 80,
              height: 80,
              child: Icon(
                Icons.file_present_rounded,
                color: state.value.value != null
                    ? Colors.green[300]
                    : Colors.grey[800],
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
              onChanged?.call(result);
            }
          },
        );
      },
    );
  }
}


Future<String?> _audioFromFiles() async {
  final FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.audio,
    withData: true,
  );
  if ((result?.files.isNotEmpty ?? false) && result!.files.first.path != null) {
    final file = await saveFile(File(result.files.first.path!));
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
              leading: const Icon(Icons.file_present),
              title: const Text('Notas Almacenadas'),
              onTap: () async {
                final path = await _audioFromFiles();
                Navigator.of(context).pop(path);
              },
            ),
            ListTile(
              leading: const Icon(Icons.mic),
              title: const Text('Grabar Sonido'),
              onTap: () async {
                final path = await _audioFromMicrofone(context);
                Navigator.of(context).pop(path);
              },
            ),
          ],
        ),
      );
    },
  );
}

Future<bool> _checkPermissions() async {
  if (await Permission.microphone.isGranted) return true;
  final status = await Permission.microphone.request();
  return status.isGranted;
}

Future<String?> _audioFromMicrofone(BuildContext context) async {
  final record = Record();

  final hasPermission = await _checkPermissions();
  if (!hasPermission) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Permiso para acceder al micrófono denegado')),
    );
    return null;
  }

  final directory = await getTemporaryDirectory();
  final tempPath = '${directory.path}/recording_${DateTime.now().millisecondsSinceEpoch}.m4a';

  return showDialog<String>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Grabar Audio'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Presiona el botón para comenzar/detener la grabación.'),
            const SizedBox(height: 20),
            StreamBuilder<RecordState>(
              stream: record.onStateChanged(),
              builder: (context, snapshot) {
                final isRecording = snapshot.data == RecordState.record;
                return IconButton(
                  icon: Icon(isRecording ? Icons.stop : Icons.mic),
                  onPressed: () async {
                    if (isRecording) {
                      await record.stop();
                      final savedFile = await saveFile(File(tempPath));
                      Navigator.of(context).pop(savedFile?.path);
                    } else {
                      await record.start(
                        path: tempPath,
                        encoder: AudioEncoder.aacLc,
                      );
                    }
                  },
                );
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              record.stop();
              Navigator.of(context).pop(); // Cancelar
            },
            child: const Text('Cancelar'),
          ),
        ],
      );
    },
  );
}
