import 'package:flutter/widgets.dart';
import 'package:flutter_lyform/flutter_lyform.dart';
import 'package:geobase/src/domain/entities/entities.dart';
import 'package:geobase/src/presentation/core/app.dart';
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
    return _InternalTextInput(
      key: key,
      column: column,
      bloc: inputBloc,
      onChanged: onChanged,
    );
  }
}

class _InternalTextInput extends StatefulWidget {
  const _InternalTextInput({
    super.key,
    required this.column,
    required this.bloc,
    this.onChanged,
  });

  final ColumnGetEntity column;
  final LyInput<FieldValueEntity> bloc;
  final void Function(Object?)? onChanged;

  @override
  State<_InternalTextInput> createState() => _InternalTextInputState();
}

class _InternalTextInputState extends State<_InternalTextInput> {
  late final TextEditingController controller;

  @override
  void initState() {
    final initialText = widget.bloc.state.value.value?.toString() ?? '';
    controller = TextEditingController(text: initialText);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LyInputBuilder<FieldValueEntity>(
      lyInput: widget.bloc,
      builder: (context, state) {
        return TextInputWidget(
          labelText: widget.column.name,
          controller: controller,
          errorText: state.error,
          keyboardType: const TextInputType.numberWithOptions(signed: true),
          onChanged: (newValue) {
            final newEntity = state.value.copyWithValue(newValue);
            widget.bloc.dirty(newEntity);
            widget.onChanged?.call(newValue);
          },
        );
      },
    );
  }
}
