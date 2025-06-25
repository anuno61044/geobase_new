// ignore_for_file: use_build_context_synchronously

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geobase/injection.dart';
import 'package:geobase/src/domain/entities/entities.dart';
import 'package:geobase/src/presentation/core/constants/constants.dart';
import 'package:geobase/src/presentation/core/widgets/commons/dropdown_field.dart';
import 'package:geobase/src/presentation/pages/home/blocs/blocs.dart';
import 'package:geobase/src/presentation/pages/home/widgets/widgets.dart';
import 'package:latlong2/latlong.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    this.initialLocation,
  });

  final LatLng? initialLocation;

  static BeamPage getPage(BuildContext context, {LatLng? initialLocation}) {
    return BeamPage(
      key: const ValueKey('Map'),
      title: 'Inicio',
      child: HomePage(
        initialLocation: initialLocation,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SlidingUpPanelCubit>(
      create: (context) => getIt<SlidingUpPanelCubit>(),
      child: _InternalHomePage(
        initialLocation: initialLocation,
        panelHeight: MediaQuery.of(context).size.height * 0.40,
      ),
    );
  }
}

class _InternalHomePage extends StatelessWidget {
  const _InternalHomePage({
    required this.initialLocation,
    required this.panelHeight,
  });

  final LatLng? initialLocation;

  final double panelHeight;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (context.read<SlidingUpPanelCubit>().panelController.isAttached &&
            !context
                .read<SlidingUpPanelCubit>()
                .panelController
                .isPanelClosed) {
          await context.read<SlidingUpPanelCubit>().closePanel();
          return false;
        }
        return await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                actionsAlignment: MainAxisAlignment.center,
                title: const Text('¿Quiere salir?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text('Si'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('No'),
                  )
                ],
              ),
            ) ??
            false;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: const Color(0x33000000),
          title: const Text(APP_NAME),
          actions: [
            TextButton.icon(
              onPressed: () {
                context.beamToNamed('/options');
              },
              icon: const Icon(
                Icons.settings_rounded,
                color: Colors.white,
              ),
              label: const SizedBox(),
            ),
          ],
        ),
        body: BlocBuilder<SlidingUpPanelCubit, SlidingUpPanelState>(
          bloc: context.read<SlidingUpPanelCubit>(),
          builder: (context, state) {
            return SlidingUpPanel(
              minHeight: 0,
              maxHeight: panelHeight,
              backdropOpacity: 0,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              color: Colors.blueGrey.shade100,
              controller: context.read<SlidingUpPanelCubit>().panelController,
              body: MultiBlocProvider(
                providers: [
                  BlocProvider<MapCubit>(
                    create: (context) =>
                        getIt<MapCubit>(param1: initialLocation),
                  ),
                  BlocProvider<MarkerCubit>(
                    create: (context) => getIt<MarkerCubit>()..refreshMarkers(),
                  ),
                  BlocProvider<LocationCubit>(
                    create: (context) => getIt<LocationCubit>(),
                  ),
                  BlocProvider<ImportedGeodataCubit>(
                    create: (context) => getIt<ImportedGeodataCubit>(),
                  ),
                ],
                child: const _MapScreen(),
              ),
              panel: _SlidingUpPanelWidget(panelHeight: panelHeight),
              // collapsed: const _SlidingUpCollapsedWidget(),
            );
          },
        ),
      ),
    );
  }
}

class _SlidingUpPanelWidget extends StatelessWidget {
  const _SlidingUpPanelWidget({
    required this.panelHeight,
  });

  final double panelHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: panelHeight,
      child: BlocBuilder<SlidingUpPanelCubit, SlidingUpPanelState>(
        bloc: context.read<SlidingUpPanelCubit>(),
        builder: (context, state) {
          return state.maybeMap(
            detailsPanel: (detailsPanel) => SlideUpInformationalPanel(
              key: Key('${detailsPanel.geodataId}'),
              geodataId: detailsPanel.geodataId,
              panelHeight: panelHeight,
            ),
            newPanel: (newPanel) => SlideUpAddNewPanel(
              key: Key('${newPanel.ubication}'),
              ubication: newPanel.ubication,
            ),
            orElse: () => const SizedBox(),
          );
        },
      ),
    );
  }
}

class _MapScreen extends StatelessWidget {
  const _MapScreen();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: const [
        GeoBaseMap(),
        Positioned(top: 110, right: 20, child: _FiltersButton()),
        Positioned(bottom: 50, right: 10, child: _GotoLocationButton()),
        Positioned(top: 110, left: 20, child: _GeodataListButton()),
        Positioned(bottom: 120, right: 10, child: _ImportPointsButton()),
      ],
    );
  }
}

class _GeodataListButton extends StatelessWidget {
  const _GeodataListButton();

  @override
  Widget build(BuildContext context) {
    return _FloatingActionButtonWidget(
      onPressed: () {
        context.beamToNamed('/geodata');
      },
      iconData: Icons.view_list_rounded,
    );
  }
}

class _FiltersButton extends StatelessWidget {
  const _FiltersButton();

  @override
  Widget build(BuildContext context) {
    return _FloatingActionButtonWidget(
      onPressed: () async {
        final mapMode = await showDialog<MapModeEntity>(
          context: context,
          builder: (context) {
            return BlocBuilder<CategoriesMapSelectorCubit,
                CategoriesMapSelectorState>(
              bloc: getIt<CategoriesMapSelectorCubit>()..loadCategories(),
              builder: (context, state) {
                return SimpleDialog(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: const Text(
                    'Seleccione la categoría que se mostrará y usará:',
                  ),
                  children: [
                    DropdownButtonFormFieldWidget<int>(
                      items: state.categories
                          .map(
                            (e) => DropdownMenuItem<int>(
                              value: e.id,
                              child: Text(e.name),
                            ),
                          )
                          .toList(),
                      onChanged: (newValue) => Navigator.of(context).pop(
                        MapModeEntity(categoryUsed: newValue),
                      ),
                      value: state.selected,
                      labelText: 'Categoría a Usar',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () => Navigator.of(context).pop(
                          const MapModeEntity(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                );
              },
            );
          },
        );
        if (mapMode != null) {
          // ignore: unawaited_futures
          await context
              .read<MapCubit>()
              .setMapMode(mapMode)
              .whenComplete(() => context.read<MarkerCubit>().refreshMarkers());
        }
      },
      iconData: Icons.manage_accounts_rounded,
    );
  }
}

class _GotoLocationButton extends StatelessWidget {
  const _GotoLocationButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, state) {
        return FloatingActionButton.extended(
          heroTag: null,
          icon: state.maybeMap(
            enable: (_) => const Icon(Icons.navigation_rounded),
            disable: (_) => const Icon(Icons.navigation_outlined),
            orElse: () => const
                // SizedBox(),
                CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ),
          ),
          onPressed: state.map(
            loading: (loading) => null,
            disable: (disable) => context.read<LocationCubit>().enableLocation,
            enable: (enable) => () {
              context.read<MapCubit>().state.mapController.move(
                    enable.location,
                    context.read<MapCubit>().state.mapController.camera.zoom,
                  );
            },
          ),
          elevation: 0,
          backgroundColor: Colors.blueGrey.withOpacity(0.5),
          shape: StadiumBorder(
            side: BorderSide(color: Colors.blue.withOpacity(.3), width: 2),
          ),
          label: const Text('Ir a mi ubicación'),
        );
      },
    );
  }
}

class _ImportPointsButton extends StatelessWidget {
  const _ImportPointsButton();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ImportedGeodataCubit, ImportedGeodataState>(
      listener: (context, state) {
        state.maybeWhen(
          error: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            );
          },
          loaded: (_) {
            context.read<MarkerCubit>().refreshMarkers();
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        // Corrección aquí: usar state.isLoading() o state.maybeWhen
        final isLoading = state.maybeWhen(
          loading: () => true,
          orElse: () => false,
        );

        final hasImportedPoints = state.maybeWhen(
          loaded: (points) => points.isNotEmpty,
          orElse: () => false,
        );

        // Determinar si es una operación de importación o eliminación
        final isImporting = isLoading && !hasImportedPoints;
        final isDeleting = isLoading && hasImportedPoints;

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Botón de importar
            _FloatingActionButtonWidget(
              onPressed: isLoading
                  ? null
                  : () async {
                      await context.read<ImportedGeodataCubit>().importPoints();
                    },
              iconData: Icons.file_download_rounded,
              isLoading: isImporting,
            ),

            if (hasImportedPoints || isDeleting) const SizedBox(width: 8),

            if (hasImportedPoints || isDeleting)
              _FloatingActionButtonWidget(
                onPressed: isLoading
                    ? null
                    : () => _showClearConfirmationDialog(context),
                iconData: Icons.delete_forever,
                backgroundColor: Colors.red,
                isLoading: isDeleting,
              ),
          ],
        );
      },
    );
  }

  void _showClearConfirmationDialog(BuildContext context) {
    final importedGeodataCubit = context.read<ImportedGeodataCubit>();
    final markerCubit = context.read<MarkerCubit>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar puntos importados'),
        content: const Text(
          '¿Estás seguro de que quieres eliminar todos los puntos importados? '
          'Esta acción no se puede deshacer.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await importedGeodataCubit.clear();
              await markerCubit.refreshMarkers();
            },
            child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class _FloatingActionButtonWidget extends StatelessWidget {
  const _FloatingActionButtonWidget({
    required this.onPressed,
    required this.iconData,
    this.backgroundColor,
    this.isLoading = false,
  });

  final VoidCallback? onPressed;
  final IconData iconData;
  final Color? backgroundColor;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: UniqueKey(),
      backgroundColor: backgroundColor ?? Colors.blueGrey.withOpacity(0.5),
      onPressed: onPressed,
      shape: const StadiumBorder(
        side: BorderSide(color: Colors.white, width: 2),
      ),
      elevation: 0,
      child: isLoading
          ? SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
          : Icon(iconData),
    );
  }
}
