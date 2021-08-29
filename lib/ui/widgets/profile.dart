import 'package:Study_Buddy/ui/widgets/photo.dart';
import 'package:flutter/material.dart';

Widget profileWidget(
    {padding,
    photoHeight,
    photoWidth,
    clipRadius,
    photo,
    containerHeight,
    containerWidth,
    child}) {
  return Padding(
    padding: EdgeInsets.all(padding),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(clipRadius),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            width: photoWidth,
            height: photoHeight,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(clipRadius),
              child: PhotoWidget(
                photoLink: photo,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(clipRadius),
                  bottomRight: Radius.circular(clipRadius),
                )),
            width: containerWidth,
            height: containerHeight,
            child: child,
          )
        ],
      ),
    ),
  );
}