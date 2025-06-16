import 'dart:async';
import 'dart:developer';

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geobase/injection.dart';
import 'package:geobase/src/domain/entities/entities.dart';
import 'package:geobase/src/presentation/core/extensions/color_extension.dart';
import 'package:geobase/src/presentation/core/utils/notification_helper.dart';
import 'package:geobase/src/presentation/core/utils/shorten_str.dart';
import 'package:geobase/src/presentation/core/widgets/widgets.dart';
import 'package:geobase/src/presentation/pages/geodata/blocs/blocs.dart';
import 'package:geobase/src/presentation/pages/geodata/misc/misc.dart';

class GeodataPage extends StatelessWidget {
  const GeodataPage({
    super.key,
  });

  static BeamPage getPage(BuildContext context) {
    return const BeamPage(
      key: ValueKey('GeodataList'),
      title: 'Datos Georeferenciados',
      child: GeodataPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<GeodataListBloc>(),
      child: const _GeodataPageInternal(),
    );
  }
}

class _GeodataPageInternal extends StatelessWidget {
  const _GeodataPageInternal();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.beamToNamed('/map');
        return false;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        appBar: GeoAppBar(
          title: const Text('Datos Almacenados'),
        ),
        body: const _Body(),
        floatingActionButton: MultiBlocProvider(
          providers: [
            BlocProvider<CategoriesShowerCubit>(
              create: (context) => getIt<CategoriesShowerCubit>(),
            ),
            BlocProvider<GeodataExporterCubit>(
              create: (context) => getIt<GeodataExporterCubit>(),
            ),
          ],
          child: const _FloatingActionButton(),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    // ignore: unused_element
    this.queryWidgetKey = const Key('queryWidgetKey'),
  });

  final Key queryWidgetKey;
  // final queryController = TextEditingController();
  // final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CategoriesShowerCubit>(
      create: (context) => getIt<CategoriesShowerCubit>(),
      child: BlocBuilder<GeodataListBloc, GeodataListState>(
        bloc: context.read<GeodataListBloc>(),
        builder: (context, state) {
          return Stack(
            children: [
              // Contenido principal según estado
              state.when(
                initial: () {
                  return Column(
                    children: [
                      _QueryInput(key: queryWidgetKey),
                      const Flexible(
                        flex: 3,
                        child: Center(
                          child: SelectableText(
                            'Datos geográficos guardados\nEn la caja de texto de arriba puede acceder a estas seleccionando una categoría.',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const Flexible(flex: 2, child: SizedBox.shrink()),
                    ],
                  );
                },
                fetchInProgress: () {
                  return Column(
                    children: [
                      _QueryInput(key: queryWidgetKey),
                      Flexible(
                        flex: 3,
                        child: Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      const Flexible(flex: 2, child: SizedBox.shrink()),
                    ],
                  );
                },
                fetchSuccess: (geodataList) {
                  return ListView(
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    children: [
                      _QueryInput(key: queryWidgetKey),
                      for (final geodata in geodataList)
                        _GeodataWidget(geodata: geodata),
                      const SizedBox(height: 80),
                    ],
                  );
                },
                fetchSuccessNotFound: () {
                  return Column(
                    children: [
                      _QueryInput(key: queryWidgetKey),
                      const Flexible(
                        flex: 3,
                        child: Center(
                          child: SelectableText(
                            'No se encontraron datos de acuerdo '
                            'a los parámetros de búsqueda.',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const Flexible(flex: 2, child: SizedBox.shrink()),
                    ],
                  );
                },
                fetchFailure: (error) {
                  return Column(
                    children: [
                      _QueryInput(key: queryWidgetKey),
                      Flexible(
                        flex: 3,
                        child: Center(
                          child: SelectableText(
                            error,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const Flexible(flex: 2, child: SizedBox.shrink()),
                    ],
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLoadingState(BuildContext context) =>
      const Center(child: CircularProgressIndicator());

  Widget _buildExportSuccessState(BuildContext context, String filePath) =>
      _buildMessageState(
          context, 'Datos exportados correctamente en: $filePath');

  Widget _buildExportErrorState(BuildContext context, String error) =>
      _buildMessageState(context, error);

  Widget _buildMessageState(BuildContext context, String message) {
    return Column(
      children: [
        Expanded(
            child: Center(child: Text(message, textAlign: TextAlign.center))),
      ],
    );
  }
}

class _GeodataWidget extends StatelessWidget {
  const _GeodataWidget({
    required this.geodata,
  });

  final GeodataGetEntity geodata;

  @override
  Widget build(BuildContext context) {
    final color = geodata.color != null
        ? Color(geodata.color!).withOpacity(0.5)
        : Colors.white;
    final titleSmall = Theme.of(context).textTheme.titleSmall;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListTile(
            title: SelectableText(
              '${geodata.category.name}\n${geodata.location.visualString()}',
              style: titleSmall?.copyWith(
                color: titleSmall.color?.getContrastColor(color),
              ),
            ),
            subtitle: SelectableText(
              geodata.fields.isNotEmpty
                  ? shortenStr(
                      geodata.fields.map((e) => e.value.toString()).join(', '),
                      addDots: true,
                      strLimit: 60,
                    )
                  : 'Sin Campos',
              // maxLines: 3, //if contains a file is a risks
              // overflow: TextOverflow.fade,
            ),
            trailing: IconButton(
              tooltip: 'Ver detalles del punto',
              icon: Icon(
                Icons.keyboard_arrow_right,
                color: Theme.of(context)
                    .colorScheme
                    .secondary
                    .getContrastColor(color),
              ),
              onPressed: () {
                context.beamToNamed('/geodata/${geodata.id}');
                context.read<CategoriesShowerCubit>().clear();
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _QueryInput extends StatelessWidget {
  const _QueryInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoriesShowerCubit, CategoriesShowerState>(
      bloc: context.read<CategoriesShowerCubit>()..loadCategories(),
      listener: (context, state) async {
        if (state.selected == null) {
          context
              .read<GeodataListBloc>()
              .add(GeodataListEvent.fetched(categoryId: state.selected));
        }
        if (state.categories.isEmpty) {
          await Future.delayed(
            const Duration(seconds: 1),
            () => NotificationHelper.showInfoSnackbar(
              context,
              message: 'No hay categorías configuradas.',
            ),
          );
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(15),
          child: DropdownButtonFormFieldWidget<int>(
            items: state.categories.map((CategoryGetEntity categ) {
              return DropdownMenuItem(
                value: categ.id,
                child: Row(
                  children: <Widget>[
                    Text(categ.name),
                  ],
                ),
              );
            }).toList(),
            onChanged: (newValue) {
              context.read<CategoriesShowerCubit>().changeCategory(newValue);
              context
                  .read<GeodataListBloc>()
                  .add(GeodataListEvent.fetched(categoryId: newValue));
            },
            value: state.selected,
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: context.read<CategoriesShowerCubit>().clear,
            ),
            prefixIcon: Icons.manage_search_rounded,
            labelText: 'Buscar por Categoría',
          ),
        );
      },
    );
  }
}

class _FloatingActionButton extends StatelessWidget {
  const _FloatingActionButton();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Botón de Exportación con mejor feedback visual
        BlocConsumer<GeodataExporterCubit, GeodataExporterState>(
          listener: (context, state) {
            if (state.status.isLoaded) {
              NotificationHelper.showSuccessSnackbar(
                context,
                message: 'Datos exportados correctamente',
              );
              if (state.filePath != null) {
                log('Archivo exportado en: ${state.filePath}');
              }
            }
            if (state.status.isFailure) {
              NotificationHelper.showErrorSnackbar(
                context,
                message: 'Error al exportar los datos',
              );
            }
          },
          builder: (context, state) {
            return Stack(
              alignment: Alignment.center,
              children: [
                FloatingActionButton(
                  tooltip: 'Exportar geodatas',
                  heroTag: 'export_button',
                  onPressed: state.status.isLoading
                      ? null
                      : () async {
                          final mode = await showDialog<GeodataExportMode>(
                            context: context,
                            builder: (_) => const _ExportOptionDialog(),
                          );

                          if (mode != null) {
                            await context
                                .read<GeodataExporterCubit>()
                                .exportGeodataWithMode(mode);
                          }
                        },
                  child: const Icon(Icons.download),
                ),
                if (state.status.isLoading)
                  Positioned(
                    right: 10,
                    top: 10,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: const SizedBox(
                        width: 12,
                        height: 12,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
        const SizedBox(height: 16),
        // Botón de Agregar
        FloatingActionButton(
          tooltip: 'Agregar Punto de Interés',
          child: const Icon(Icons.add),
          onPressed: () => context.beamToNamed('/geodata/new'),
        ),
      ],
    );
  }
}

class _ExportOptionDialog extends StatelessWidget {
  const _ExportOptionDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Exportar Geodatos'),
      content: const Text(
        '¿Dónde desea exportar los datos?\n'
        'Puede usar la carpeta predefinida o seleccionar una manualmente.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(GeodataExportMode.defaultDirectory),
          child: const Text('Ruta Predefinida'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(GeodataExportMode.manualSelection),
          child: const Text('Seleccionar Carpeta'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
      ],
    );
  }
}

