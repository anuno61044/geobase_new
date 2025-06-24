// imported_geodata_storage_service.dart
import 'dart:convert';

import 'package:geobase/injection.dart';
import 'package:geobase/src/domain/entities/imported_geodata_point.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IImportedGeodataStorageService {
  Future<void> saveImportedPoints(List<ImportedGeodataPoint> points);
  Future<List<ImportedGeodataPoint>> loadImportedPoints();
  Future<void> clearImportedPoints();
}

@Injectable(as: IImportedGeodataStorageService)
class ImportedGeodataStorageService implements IImportedGeodataStorageService {

  ImportedGeodataStorageService(this._prefs);
  final SharedPreferences _prefs;

  @override
  Future<void> saveImportedPoints(List<ImportedGeodataPoint> points) async {
    final jsonList = points.map((point) => point.toMap()).toList();
    await _prefs.setString('imported_geodata_points', json.encode(jsonList));
  }

  @override
  Future<List<ImportedGeodataPoint>> loadImportedPoints() async {
    final jsonString = _prefs.getString('imported_geodata_points');
    if (jsonString == null) return [];
    
    final jsonList = json.decode(jsonString) as List;
    return jsonList.map((item) => 
      ImportedGeodataPoint.fromJson(item as Map<String, dynamic>)
    ).toList();
  }

  @override
  Future<void> clearImportedPoints() async {
    await _prefs.remove('imported_geodata_points');
  }
}