import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_lyform/flutter_lyform.dart';
import 'package:geobase/src/domain/entities/entities.dart';
import 'package:geobase/src/presentation/core/app.dart';
import 'package:geobase/src/presentation/core/utils/file_utilis.dart';
import 'package:geobase/src/presentation/core/widgets/field_input_widgets/field_input_widget.dart';

import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class MediaAudioFieldInputWidget extends FieldInputWidget {
  const MediaAudioFieldInputWidget({
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
    final file = await saveFile(
      File(result.files.first.path!),
    );
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
                await _audioFromFiles()
                    .then((value) => Navigator.of(context).pop(value));
              },
            ),
            ListTile(
              leading: const Icon(Icons.mic),
              title: const Text('Grabar Sonido'),
              onTap: () async {
                await _audioFromMicrofone(context)
                    .then((value) => Navigator.of(context).pop(value));
              },
            ),
          ],
        ),
      );
    },
  );
}


Future<bool> _checkPermissions() async {
  // Verificar si ya tiene permisos
  if (await Permission.microphone.isGranted) {
    return true;
  }

  // Solicitar permisos
  final status = await Permission.microphone.request();
  return status.isGranted;
}


Future<String?> _audioFromMicrofone(BuildContext context) async {
  final record = Record();

  // Verificar permisos
  final hasPermission = await _checkPermissions();
  if (!hasPermission) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Permiso para acceder al micrófono denegado')),
    );
    return null;
  }

  // Obtener la ruta del directorio temporal para guardar la grabación
  final directory = await getTemporaryDirectory();
  final filePath = '${directory.path}/recording.m4a';

  // Mostrar un diálogo para grabar audio
  return showDialog<String>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Grabar Audio'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Presiona el botón para comenzar a grabar.'),
            const SizedBox(height: 20),
            StreamBuilder<RecordState>(
              stream: record.onStateChanged(),
              builder: (context, snapshot) {
                final isRecording = snapshot.data == RecordState.record;
                return IconButton(
                  icon: Icon(isRecording ? Icons.stop : Icons.mic),
                  onPressed: () async {
                    if (isRecording) {
                      // Detener la grabación
                      await record.stop();
                      Navigator.of(context).pop(filePath); // Retornar la ruta del archivo
                    } else {
                      // Comenzar la grabación
                      await record.start(
                        path: filePath,
                        encoder: AudioEncoder.aacLc, // Formato de audio
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
              Navigator.of(context).pop(); // Cerrar el diálogo sin grabar
            },
            child: const Text('Cancelar'),
          ),
        ],
      );
    },
  );
}
