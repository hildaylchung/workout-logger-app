// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:go_router/go_router.dart';

Future<void> showConfirmDialog(BuildContext context, Function confirmFn) async {
  return await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => ConfirmDialog(
      confirm: () {
        confirmFn();
        context.pop();
      },
    ),
  );
}

class ConfirmDialog extends Dialog {
  final Function confirm;

  const ConfirmDialog({super.key, required this.confirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(title: const Text("Do you confirm deleting?"), actions: [
      TextButton(
        onPressed: () {
          confirm();
        },
        child: const Text("Confirm"),
      ),
      TextButton(
        onPressed: () {
          context.pop();
        },
        child: const Text("Cancel"),
      ),
    ]);
  }
}
