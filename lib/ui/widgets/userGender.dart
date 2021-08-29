import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget userGender(gender) {
  switch (gender) {
    case '9th':
      return Icon(
        FontAwesomeIcons.checkCircle,
        color: Colors.cyan[300],
      );
      break;
    case '10th':
      return Icon(
        FontAwesomeIcons.checkCircle,
        color: Colors.cyan[300],
      );
      break;
    case '11th':
      return Icon(
        FontAwesomeIcons.checkCircle,
        color: Colors.cyan[300],
      );
      break;
    case '12th':
      return Icon(
        FontAwesomeIcons.checkCircle,
        color: Colors.cyan[300],
      );
      break;
    default:
      return null;
      break;
  }
}