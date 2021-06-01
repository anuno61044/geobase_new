import 'package:flutter/material.dart';
import 'package:map/map.dart';
import 'package:latlng/latlng.dart';

class GeoBaseMap extends StatefulWidget {
  @override
  _GeoBaseMapState createState() => _GeoBaseMapState();
}

class _GeoBaseMapState extends State<GeoBaseMap> {
  final controller = MapController(
    location: LatLng(35.68, 51.41),
  );

  final markers = [
    LatLng(35.674, 51.41),
    LatLng(35.676, 51.41),
    LatLng(35.678, 51.41),
    LatLng(35.68, 51.41),
    LatLng(35.682, 51.41),
    LatLng(35.684, 51.41),
    LatLng(35.686, 51.41),
  ];

  void _gotoDefault() {
    controller.center = LatLng(35.68, 51.41);
    setState(() {});
  }

  void _onDoubleTap() {
    controller.zoom += 0.5;
    setState(() {});
  }

  Offset? _dragStart;
  double _scaleStart = 1.0;
  void _onScaleStart(ScaleStartDetails details) {
    _dragStart = details.focalPoint;
    _scaleStart = 1.0;
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    final scaleDiff = details.scale - _scaleStart;
    _scaleStart = details.scale;

    if (scaleDiff > 0) {
      controller.zoom += 0.02;
      setState(() {});
    } else if (scaleDiff < 0) {
      controller.zoom -= 0.02;
      setState(() {});
    } else {
      final now = details.focalPoint;
      final diff = now - _dragStart!;
      _dragStart = now;
      controller.drag(diff.dx, diff.dy);
      setState(() {});
    }
  }

  Widget _buildMarkerWidget(Offset pos, Color color) {
    return Positioned(
      left: pos.dx - 16,
      top: pos.dy - 16,
      width: 24,
      height: 24,
      child: Icon(Icons.location_on, color: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MapLayoutBuilder(
          controller: controller,
          builder: (context, transformer) {
            final markerPositions =
                markers.map(transformer.fromLatLngToXYCoords).toList();

            final markerWidgets = markerPositions.map(
              (pos) => _buildMarkerWidget(pos, Colors.red),
            );

            final homeLocation =
                transformer.fromLatLngToXYCoords(LatLng(35.68, 51.412));

            final homeMarkerWidget =
                _buildMarkerWidget(homeLocation, Colors.black);

            final centerLocation = Offset(
                transformer.constraints.biggest.width / 2,
                transformer.constraints.biggest.height / 2);

            final centerMarkerWidget =
                _buildMarkerWidget(centerLocation, Colors.purple);

            return GestureDetector(
              onDoubleTap: _onDoubleTap,
              onScaleStart: _onScaleStart,
              onScaleUpdate: _onScaleUpdate,
              onTapUp: (details) {
                final location =
                    transformer.fromXYCoordsToLatLng(details.localPosition);

                final clicked = transformer.fromLatLngToXYCoords(location);

                print('${location.longitude}, ${location.latitude}');
                print('${clicked.dx}, ${clicked.dy}');
                print(
                    '${details.localPosition.dx}, ${details.localPosition.dy}');
              },
              child: Stack(
                children: [
                  Map(
                    controller: controller,
                    builder: (context, x, y, z) {
                      //Legal notice: This url is only used for demo and educational purposes. You need a license key for production use.

                      //Google Maps
                      final url =
                          'https://www.google.com/maps/vt/pb=!1m4!1m3!1i$z!2i$x!3i$y!2m3!1e0!2sm!3i420120488!3m7!2sen!5e1105!12m4!1e68!2m2!1sset!2sRoadmap!4e0!5m1!1e0!23i4111425';

                      //ArcGis
                      final _url =
                          'https://gisserver:6443/arcgis/services/IdahoImages/ImageServer/WMSServer?';

                      //Mapbox Streets
                      // final url =
                      //     'https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/$z/$x/$y?access_token=YOUR_MAPBOX_ACCESS_TOKEN';

                      return Image.network(
                        url,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                  homeMarkerWidget,
                  ...markerWidgets,
                  centerMarkerWidget,
                ],
              ),
            );
          },
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: FloatingActionButton(
            onPressed: _gotoDefault,
            tooltip: 'My Location',
            child: const Icon(Icons.my_location),
          ),
        ),
      ],
    );
  }
}
