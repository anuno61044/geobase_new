import 'package:flutter/widgets.dart';
import 'package:flutter_lyform/flutter_lyform.dart';
import 'package:geobase/src/domain/entities/entities.dart';
import 'package:geobase/src/presentation/core/widgets/basic_inputs/basic_inputs.dart';
import 'package:geobase/src/presentation/core/widgets/field_input_widgets/field_input_widget.dart';

class IntFieldInputWidget extends FieldInputWidget {
  const IntFieldInputWidget({
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
        final controller = TextEditingController(
          text: state.value.value?.toString() ?? '',
        );

        // Este hack evita que el controlador borre el texto al reconstruir.
        controller.selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length),
        );

        return TextInputWidget(
          labelText: column.name,
          controller: controller,
          errorText: state.error,
          keyboardType: const TextInputType.numberWithOptions(signed: true),
          onChanged: (newValue) {
            final intValue = int.tryParse(newValue);
            final newEntity = state.value.copyWithValue(intValue);
            inputBloc.dirty(newEntity);
            onChanged?.call(intValue);
          },
        );
      },
    );
  }
}
