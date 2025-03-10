import 'package:beamer/beamer.dart';
import 'package:geobase/src/presentation/core/app.dart';

class GeoAppBar extends AppBar {
  GeoAppBar({
    super.key,
    super.leading = const AppBarBackButton(),
    super.title,
    super.actions,
    super.flexibleSpace,
    super.elevation = 4.0,
    super.shape,
    super.iconTheme,
    super.actionsIconTheme,
    super.primary = true,
    super.centerTitle = true,
    super.titleSpacing = NavigationToolbar.kMiddleSpacing,
    super.bottomOpacity = 1.0,
    super.toolbarHeight = kToolbarHeight,
    super.leadingWidth,
    super.toolbarTextStyle,
    super.titleTextStyle,
    super.systemOverlayStyle,
    super.excludeHeaderSemantics = false,
  });
}

class AppBarBackButton extends StatelessWidget {
  const AppBarBackButton({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const BackButtonIcon(),
      color: color ?? Colors.white,
      tooltip: 'Volver',
      onPressed: () => context.beamBack(),
    );
  }
}
