import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:geobase/src/domain/entities/entities.dart';
import 'package:geobase/src/presentation/core/widgets/widgets.dart';
import 'package:geobase/src/presentation/pages/form/blocs/form_form/form_form_bloc.dart';
import 'package:geobase/src/presentation/pages/form/blocs/column/column_field_bloc.dart';
import 'package:geobase/src/presentation/pages/form/widgets/inputs/inputs.dart';

class FormForm<FBloc extends FormFormBloc> extends StatelessWidget {
  const FormForm({
    super.key,
    required this.submitButtonText,
  });

  final String submitButtonText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(child: _Inputs<FBloc>()),
        MainButton(
          onPressed: context.read<FBloc>().submit,
          text: submitButtonText,
        )
      ],
    );
  }
}

class _Inputs<FBloc extends FormFormBloc> extends StatelessWidget {
  const _Inputs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          Flexible(child: _NameInput<FBloc>()),
          const SizedBox(height: 15),
          Flexible(child: _FieldsInput<FBloc>()),
          const SizedBox(height: 75),
        ],
      ),
    );
  }
}

class _NameInput<FBloc extends FormFormBloc> extends StatelessWidget {
  const _NameInput({super.key});

  @override
  Widget build(BuildContext context) {
    final formBloc = context.read<FBloc>();
    return TextFieldBlocBuilder(
      textFieldBloc: formBloc.name,
      decoration: TextFieldDecorations.decoration(
        labelText: 'Nombre*',
        prefixIcon: Icons.text_fields_outlined,
      ),
    );
  }
}

class _FieldsInput<FBloc extends FormFormBloc> extends StatelessWidget {
  const _FieldsInput({super.key});

  @override
  Widget build(BuildContext context) {
    final formBloc = context.read<FBloc>();
    return BlocBuilder<ListFieldBloc<ColumnFieldBloc, dynamic>,
        ListFieldBlocState<ColumnFieldBloc, dynamic>>(
      bloc: formBloc.columns,
      builder: (context, state) {
        return Column(
          children: [
            if (state.fieldBlocs.isNotEmpty) ...[
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.fieldBlocs.length,
                itemBuilder: (context, i) {
                  return _ColumnCardInput(
                    columnIndex: i,
                    columnField: state.fieldBlocs[i],
                    onRemoveMember: () => formBloc.removeColumn(i),
                  );
                },
              ),
            ],
            TextButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Añadir Columna'),
              onPressed: () {
                formBloc.addNewColumn();
              },
            ),
          ],
        );
      },
    );
  }
}

class _ColumnCardInput extends StatelessWidget {
  const _ColumnCardInput({
    required this.columnIndex,
    required this.columnField,
    required this.onRemoveMember,
  });

  final int columnIndex;

  final ColumnFieldBloc columnField;

  final VoidCallback onRemoveMember;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(5.0),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Columna #${columnIndex + 1}',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            TextFieldBlocBuilder(
              textFieldBloc: columnField.columnName,
              decoration: TextFieldDecorations.decoration(
                labelText: 'Nombre*',
              ),
            ),
            DropdownFieldBlocBuilder(
              selectFieldBloc: columnField.type,
              decoration: TextFieldDecorations.decoration(
                labelText: 'Tipo de Datos*',
              ),
              itemBuilder: (context, FieldTypeGetEntity value) => FieldItem(
                child: Text(
                  '${value.metaType} - ${value.name}',
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.highlight_remove_rounded),
              onPressed: onRemoveMember,
            ),
          ],
        ),
      ),
    );
  }
}
