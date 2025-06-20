import 'dart:developer';

import 'package:flutter_lyform/flutter_lyform.dart';
import 'package:geobase/src/domain/entities/entities.dart';
import 'package:geobase/src/presentation/core/app.dart';
import 'package:geobase/src/presentation/core/utils/utils.dart';
import 'package:geobase/src/presentation/core/widgets/widgets.dart';

class DateTimeFieldInputWidget extends FieldInputWidget {
  const DateTimeFieldInputWidget({
    super.key,
    required super.column,
    required super.inputBloc,
    this.onChanged,
  });

  final void Function(Object?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return LyInputBuilder<FieldValueEntity>(
      lyInput: inputBloc,
      builder: (context, state) {
        return GestureDetector(
          onTap: () async {
            final initialValue = DateTime.tryParse(
              state.value.value?.toString().split('.')[0] ?? '',
            );
            final resultDate = await showDatePicker(
              context: context,
              helpText: 'Seleccione una Fecha',
              cancelText: 'Cancelar',
              confirmText: 'Aceptar',
              fieldLabelText: 'Fecha',
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(DateTime.now().year + 100),
              currentDate: DateTime.tryParse(
                state.value.value?.toString().split('.')[0] ?? '',
              ),
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.light(
                      primary: Theme.of(context)
                          .primaryColor, // header background color
                      onPrimary: Theme.of(context)
                          .colorScheme
                          .background, // header text color
                      onSurface: Theme.of(context).textTheme.bodyLarge?.color ??
                          Colors.black, // body text color
                      background: Theme.of(context).colorScheme.background,
                    ),
                  ),
                  child: child ?? const SizedBox(),
                );
              },
            );
            if (resultDate != null) {
              final resultTime = await showTimePicker(
                context: context,
                helpText: 'Seleccione una hora',
                cancelText: 'Cancelar',
                confirmText: 'Aceptar',
                hourLabelText: 'Hora',
                minuteLabelText: 'Minutos',
                initialTime: initialValue != null
                    ? TimeOfDay(
                        hour: initialValue.hour,
                        minute: initialValue.minute,
                      )
                    : TimeOfDay.now(),
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: ColorScheme.light(
                        primary: Theme.of(context)
                            .primaryColor, // header background color
                        onPrimary: Theme.of(context)
                            .colorScheme
                            .background, // header text color
                        onSurface:
                            Theme.of(context).textTheme.bodyLarge?.color ??
                                Colors.black, // body text color
                        background: Theme.of(context).colorScheme.background,
                      ),
                    ),
                    child: child ?? const SizedBox(),
                  );
                },
              );
              if (resultTime != null) {
                final String datetime = DateTime(
                      resultDate.year,
                      resultDate.month,
                      resultDate.day,
                      resultTime.hour,
                      resultTime.minute,
                    ).toString().split('.')[0];
                inputBloc.dirty(
                  state.value.copyWithValue(
                    datetime,
                  ),
                );
                onChanged?.call(datetime);
              }
            }
          },
          child: AbsorbPointer(
            child: TextInputWidget(
              key: key,
              labelText: column.name,
              onChanged: (newValue) {
                FocusScope.of(context).unfocus();
              },
              controller: TextEditingCustom.fromValue(
                state.value.value?.toString().split('.')[0] ?? '',
              ),
              errorText: state.error,
            ),
          ),
        );
      },
    );
  }
}
