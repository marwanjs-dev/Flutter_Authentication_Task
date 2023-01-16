import 'package:flutter/material.dart';

import 'generic_error_dialog.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog<void>(
    context: context,
    title: "an error has occurred",
    content: text,
    optionsBuilder: () => {
      "ok": null,
    },
  );
}
