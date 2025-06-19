import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geobase/injection.dart';
import 'package:geobase/src/domain/entities/entities.dart';
import 'package:geobase/src/presentation/core/widgets/widgets.dart';
import 'package:geobase/src/presentation/pages/form/blocs/form_list/form_list_cubit.dart';
import 'package:geobase/src/presentation/pages/form/form_new_page.dart';
import 'package:geobase/src/presentation/pages/form/form_view_page.dart';

class FormListPage extends StatelessWidget {
  const FormListPage({super.key});

  static BeamPage getPage(BuildContext context) {
    return const BeamPage(
      key: ValueKey('FormList'),
      title: 'Formularios configurados',
      child: FormListPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FormListCubit>(
      create: (context) => getIt<FormListCubit>()..fetch(),
      child: const _FormListInternalPage(),
    );
  }
}

class _FormListInternalPage extends StatelessWidget {
  const _FormListInternalPage();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.beamToNamed('/options');
        return false;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        appBar: GeoAppBar(
          title: const Text('Formularios'),
          actions: [
            IconButton(
              onPressed: () => context.read<FormListCubit>().fetch(),
              icon: const Icon(
                Icons.refresh,
                color: Colors.white,
              ),
            )
          ],
        ),
        body: const _Body(),
        floatingActionButton: const _FloatingActionButton(),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormListCubit, FormListState>(
      bloc: context.read<FormListCubit>(),
      builder: (context, state) {
        return state.when(
          initial: () {
            return _InfoText('Listado de formularios configurados.');
          },
          fetchInProgress: () {
            return const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            );
          },
          fetchSuccess: (forms) {
            return ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                for (final form in forms) _FormWidget(form: form),
                const SizedBox(height: 80),
              ],
            );
          },
          fetchSuccessNotFound: () {
            return _InfoText('No se encontraron formularios configurados.');
          },
          fetchFailure: (error) {
            return Center(child: SelectableText(error));
          },
        );
      },
    );
  }
}

class _FormWidget extends StatelessWidget {
  const _FormWidget({required this.form});
  final FieldTypeFormGetEntity form;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListTile(
            title: SelectableText(form.name),
            subtitle: SelectableText('ID: ${form.id}'),
            trailing: IconButton(
                tooltip: 'Ver detalles del Formulario',
                icon: Icon(
                  Icons.keyboard_arrow_right,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                onPressed: () async {
                  final result = await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => FormViewPage(formId: form.id),
                    ),
                  );

                  if (result == true) {
                    await context.read<FormListCubit>().fetch();
                  }
                }),
          ),
        ),
      ),
    );
  }
}

class _FloatingActionButton extends StatelessWidget {
  const _FloatingActionButton();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      tooltip: 'Agregar Formulario',
      heroTag: null,
      child: const Icon(Icons.add),
      onPressed: () async {
        final result = await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const FormNewPage(),
          ),
        );

        if (result == true) {
          await context.read<FormListCubit>().fetch();
        }
      },
    );
  }
}

class _InfoText extends StatelessWidget {
  const _InfoText(this.message);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(flex: 3),
        Center(
          child: SelectableText(
            message,
            textAlign: TextAlign.center,
          ),
        ),
        const Spacer(flex: 2),
      ],
    );
  }
}
