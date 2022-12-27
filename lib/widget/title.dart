import 'package:flutter/material.dart';

import 'CustomTexts.dart';

class ShowAllTitle extends StatelessWidget {
  final String title;
  final Function() onTap;
  final bool isShowBtn;

  const ShowAllTitle({Key? key,
    required this.title,
    required this.onTap,
    this.isShowBtn = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title, style: TextStyle(fontSize: 16,fontFamily: 'semibold'),),
        if(isShowBtn)
        GestureDetector(
          onTap: onTap,
          child: MainHeadingText(text: 'Show All', fontSize: 12, fontFamily: 'light', textDecoration: TextDecoration.underline),
        )
      ],
    );
  }
}
