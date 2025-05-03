import 'package:flutter/material.dart';

import 'ColorPalate.dart';

void showCustomSnackBar(BuildContext context,String content)
{
  final snackBar = SnackBar(
    backgroundColor: snackBarColor,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)
    ),
    content: Text(content,textAlign: TextAlign.center,style: TextStyle(
      color: Colors.white,fontFamily: 'Cagody',fontSize: 20),),
    duration: Duration(milliseconds: 800),
    behavior: SnackBarBehavior.floating,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

