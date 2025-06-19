import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geobase/injection.dart';
import 'package:geobase/src/domain/entities/entities.dart';
import 'package:geobase/src/presentation/core/utils/utils.dart';
import 'package:geobase/src/presentation/core/widgets/widgets.dart';
import 'package:geobase/src/presentation/pages/form/blocs/blocs.dart';

class FormViewPage extends StatelessWidget {
  const FormViewPage({super.key, required this.formId});

  final int formId;

  static BeamPage getPage(BuildContext context, int formId) {
    return BeamPage(
      key: const ValueKey('FormDetails'),
      title: 'Detalles de Formulario',
      child: FormViewPage(formId: formId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FormViewCubit>(
      create: (_) => getIt<FormViewCubit>()..fetch(formId),
      child: _FormViewPageInternal(formId: formId),
    );
  }
}

class _FormViewPageInternal extends StatelessWidget {
  const _FormViewPageInternal({required this.formId});

  final int formId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      appBar: GeoAppBar(
        title: const Text('Detalles del Formulario'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () => context.read<FormViewCubit>().fetch(formId),
          ),
        ],
      ),
      body: _FormViewBody(formId: formId),
    );
  }
}

class _FormViewBody extends StatelessWidget {
  const _FormViewBody({required this.formId});

  final int formId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormViewCubit, FormViewState>(
      builder: (context, state) {
        return state.when(
          fetchInProgress: () =>
              const Center(child: CircularProgressIndicator(strokeWidth: 2)),
          fetchSuccess: (form) => _FormViewBodyFetchSuccess(form: form),
          fetchFailure: (failure) => FailureAndRetryWidget(
            errorText: failure,
            onPressed: () => context.read<FormViewCubit>().fetch(formId),
          ),
        );
      },
    );
  }
}

class _FormViewBodyFetchSuccess extends StatelessWidget {
  const _FormViewBodyFetchSuccess({required this.form});

  final FieldTypeFormGetEntity form;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: _FormViewBasicInfo(form: form)),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              // Expanded(
              //   child: MainButton(
              //     text: 'Editar',
              //     onPressed: () => context.beamToNamed('/forms/${form.id}/edit'),
              //   ),
              // ),
              // const SizedBox(width: 10),
              Expanded(
                child: MainButton(
                  text: 'Eliminar',
                  onPressed: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Eliminar Formulario'),
                        content: const Text(
                            '¿Está seguro? Esta acción es irreversible.'),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text('Sí')),
                          TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('No')),
                        ],
                      ),
                    );
                    if (confirm ?? false) {
                      final wasDeleted =
                          await context.read<FormViewCubit>().remove(form.id);
                      if (wasDeleted) {
                        Navigator.of(context).pop(true);
                      }
                    }
                  },
                  color: Colors.red.withOpacity(0.7),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _FormViewBasicInfo extends StatelessWidget {
  const _FormViewBasicInfo({required this.form});

  final FieldTypeFormGetEntity form;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(form.name, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 16),
          const Divider(),
          Text('Columnas', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          if (form.columns.isEmpty)
            const Text('Este formulario no tiene columnas definidas.'),
          ...form.columns.map((c) => ListTile(
                title: Text(c.name),
                subtitle: Text('Tipo: ${c.type.name}'),
              )),
        ],
      ),
    );
  }
}
