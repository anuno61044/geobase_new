import 'package:beamer/beamer.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:geobase/injection.dart';
import 'package:geobase/src/presentation/core/utils/notification_helper.dart';
import 'package:geobase/src/presentation/pages/categories/blocs/category_form/category_edit_form_bloc.dart';
import 'package:geobase/src/presentation/pages/categories/widgets/category_form_widget.dart';

class CategoryEditPage extends StatelessWidget {
  const CategoryEditPage({
    Key? key,
    required this.categoryId,
  }) : super(key: key);

  final int categoryId;

  static BeamPage getPage(BuildContext context, int categoryId) {
    return BeamPage(
      key: const ValueKey('CategoryEdit'),
      title: 'Editar Categoría',
      child: CategoryEditPage(
        categoryId: categoryId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CategoryEditFormBloc>(
      create: (_) => getIt<CategoryEditFormBloc>(param1: categoryId)..reload(),
      child: const _CategoryEditPageInternal(),
    );
  }
}

class _CategoryEditPageInternal extends StatelessWidget {
  const _CategoryEditPageInternal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        appBar: AppBar(
          title: const Text('Editar Categoría'),
          iconTheme: Theme.of(context).iconTheme,
          centerTitle: true,
        ),
        body: FormBlocListener<CategoryEditFormBloc, Unit, String>(
          formBloc: context.read<CategoryEditFormBloc>(),
          onSuccess: (contex, state) => NotificationHelper.showSuccessSnackbar(
            context,
            message: 'La Categoría fue correctamente actualizada.',
            onShow: () => context.beamToNamed('/categories'),
          ),
          onLoadFailed: (context, state) =>
              NotificationHelper.showErrorSnackbar(
            context,
            message: state.failureResponse ??
                'Ha ocurrido un error, vuelva a intentarlo.',
          ),
          // onLoading: (context, state) => NotificationHelper.showFloatingProgressIndicatorOverlay(),
          onFailure: (context, state) => NotificationHelper.showErrorSnackbar(
            context,
            message: state.failureResponse ??
                'Ha ocurrido un error, vuelva a intentarlo.',
          ),
          onSubmitting: (context, state) =>
              NotificationHelper.showSuccessSnackbar(
            context,
            message: 'La solicitud está siendo procesada.',
          ),
          child: const Padding(
            padding: EdgeInsets.all(10.0),
            child: CategoryCreateForm<CategoryEditFormBloc>(
              submitButtonText: 'Aceptar Cambios',
            ),
          ),
        ),
      ),
    );
  }
}
