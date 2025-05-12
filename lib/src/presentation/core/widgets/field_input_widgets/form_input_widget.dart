import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lyform/flutter_lyform.dart';
import 'package:geobase/injection.dart';
import 'package:geobase/src/domain/entities/entities.dart';
import 'package:geobase/src/presentation/core/app.dart';
import 'package:geobase/src/presentation/core/widgets/commons/dropdown_field.dart';
import 'package:geobase/src/presentation/core/widgets/field_input_widgets/field_input_widget.dart';
import 'package:geobase/src/presentation/core/widgets/blocs/form_input_bloc/form_selector_bloc/form_selector_cubit.dart';
import 'package:geobase/src/presentation/core/widgets/render_classes/reflect.dart';

class FormFieldInputWidget extends FieldInputWidget {
  const FormFieldInputWidget({
    super.key,
    required super.column,
    required super.inputBloc,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<FormSelectorCubit>()..loadFormForColumn(column),
      child: BlocBuilder<FormSelectorCubit, FormSelectorState>(
        builder: (context, state) {
          return state.when(
            initial: () => const CircularProgressIndicator(),
            loading: () => const CircularProgressIndicator(),
            loaded: (form) {
              return _FormFieldsExpansion(
                form: form,
                inputBloc: inputBloc,
                column: column,
              );
            },
            empty: () => _buildDropdown([], context),
            error: (message) => Text('Error: $message'),
          );
        },
      ),
    );
  }

  Widget _buildDropdown(List<String> items, BuildContext context) {
    return LyInputBuilder<FieldValueEntity>(
      lyInput: inputBloc,
      builder: (context, state) {
        final value = state.value.value as String?;
        if (value != null && !items.contains(value)) {
          items.add(value);
        }
        return DropdownButtonFormFieldWidget<String>(
          key: key,
          items: items
              .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
              .toList(),
          value: state.value.value as String?,
          errorText: state.error,
          labelText: column.name,
          onChanged: (newValue) => inputBloc.dirty(
            state.value.copyWithValue(newValue),
          ),
        );
      },
    );
  }
}

class _FormFieldsExpansion extends StatelessWidget {
  const _FormFieldsExpansion({
    required this.form,
    required this.inputBloc,
    required this.column,
  });

  final FieldTypeFormGetEntity form;
  final LyInput<FieldValueEntity> inputBloc;
  final ColumnGetEntity column;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(column.name),
      children: [
        SizedBox(
          height: 200, // Ajusta según necesidad
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: form.columns.length,
            itemBuilder: (context, index) {
              final column = form.columns[index];
              return FieldRenderResolver.getInputWidget(
                column,
                LyInput<FieldValueEntity>(
                  pureValue: FieldValuePostEntity(
                    columnId: column.id,
                    value: null,
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) =>
                const SizedBox(height: 16), // Espacio entre items
          ),
        ),
      ],
    );
  }
}
