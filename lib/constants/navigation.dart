import 'package:flutter/material.dart';
Future push({required  BuildContext context, required Widget screen,})async{
  print('presse kjhn d');
  return Navigator.push(context, MaterialPageRoute(builder: (context){
    return screen;
  }));
}

Future pushReplacement({required  BuildContext context, required Widget screen,})async{
  return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
    return screen;
  }));
}

Future pushAndPopAll({required  BuildContext context, required Widget screen,})async{
  Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(builder: (context){
    return screen;
  }), (route) => false);
}