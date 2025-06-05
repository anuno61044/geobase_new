import 'package:beamer/beamer.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:geobase/injection.dart';
import 'package:geobase/src/presentation/core/app.dart';
import 'package:geobase/src/presentation/core/utils/notification_helper.dart';
import 'package:geobase/src/presentation/core/widgets/widgets.dart';
import 'package:geobase/src/presentation/pages/form/blocs/form_form/form_create_form_bloc.dart';
import 'package:geobase/src/presentation/pages/form/widgets/form_form_widget.dart';

class FormNewPage extends StatelessWidget {
  const FormNewPage({super.key});

  static BeamPage getPage(BuildContext context) {
    return const BeamPage(
      key: ValueKey('FormNew'),
      title: 'Nuevo Formulario',
      child: FormNewPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FormCreateFormBloc>(
      create: (_) => getIt<FormCreateFormBloc>(),
      child: const _FormCreatePageInternal(),
    );
  }
}

class _FormCreatePageInternal extends StatelessWidget {
  const _FormCreatePageInternal();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        appBar: GeoAppBar(
          title: const Text('Nuevo Formulario'),
        ),
        body: FormBlocListener<FormCreateFormBloc, Unit, String>(
          formBloc: context.read<FormCreateFormBloc>(),
          onSuccess: (context, state) => NotificationHelper.showSuccessSnackbar(
            context,
            message: 'El formulario fue creado correctamente.',
            onShow: () => Navigator.of(context).pop(true),
          ),
          onFailure: (context, state) => NotificationHelper.showErrorSnackbar(
            context,
            message: state.failureResponse ??
                'Ha ocurrido un error, vuelva a intentarlo.',
          ),
          child: const Padding(
            padding: EdgeInsets.all(10.0),
            child: FormForm<FormCreateFormBloc>(
              submitButtonText: 'Añadir Formulario',
            ),
          ),
        ),
      ),
    );
  }
}
