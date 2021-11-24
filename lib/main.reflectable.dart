// This file has been generated by the reflectable package.
// https://github.com/dart-lang/reflectable.
// @dart = 2.12

import 'dart:core';
import 'package:geobase/src/presentation/core/widgets/render_classes/field_render_classes/base_bool_field_render.dart'
    as prefix6;
import 'package:geobase/src/presentation/core/widgets/render_classes/field_render_classes/base_date_field_render.dart'
    as prefix4;
import 'package:geobase/src/presentation/core/widgets/render_classes/field_render_classes/base_datetime_field_render.dart'
    as prefix5;
import 'package:geobase/src/presentation/core/widgets/render_classes/field_render_classes/base_double_field_render.dart'
    as prefix7;
import 'package:geobase/src/presentation/core/widgets/render_classes/field_render_classes/base_int_field_render.dart'
    as prefix10;
import 'package:geobase/src/presentation/core/widgets/render_classes/field_render_classes/base_string_field_render.dart'
    as prefix12;
import 'package:geobase/src/presentation/core/widgets/render_classes/field_render_classes/field_render_class.dart'
    as prefix3;
import 'package:geobase/src/presentation/core/widgets/render_classes/field_render_classes/media_audio_field_render.dart'
    as prefix11;
import 'package:geobase/src/presentation/core/widgets/render_classes/field_render_classes/media_field_render.dart'
    as prefix8;
import 'package:geobase/src/presentation/core/widgets/render_classes/field_render_classes/media_file_field_render.dart'
    as prefix2;
import 'package:geobase/src/presentation/core/widgets/render_classes/field_render_classes/media_image_field_render.dart'
    as prefix1;
import 'package:geobase/src/presentation/core/widgets/render_classes/field_render_classes/staticselection_field_render.dart'
    as prefix9;
import 'package:geobase/src/presentation/core/widgets/render_classes/reflect.dart'
    as prefix0;

// ignore_for_file: prefer_adjacent_string_concatenation
// ignore_for_file: prefer_collection_literals
// ignore_for_file: unnecessary_const
// ignore_for_file: implementation_imports

// ignore:unused_import
import 'package:reflectable/mirrors.dart' as m;
// ignore:unused_import
import 'package:reflectable/src/reflectable_builder_based.dart' as r;
// ignore:unused_import
import 'package:reflectable/reflectable.dart' as r show Reflectable;

final _data = <r.Reflectable, r.ReflectorData>{
  const prefix0.FieldRenderReflectable(): r.ReflectorData(
      <m.TypeMirror>[
        r.NonGenericClassMirrorImpl(
            r'MediaImageFieldRender',
            r'.MediaImageFieldRender',
            7,
            0,
            const prefix0.FieldRenderReflectable(),
            const <int>[-1],
            null,
            null,
            -1,
            {},
            {},
            {r'': (bool b) => () => b ? prefix1.MediaImageFieldRender() : null},
            -1,
            0,
            const <int>[2],
            null,
            {}),
        r.NonGenericClassMirrorImpl(
            r'MediaFileFieldRender',
            r'.MediaFileFieldRender',
            7,
            1,
            const prefix0.FieldRenderReflectable(),
            const <int>[-1],
            null,
            null,
            -1,
            {},
            {},
            {r'': (bool b) => () => b ? prefix2.MediaFileFieldRender() : null},
            -1,
            1,
            const <int>[2],
            null,
            {}),
        r.NonGenericClassMirrorImpl(
            r'IFieldRenderClass',
            r'.IFieldRenderClass',
            519,
            2,
            const prefix0.FieldRenderReflectable(),
            const <int>[-1],
            null,
            null,
            -1,
            {},
            {},
            {},
            -1,
            2,
            const <int>[],
            null,
            {}),
        r.NonGenericClassMirrorImpl(
            r'BaseDateFieldRender',
            r'.BaseDateFieldRender',
            7,
            3,
            const prefix0.FieldRenderReflectable(),
            const <int>[-1],
            null,
            null,
            -1,
            {},
            {},
            {r'': (bool b) => () => b ? prefix4.BaseDateFieldRender() : null},
            -1,
            3,
            const <int>[2],
            null,
            {}),
        r.NonGenericClassMirrorImpl(
            r'BaseDateTimeFieldRender',
            r'.BaseDateTimeFieldRender',
            7,
            4,
            const prefix0.FieldRenderReflectable(),
            const <int>[-1],
            null,
            null,
            -1,
            {},
            {},
            {
              r'': (bool b) =>
                  () => b ? prefix5.BaseDateTimeFieldRender() : null
            },
            -1,
            4,
            const <int>[2],
            null,
            {}),
        r.NonGenericClassMirrorImpl(
            r'BaseBoolFieldRender',
            r'.BaseBoolFieldRender',
            7,
            5,
            const prefix0.FieldRenderReflectable(),
            const <int>[-1],
            null,
            null,
            -1,
            {},
            {},
            {r'': (bool b) => () => b ? prefix6.BaseBoolFieldRender() : null},
            -1,
            5,
            const <int>[2],
            null,
            {}),
        r.NonGenericClassMirrorImpl(
            r'BaseDoubleFieldRender',
            r'.BaseDoubleFieldRender',
            7,
            6,
            const prefix0.FieldRenderReflectable(),
            const <int>[-1],
            null,
            null,
            -1,
            {},
            {},
            {r'': (bool b) => () => b ? prefix7.BaseDoubleFieldRender() : null},
            -1,
            6,
            const <int>[2],
            null,
            {}),
        r.NonGenericClassMirrorImpl(
            r'MediaFieldRender',
            r'.MediaFieldRender',
            7,
            7,
            const prefix0.FieldRenderReflectable(),
            const <int>[-1],
            null,
            null,
            -1,
            {},
            {},
            {r'': (bool b) => () => b ? prefix8.MediaFieldRender() : null},
            -1,
            7,
            const <int>[2],
            null,
            {}),
        r.NonGenericClassMirrorImpl(
            r'StaticSelectionFieldRender',
            r'.StaticSelectionFieldRender',
            7,
            8,
            const prefix0.FieldRenderReflectable(),
            const <int>[-1],
            null,
            null,
            -1,
            {},
            {},
            {
              r'': (bool b) =>
                  () => b ? prefix9.StaticSelectionFieldRender() : null
            },
            -1,
            8,
            const <int>[2],
            null,
            {}),
        r.NonGenericClassMirrorImpl(
            r'BaseIntFieldRender',
            r'.BaseIntFieldRender',
            7,
            9,
            const prefix0.FieldRenderReflectable(),
            const <int>[-1],
            null,
            null,
            -1,
            {},
            {},
            {r'': (bool b) => () => b ? prefix10.BaseIntFieldRender() : null},
            -1,
            9,
            const <int>[2],
            null,
            {}),
        r.NonGenericClassMirrorImpl(
            r'MediaAudioFieldRender',
            r'.MediaAudioFieldRender',
            7,
            10,
            const prefix0.FieldRenderReflectable(),
            const <int>[-1],
            null,
            null,
            -1,
            {},
            {},
            {
              r'': (bool b) => () => b ? prefix11.MediaAudioFieldRender() : null
            },
            -1,
            10,
            const <int>[2],
            null,
            {}),
        r.NonGenericClassMirrorImpl(
            r'BaseStringFieldRender',
            r'.BaseStringFieldRender',
            7,
            11,
            const prefix0.FieldRenderReflectable(),
            const <int>[-1],
            null,
            null,
            -1,
            {},
            {},
            {
              r'': (bool b) => () => b ? prefix12.BaseStringFieldRender() : null
            },
            -1,
            11,
            const <int>[2],
            null,
            {})
      ],
      null,
      null,
      <Type>[
        prefix1.MediaImageFieldRender,
        prefix2.MediaFileFieldRender,
        prefix3.IFieldRenderClass,
        prefix4.BaseDateFieldRender,
        prefix5.BaseDateTimeFieldRender,
        prefix6.BaseBoolFieldRender,
        prefix7.BaseDoubleFieldRender,
        prefix8.MediaFieldRender,
        prefix9.StaticSelectionFieldRender,
        prefix10.BaseIntFieldRender,
        prefix11.MediaAudioFieldRender,
        prefix12.BaseStringFieldRender
      ],
      12,
      {},
      {},
      null,
      [
        const [0, 0, null]
      ])
};

final _memberSymbolMap = null;

void initializeReflectable() {
  r.data = _data;
  r.memberSymbolMap = _memberSymbolMap;
}
