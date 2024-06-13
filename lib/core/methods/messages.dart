import 'package:find_mosques/core/constants/styles/paddings.dart';
import 'package:find_mosques/core/constants/styles/shapes.dart';
import 'package:flutter/material.dart';

showSuccessMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating,
      margin: defaultPadding,
      shape: customRoundedShape(15),
    ),
  );
}

showErrorMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: defaultPadding,
      shape: customRoundedShape(15),
      content: Text(message),
      backgroundColor: Colors.red,
    ),
  );
}
