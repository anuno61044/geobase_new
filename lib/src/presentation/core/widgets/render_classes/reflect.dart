import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_lyform/flutter_lyform.dart';
import 'package:geobase/injection.dart';
import 'package:geobase/main.dart';
import 'package:geobase/src/domain/entities/entities.dart';
import 'package:geobase/src/presentation/core/extensions/reflectable_extensions.dart';
import 'package:geobase/src/presentation/core/widgets/commons/not_implemented_list_tile_widget.dart';
import 'package:geobase/src/presentation/core/widgets/render_classes/field_render_classes/field_render_class.dart';
import 'package:reflectable/reflectable.dart';

class FieldRenderReflectable extends Reflectable {
  const FieldRenderReflectable()
      : super(
          typeCapability,
          typeRelationsCapability,
          newInstanceCapability,
        );
}

const fieldRenderReflectable = FieldRenderReflectable();

@LazySingleton()
class FieldRenderResolver {
  static bool isInitialized = false;
  static void initializResolver() {
    // reflectable
    // initializateReflectable(); //TODO: THIS SHIT IS FUCKING IMPORTANT
    isInitialized = true;
  }

  /// Unsave internal
  static IFieldRenderClass _getInstance(String renderClassName) {
    final interfaceImplemented =
        fieldRenderReflectable.reflectType(IFieldRenderClass) as ClassMirror;
    final classMirror = fieldRenderReflectable.getClassMirrorWhere(
      exactName: renderClassName,
      aditionalCondition: (cm) {
        return cm.superclass?.isSubtypeOf(interfaceImplemented) ?? false;
      },
    );
    if (classMirror == null) throw UnimplementedError();
    final instance = classMirror.newInstance('', []);
    return instance as IFieldRenderClass;
  }

  static InputBloc<FieldValueEntity>? getInputBloc(
    ColumnGetEntity column,
    FieldValueEntity fieldValue,
  ) {
    if (!isInitialized) initializResolver();
    try {
      final instance = _getInstance(column.type.renderClass);
      final inputBloc = instance.getInputBloc(fieldValue);
      return inputBloc;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Widget getInputWidget(
    ColumnGetEntity column,
    InputBloc<FieldValueEntity> inputBloc,
  ) {
    if (!isInitialized) initializResolver();
    try {
      final instance = _getInstance(column.type.renderClass);
      final inputWidget = instance.getInputWidget(column, inputBloc);
      return inputWidget;
    } catch (e) {
      log(e.toString());
      return NotImplementedListTile(column: column);
    }
  }

  static Widget getViewWidget(
    FieldValueGetEntity fieldValue,
  ) {
    if (!isInitialized) initializResolver();
    try {
      final instance = _getInstance(fieldValue.column.type.renderClass);
      final inputWidget = instance.getViewWidget(fieldValue);
      return inputWidget;
    } catch (e) {
      log(e.toString());
      return NotImplementedListTile(column: fieldValue.column);
    }
  }
}
