import 'package:flutter/material.dart';

import '../constants/globalKey.dart';




showSnackbar( String text){
  ScaffoldMessenger.of(MyGlobalKeys.navigatorKey.currentContext!).showSnackBar(
      SnackBar(content: Text(text),
        duration: Duration(milliseconds: 1500),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        behavior: SnackBarBehavior.floating,
      )
  );
}