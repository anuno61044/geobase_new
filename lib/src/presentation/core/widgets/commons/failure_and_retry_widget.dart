import 'package:flutter/material.dart';
import 'package:geobase/src/presentation/core/widgets/widgets.dart';

class FailureAndRetryWidget extends StatelessWidget {
  const FailureAndRetryWidget({
    super.key,
    required this.errorText,
    required this.onPressed,
  });

  final String errorText;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Ha ocurrido un error :'("),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              errorText,
              maxLines: 8,
            ),
          ),
          const SizedBox(height: 16),
          MainButton(
            text: 'Reintentar',
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
