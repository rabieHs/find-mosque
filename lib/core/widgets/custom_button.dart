import 'package:find_mosques/core/constants/styles/shapes.dart';
import 'package:flutter/material.dart';

import '../constants/colors/colors.dart';
import '../constants/styles/text_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  final String title;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: secondaryColor,
        shape: customRoundedShape(15),
      ),
      child: SizedBox(
        width: 100,
        child: Center(
          child: Text(
            title,
            style: defaultTitleTextStyle.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
