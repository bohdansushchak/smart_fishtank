import 'package:flutter/material.dart';
import 'package:smart_fishtank/core/repositories/failure.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({
    super.key,
    required this.failure,
  });

  final Failure failure;

  static Future<void> show(BuildContext context, Failure failure) {
    return showDialog(
      context: context,
      builder: (_) => ErrorDialog(failure: failure),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Błąd ${failure.runtimeType}'),
          Text(failure.message ?? 'Wystąpił nieoczekiwany błąd'),
        ],
      ),
    );
  }
}
