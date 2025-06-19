import 'package:flutter/material.dart';
import 'package:flutter_lyform/flutter_lyform.dart';
import 'package:geobase/src/domain/entities/entities.dart';
import 'package:geobase/src/presentation/core/app.dart';
import 'package:geobase/src/presentation/core/widgets/field_input_widgets/field_input_widget.dart';

class BoolFieldInputWidget extends FieldInputWidget {
  const BoolFieldInputWidget({
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
        final currentValue = (state.value.value as bool?) ?? false;
        
        return CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(column.name),
          value: currentValue,
          onChanged: (newValue) {
            if (newValue != null) {
              final newEntity = state.value.copyWithValue(newValue);
              inputBloc.dirty(newEntity);
              onChanged?.call(newValue);
            }
          },
        );
      },
    );
  }
}

class _InternalCheckboxInput extends StatefulWidget {
  const _InternalCheckboxInput({
    super.key,
    required this.column,
    required this.bloc,
    this.onChanged,
  });

  final ColumnGetEntity column;
  final LyInput<FieldValueEntity> bloc;
  final void Function(Object?)? onChanged;

  @override
  State<_InternalCheckboxInput> createState() => _InternalCheckboxInputState();
}

class _InternalCheckboxInputState extends State<_InternalCheckboxInput> {
  late bool currentValue;

  @override
  void initState() {
    currentValue = (widget.bloc.state.value.value as bool?) ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LyInputBuilder<FieldValueEntity>(
      lyInput: widget.bloc,
      builder: (context, state) {
        return CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(widget.column.name),
          value: currentValue,
          onChanged: (newValue) {
            if (newValue != null) {
              setState(() {
                currentValue = newValue;
              });
              final newEntity = state.value.copyWithValue(newValue);
              widget.bloc.dirty(newEntity);
              widget.onChanged?.call(newValue);
            }
          },
        );
      },
    );
  }
}