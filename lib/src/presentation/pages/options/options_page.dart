import 'package:beamer/beamer.dart';
import 'package:geobase/src/presentation/core/app.dart';
import 'package:geobase/src/presentation/core/widgets/widgets.dart';

class OptionsPage extends StatelessWidget {
  const OptionsPage({super.key});

  static BeamPage getPage(BuildContext context) {
    return const BeamPage(
      key: ValueKey('Options'),
      title: 'Opciones',
      child: OptionsPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const _OptionsInternalPage();
  }
}

class _OptionsInternalPage extends StatelessWidget {
  const _OptionsInternalPage();

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
          title: const Text('Opciones'),
        ),
        body: const _Body(),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final titleLarge = Theme.of(context).textTheme.titleLarge;
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(
              'Categorías',
              style: titleLarge,
            ),
            trailing: const Icon(Icons.category),
            onTap: () => context.beamToNamed('/categories'),
          ),
          ExpansionTile(
            title: Text(
              'Tipos',
              style: titleLarge,
            ),
            children: [
              ListTile(
                title: Text(
                  'Selección Stática (StaticSelection)',
                  style: titleLarge?.copyWith(
                    color: titleLarge.color?.withOpacity(0.7),
                  ),
                ),
                trailing: const Icon(Icons.account_tree_rounded),
                onTap: () => context.beamToNamed('/staticselection'),
              ),
              ListTile(
                title: Text(
                  'Formularios (Form)',
                  style: titleLarge?.copyWith(
                    color: titleLarge.color?.withOpacity(0.7),
                  ),
                ),
                trailing: const Icon(Icons.assignment),
                onTap: () => context.beamToNamed('/form'),
              ),
            ],
          ),
          ListTile(
            title: Text(
              'Servidor de Mapas',
              style: titleLarge,
            ),
            trailing: const Icon(Icons.map_outlined),
            onTap: () => context.beamToNamed('/options/mapserver'),
          ),
        ],
      ),
    );
  }
}
