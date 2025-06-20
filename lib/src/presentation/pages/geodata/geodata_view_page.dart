import 'dart:math' as math;

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geobase/injection.dart';
import 'package:geobase/src/domain/entities/entities.dart';
import 'package:geobase/src/presentation/core/utils/utils.dart';
import 'package:geobase/src/presentation/core/widgets/render_classes/reflect.dart';
import 'package:geobase/src/presentation/core/widgets/widgets.dart';
import 'package:geobase/src/presentation/pages/geodata/blocs/blocs.dart';
import 'package:geobase/src/presentation/router/locations.dart';

class GeodataViewPage extends StatelessWidget {
  const GeodataViewPage({
    super.key,
    required this.geodataId,
  });

  final int geodataId;

  static BeamPage getPage(BuildContext context, int geodataId) {
    return BeamPage(
      key: const ValueKey('GeodataDetails'),
      title: 'Detalles del Punto',
      child: GeodataViewPage(
        geodataId: geodataId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GeodataViewCubit>(
      create: (_) => getIt<GeodataViewCubit>()..fetch(geodataId),
      child: _GeodataViewPageInternal(geodataId: geodataId),
    );
  }
}

class _GeodataViewPageInternal extends StatelessWidget {
  const _GeodataViewPageInternal({
    required this.geodataId,
  });

  final int geodataId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      appBar: GeoAppBar(
        title: const Text('Detalles del Punto'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            onPressed: () => context.read<GeodataViewCubit>().fetch(geodataId),
          ),
        ],
      ),
      body: _GeodataViewBody(geodataId: geodataId),
    );
  }
}

class _GeodataViewBody extends StatelessWidget {
  const _GeodataViewBody({
    required this.geodataId,
  });

  final int geodataId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GeodataViewCubit, GeodataViewState>(
      builder: (context, state) {
        return state.when(
          fetchInProgress: () {
            return const _GeodataViewBodyFetchInProgress();
          },
          fetchSuccess: (geodata) {
            return _GeodataViewBodyFetchSuccess(geodata: geodata);
          },
          fetchFailure: (error) {
            return FailureAndRetryWidget(
              errorText: error,
              onPressed: () {
                context.read<GeodataViewCubit>().fetch(geodataId);
              },
            );
          },
        );
      },
    );
  }
}

class _GeodataViewBodyFetchSuccess extends StatelessWidget {
  const _GeodataViewBodyFetchSuccess({required this.geodata});

  final GeodataGetEntity geodata;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: _GeodataViewBasicInfo(
            geodata: geodata,
          ),
        ),
        _GeodataViewBodyFetchSucessBottom(
          geodataId: geodata.id,
        ),
      ],
    );
  }
}

class _GeodataViewBodyFetchInProgress extends StatelessWidget {
  const _GeodataViewBodyFetchInProgress();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}

class _GeodataViewBasicInfo extends StatelessWidget {
  const _GeodataViewBasicInfo({required this.geodata});

  final GeodataGetEntity geodata;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics:
          const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Flexible(
                flex: 2,
                child: ListTile(
                  title: Row(
                    children: [
                      Icon(
                        IconCodeUtils.decode(geodata.icon) ??
                            Icons.question_mark_rounded,
                        color: geodata.color != null
                            ? Color(geodata.color!)
                            : Theme.of(context).primaryColor,
                      ),
                      SizedBox(width: 4),
                      Text(geodata.category.name),
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: ListTile(
                  leading: Transform.rotate(
                    angle: -math.pi * 300 / 180,
                    child: const Icon(Icons.navigation_rounded),
                  ),
                  title: Wrap(
                    children: [
                      Text(
                        'Latitud: ${geodata.latitude.toStringAsFixed(1)}\nLongitud: ${geodata.longitude.toStringAsFixed(1)}',
                      ),
                    ],
                  ),
                  subtitle: const Text(
                    'Ir A',
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                  onTap: () => context.beamToNamed(
                    '/map?'
                    '$LAT_PARAM=${geodata.latitude}&'
                    '$LNG_PARAM=${geodata.longitude}',
                  ),
                ),
              ),
            ],
          ),
          const Divider(),
          if (geodata.fields.isEmpty)
            ListTile(
              title: Text(
                'Sin Campos',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          if (geodata.fields.isNotEmpty)
            Center(
              child: Text(
                'Campos',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ...[
            for (final field in geodata.fields)
              FieldRenderResolver.getViewWidget(field)
          ],
        ],
      ),
    );
  }
}

class _GeodataViewBodyFetchSucessBottom extends StatelessWidget {
  const _GeodataViewBodyFetchSucessBottom({
    required this.geodataId,
  });

  final int geodataId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: MainButton(
              text: 'Editar',
              onPressed: () {
                context.beamToNamed(
                  '/geodata/$geodataId/edit',
                );
              },
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: MainButton(
              text: 'Eliminar',
              onPressed: () {
                final result = showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    actionsAlignment: MainAxisAlignment.center,
                    title: const Text('Eliminar datos.'),
                    content:
                        const Text('La acción es irreversible ¿Está seguro?'),
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
                );
                result.then((value) {
                  if (value ?? false) {
                    context.read<GeodataViewCubit>().remove(geodataId).then(
                          (value) => context.beamToNamed('/map'),
                        );
                  }
                });
              },
              color: Colors.red.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}
