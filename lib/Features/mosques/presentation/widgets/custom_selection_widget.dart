import 'package:find_mosques/core/constants/colors/colors.dart';
import 'package:find_mosques/core/constants/styles/text_styles.dart';
import 'package:find_mosques/core/extensions/screen_sizes.dart';
import 'package:flutter/material.dart';

class CustomSelectionWidget extends StatelessWidget {
  final String question;
  final ValueNotifier<bool?> selectedOptionNotifier;
  final String value1;
  final String value2;

  CustomSelectionWidget({
    Key? key,
    required this.question,
    required this.selectedOptionNotifier,
    required this.value1,
    required this.value2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.screenWidht() * 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            question,
            style: defaultTitleTextStyle.copyWith(color: primaryColor),
          ),
          ValueListenableBuilder<bool?>(
            valueListenable: selectedOptionNotifier,
            builder: (context, value, child) {
              return SizedBox(
                width: context.screenWidht() * 0.7,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: [
                        Radio<bool>(
                          value: true,
                          groupValue: value,
                          onChanged: (newValue) {
                            selectedOptionNotifier.value = newValue;
                          },
                        ),
                        Text(
                          value1,
                          style: defaultTextStyle.copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Radio<bool>(
                          value: false,
                          groupValue: value,
                          onChanged: (newValue) {
                            selectedOptionNotifier.value = newValue;
                          },
                        ),
                        Text(
                          value2,
                          style: defaultTextStyle.copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
