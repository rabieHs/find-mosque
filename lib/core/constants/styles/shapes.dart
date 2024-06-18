import 'package:flutter/material.dart';

customRoundedShape(double radius) =>
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius));
BorderRadius customBorderRadius({double radious = 15}) =>
    BorderRadius.circular(radious);
