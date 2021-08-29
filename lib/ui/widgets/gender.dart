import 'package:flutter/material.dart';

Widget genderWidget(icon, text, size, selected, onTap){ 
  return GestureDetector(
    onTap: onTap,
    child: Column( 
      children: <Widget>[
        Icon( 
          icon,
          size: size.height *0.07,
          color: selected == text ? Colors.cyan[800]: Colors.cyan[400],
        ),
        SizedBox(
          height: size.height *0.02,
        ),
        Text( 
          text,
          style: TextStyle( 
            color: selected == text ? Colors.cyan[800]: Colors.cyan[400], fontSize:size.height *0.02, 
          ),
        )
      ],
    ),
  );
}