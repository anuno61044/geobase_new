import 'package:beamer/beamer.dart';
import 'package:geobase/src/presentation/core/app.dart';
import 'package:geobase/src/presentation/core/widgets/buttons/main_button_widget.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({
    super.key,
    required this.wrongUrl,
  });

  final String wrongUrl;

  static BeamPage getPage(BuildContext context, String url) {
    return BeamPage(
      key: const ValueKey('404'),
      title: 'Destino No Encontrado',
      child: NotFoundPage(
        wrongUrl: url,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.beamToNamed('/map');
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    wrongUrl,
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 50),
                  const Text(
                    'Página No Encontrada',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  MainButton(
                    onPressed: () {
                      context.beamToNamed('/map');
                    },
                    text: 'Regresar',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
