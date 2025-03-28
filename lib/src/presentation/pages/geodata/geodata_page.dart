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
import 'package:excel/excel.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';

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
        floatingActionButton: BlocProvider<CategoriesShowerCubit>(
          create: (context) => getIt<CategoriesShowerCubit>(),
          child: const _FloatingActionButton(),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({this.queryWidgetKey = const Key('queryWidgetKey')});

  final Key queryWidgetKey;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CategoriesShowerCubit>(
      create: (context) => getIt<CategoriesShowerCubit>(),
      child: BlocBuilder<GeodataListBloc, GeodataListState>(
        bloc: context.read<GeodataListBloc>(),
        builder: (context, state) {
          return Stack(
            children: [
              state.when(
                initial: () => _buildInitialState(context),
                fetchInProgress: () => _buildLoadingState(context),
                fetchSuccess: (geodataList) => _buildSuccessState(context, geodataList),
                fetchSuccessNotFound: () => _buildNotFoundState(context),
                fetchFailure: (error) => _buildErrorState(context, error),
              ),
              BlocBuilder<CategoriesShowerCubit, CategoriesShowerState>(
                builder: (context, categoryState) {
                  return Positioned(
                    bottom: 15,
                    left: 15,
                    child: FloatingActionButton(
                      tooltip: 'Exportar Datos',
                      backgroundColor: Theme.of(context).primaryColor,
                      child: const Icon(Icons.download, color: Colors.white),
                      onPressed: () async {
                        await _exportToExcel(context, categoryState.selected);
                      },
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _exportToExcel(BuildContext context, int? categoryId) async {
    final geodataList = context.read<GeodataListBloc>().state.maybeWhen(
      fetchSuccess: (geodataList) => categoryId != null
          ? geodataList.where((g) => g.category.id == categoryId).toList()
          : geodataList, // Si categoryId es null, exporta todas las categorías.
      orElse: () => [],
    );

    if (geodataList.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No hay datos para exportar.')),
      );
      return;
    }

    // Obtener todos los nombres de columnas dinámicamente
    List<String> columnNames = ['ID', 'Categoría', 'Latitud', 'Longitud'];
    for (var geodata in geodataList) {
      for (var field in geodata.fields) {
        columnNames.add('${field.column.name}');
      }
    }

    // Crear archivo Excel
    var excel = Excel.createExcel();
    var sheet = excel[excel.getDefaultSheet()!];

    // Agregar encabezados
    sheet.appendRow(columnNames);

    // Agregar datos de los puntos
    for (var geodata in geodataList) {
      List<String> row = [
        geodata.id.toString(),
        geodata.category.name.toString(),
        geodata.latitude.toString(),
        geodata.longitude.toString(),
      ];

      for (var field in geodata.fields) {
        row.add(field.value.toString());
      }

      sheet.appendRow(row);
    }

    try {
      // Permitir al usuario seleccionar la ubicación del archivo
      String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

      if (selectedDirectory == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Selección de carpeta cancelada.')),
        );
        return;
      }

      final fileName = categoryId != null ? 'Geodata_$categoryId.xlsx' : 'Geodata_Todas_Categorias.xlsx';
      final filePath = '$selectedDirectory/$fileName';
      final file = File(filePath);

      // Verificar si el archivo ya existe y eliminarlo antes de escribir
      if (file.existsSync()) {
        await file.delete(); // Eliminar el archivo existente
      }

      await file.writeAsBytes(excel.encode()!);

      // Mostrar mensaje de confirmación con la ruta seleccionada
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Archivo guardado en: $filePath')),
      );
    } catch (e) {
      log('$e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al guardar el archivo: $e')),
      );
    }
  }




  Widget _buildInitialState(BuildContext context) => _buildMessageState(context, 'Seleccione una categoría para ver los datos.');
  Widget _buildLoadingState(BuildContext context) => const Center(child: CircularProgressIndicator());
  Widget _buildSuccessState(BuildContext context, List<GeodataGetEntity> geodataList) => ListView(children: [_QueryInput(key: queryWidgetKey), for (final geodata in geodataList) _GeodataWidget(geodata: geodata)]);
  Widget _buildNotFoundState(BuildContext context) => _buildMessageState(context, 'No se encontraron datos.');
  Widget _buildErrorState(BuildContext context, String error) => _buildMessageState(context, error);
  
  Widget _buildMessageState(BuildContext context, String message) {
    return Column(
      children: [
        _QueryInput(key: queryWidgetKey),
        Expanded(child: Center(child: Text(message, textAlign: TextAlign.center))),
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
    return BlocBuilder<CategoriesShowerCubit, CategoriesShowerState>(
      bloc: context.read<CategoriesShowerCubit>()..loadCategories(),
      builder: (context, state) {
        if (state.categories.isEmpty) {
          return const SizedBox();
        }
        return FloatingActionButton(
          tooltip: 'Agregar Punto de Interés',
          child: const Icon(Icons.add),
          onPressed: () {
            context.beamToNamed('/geodata/new');
          },
        );
      },
    );
  }
}
