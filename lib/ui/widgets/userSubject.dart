import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget userSubject(subject) {
  switch (subject) {
    case 'math':
      return Icon(
        FontAwesomeIcons.divide,
        color: Colors.cyan[300],
      );
      break;
    case 'science':
      return Icon(
        FontAwesomeIcons.flask,
        color: Colors.cyan[300],
      );
      break;
    case 'english':
      return Icon(
        FontAwesomeIcons.book,
        color: Colors.cyan[300],
      );
      break;
    case 'history':
      return Icon(
        FontAwesomeIcons.globe,
        color: Colors.cyan[300],
      );
      break;
    default:
      return null;
      break;
  }
}