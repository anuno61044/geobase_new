import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:geobase/src/domain/entities/entities.dart';


class ImportedGeodataMarker implements IMarkable {

  ImportedGeodataMarker(this.point);

  final ImportedGeodataPoint point;

  @override
  int? get id => point.id;

  @override
  LatLng get location => LatLng(point.lat, point.lng);

  @override
  String? get icon => '{"pack":"material","key":"location_on"}'; // Icono por defecto

  @override
  int? get color => Colors.red.value; // Color rojo para puntos importados

  int get categoryId => point.categoryId;
}