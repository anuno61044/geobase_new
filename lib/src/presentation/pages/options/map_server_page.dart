import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:geobase/injection.dart';
import 'package:geobase/src/domain/core/enums/enums.dart';
import 'package:geobase/src/domain/core/extensions/enums_extensions.dart';
import 'package:geobase/src/domain/entities/entities.dart';
import 'package:geobase/src/presentation/core/widgets/basic_inputs/utils.dart';
import 'package:geobase/src/presentation/core/widgets/form_bloc/form_bloc_builder.dart';
import 'package:geobase/src/presentation/core/widgets/widgets.dart';
import 'package:geobase/src/presentation/pages/options/blocs/map_configuration_forms/map_configuration_form_bloc.dart';

class MapServerPage extends StatelessWidget {
  const MapServerPage({Key? key}) : super(key: key);

  static BeamPage getPage(BuildContext context) {
    return const BeamPage(
      key: ValueKey('MapServer'),
      title: 'Servidor de Mapas',
      child: MapServerPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const _MapServerInternalPage();
  }
}

class _MapServerInternalPage extends StatelessWidget {
  const _MapServerInternalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      appBar: AppBar(
        title: const Text('Servidor de Mapas'),
        iconTheme: Theme.of(context).iconTheme,
        centerTitle: true,
      ),
      body: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MapConfigurationFormBloc>(
      create: (context) => getIt<MapConfigurationFormBloc>(),
      child: const _SourceOptionsForm(),
    );
  }
}

class _SourceOptionsForm extends StatelessWidget {
  const _SourceOptionsForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics:
          const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: FormBlocListener(
          formBloc: context.read<MapConfigurationFormBloc>(),
          onSuccess: (context, state) => ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                backgroundColor: Colors.green.shade900,
                content: const Text('Se actualizó la configuración del mapa.'),
              ),
            ),
          child: FormBlocBuilder<
              MapConfigurationFormBloc,
              FormBlocState<MapConfigurationEntity, String>,
              MapConfigurationEntity,
              String>(
            bloc: context.read<MapConfigurationFormBloc>(),
            onLoadFailed: (failure) => FailureAndRetryWidget(
              errorText:
                  'Tenemos problemas para cargar la configuración :( ${failure ?? ''}',
              onPressed: () {
                return context.read<MapConfigurationFormBloc>().reload();
              },
            ),
            onFailure: (failure) => FailureAndRetryWidget(
              errorText:
                  'Tenemos problemas para guardar la configuración :( ${failure ?? ''}',
              onPressed: () {
                return context.read<MapConfigurationFormBloc>().reload();
              },
            ),
            onLoading: () => Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Theme.of(context).primaryColor,
              ),
            ),
            orElse: () => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Flexible(child: _SourceSelector()),
                const Flexible(child: _UrlTemplateInput()),
                const Flexible(child: _WMSBaseUrlInput()),
                const Flexible(child: _WMSFormatInput()),
                const Flexible(child: _WMSLayersInput()),
                const Flexible(child: _SubdomainsInput()),
                const SizedBox(height: 10),
                MainButton(
                  text: 'Guardar Servidor',
                  onPressed: () {
                    context.read<MapConfigurationFormBloc>().submit();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SourceSelector extends StatelessWidget {
  const _SourceSelector({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formBloc = context.read<MapConfigurationFormBloc>();
    return DropdownFieldBlocBuilder<MapSource>(
      // padding: const EdgeInsets.symmetric(vertical: 8),
      selectFieldBloc: formBloc.source,
      decoration: TextFieldDecorations.decoration(
        labelText: 'Protocolo',
      ),
      itemBuilder: (context, value) => value.name,
    );
  }
}

class _UrlTemplateInput extends StatelessWidget {
  const _UrlTemplateInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formBloc = context.read<MapConfigurationFormBloc>();
    return TextFieldBlocBuilder(
      textFieldBloc: formBloc.urlTemplate,
      // padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: TextFieldDecorations.decoration(
        labelText: 'Url Plantilla*',
      ),
    );
  }
}

class _WMSBaseUrlInput extends StatelessWidget {
  const _WMSBaseUrlInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formBloc = context.read<MapConfigurationFormBloc>();
    return TextFieldBlocBuilder(
      textFieldBloc: formBloc.wmsBaseUrl,
      // padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: TextFieldDecorations.decoration(
        labelText: 'Url Base*',
      ),
    );
  }
}

class _WMSFormatInput extends StatelessWidget {
  const _WMSFormatInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formBloc = context.read<MapConfigurationFormBloc>();
    return TextFieldBlocBuilder(
      textFieldBloc: formBloc.wmsFormat,
      // padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: TextFieldDecorations.decoration(
        labelText: 'Formato de las Imágenes*',
      ),
    );
  }
}

class _WMSLayersInput extends StatelessWidget {
  const _WMSLayersInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formBloc = context.read<MapConfigurationFormBloc>();
    return CanShowFieldBlocBuilder(
        fieldBloc: formBloc.wmsLayers,
        builder: (context, show) {
          return BlocBuilder<ListFieldBloc<TextFieldBloc>,
              ListFieldBlocState<TextFieldBloc>>(
            bloc: formBloc.wmsLayers,
            builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (show ?? false) ...[
                    const Divider(),
                    Text(
                      'Capas del mapa*',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.fieldBlocs.length,
                      itemBuilder: (context, i) {
                        return _AutoremovableListFieldBlocInput(
                          bloc: state.fieldBlocs[i],
                          index: i,
                          label: 'Capa #(${i + 1})*',
                        );
                      },
                    ),
                  ],
                ],
              );
            },
          );
        });
  }
}

class _SubdomainsInput extends StatelessWidget {
  const _SubdomainsInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formBloc = context.read<MapConfigurationFormBloc>();
    return CanShowFieldBlocBuilder(
        fieldBloc: formBloc.subdomains,
        builder: (context, show) {
          return BlocBuilder<ListFieldBloc<TextFieldBloc>,
              ListFieldBlocState<TextFieldBloc>>(
            bloc: formBloc.subdomains,
            builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (show ?? false) ...[
                    const Divider(),
                    Text(
                      'Subdominios*',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.fieldBlocs.length,
                      itemBuilder: (context, i) {
                        return _AutoremovableListFieldBlocInput(
                          bloc: state.fieldBlocs[i],
                          index: i,
                          label: 'Subdominio #(${i + 1})*',
                        );
                      },
                    ),
                  ],
                ],
              );
            },
          );
        });
  }
}

class _AutoremovableListFieldBlocInput extends StatelessWidget {
  const _AutoremovableListFieldBlocInput({
    Key? key,
    required this.bloc,
    required this.index,
    required this.label,
  }) : super(key: key);

  final TextFieldBloc bloc;
  final int index;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextFieldBlocBuilder(
      textFieldBloc: bloc,
      // padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: TextFieldDecorations.decoration(
        labelText: label,
      ),
    );
  }
}
