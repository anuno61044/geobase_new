import 'package:flutter_lyform/flutter_lyform.dart';
import 'package:geobase/src/domain/entities/entities.dart';
import 'package:geobase/src/infrastructure/providers/sqlite/db_model.dart';
import 'package:geobase/src/presentation/core/extensions/reflectable_extensions.dart';
import 'package:geobase/src/presentation/core/utils/utils.dart';
import 'package:reflectable/reflectable.dart';

class FieldInputBlocReflectable extends Reflectable {
  const FieldInputBlocReflectable()
      : super(
          typeCapability,
          staticInvokeCapability,
        );
}

const fieldInputBlocReflectable = FieldInputBlocReflectable();

InputBloc<dynamic> getBlocByFieldValue(FieldValueGetEntity fieldValue) {
  try {
    final mirrorInstantiator = fieldInputBlocReflectable
        .reflectType(InputBlocInstantiator) as ClassMirror;
    final methodMirror =
        fieldInputBlocReflectable.getStaticMethodByNameStructure(
      mirrorInstantiator,
      prefix: 'getInputBloc',
      aditionalCondition: (mm) {
        if (fieldValue.column.type.metaType == BaseMetaTypeName) {
          return mm.simpleName.endsWith(fieldValue.column.type.name);
        }
        return mm.simpleName.endsWith(fieldValue.column.type.metaType);
      },
    );
    if (methodMirror == null) throw UnimplementedError();
    final inputBloc =
        mirrorInstantiator.invoke(methodMirror.simpleName, [fieldValue]);
    return inputBloc! as InputBloc;
  } catch (e) {
    return InputBloc(
      pureValue: null,
    );
  }
}

@fieldInputBlocReflectable
class InputBlocInstantiator {
  static InputBloc getInputBlocBool(FieldValueGetEntity fieldValue) {
    return InputBloc<FieldValueEntity>(
      pureValue: fieldValue,
    );
  }

  static InputBloc getInputBlocInt(FieldValueGetEntity fieldValue) {
    return InputBloc<FieldValueEntity>(
      pureValue: fieldValue,
      validationType: ValidationType.explicit,
      validator: ListValidator([
        FieldValueValidator.from(StringValidator.required),
        FieldValueValidator.from(StringValidator.number),
      ]),
    );
  }

  static InputBloc getInputBlocDouble(FieldValueGetEntity fieldValue) {
    return InputBloc<FieldValueEntity>(
      pureValue: fieldValue,
      validationType: ValidationType.explicit,
      validator: ListValidator([
        FieldValueValidator.from(StringValidator.required),
        FieldValueValidator.from(StringValidator.number),
      ]),
    );
  }

  static InputBloc getInputBlocString(FieldValueGetEntity fieldValue) {
    return InputBloc<FieldValueEntity>(
      pureValue: fieldValue,
    );
  }

  static InputBloc getInputBlocDate(FieldValueGetEntity fieldValue) {
    return InputBloc<FieldValueEntity>(
      pureValue: fieldValue,
      validationType: ValidationType.explicit,
      validator: ListValidator([
        FieldValueValidator.from(StringValidator.required),
      ]),
    );
  }

  static InputBloc getInputBlocDateTime(FieldValueGetEntity fieldValue) {
    return InputBloc<FieldValueEntity>(
      pureValue: fieldValue,
      validationType: ValidationType.explicit,
      validator: ListValidator([
        FieldValueValidator.from(StringValidator.required),
      ]),
    );
  }

  static InputBloc getInputBlocMedia(FieldValueGetEntity fieldValue) {
    //TODO: ADAPT TO BE A REAL MEDIA FILE
    return InputBloc<FieldValueEntity>(
      pureValue: fieldValue,
      validationType: ValidationType.explicit,
      validator: ListValidator([
        FieldValueValidator.from(StringValidator.required),
      ]),
    );
  }

  static InputBloc getInputBlocStaticSelection(FieldValueGetEntity fieldValue) {
    return InputBloc<FieldValueEntity>(
      pureValue: fieldValue,
      validationType: ValidationType.explicit,
      validator: ListValidator([
        FieldValueValidator.from(StringValidator.required),
      ]),
    );
  }
}
