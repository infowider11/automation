import 'package:flutter/material.dart';

import '../constants/colors.dart';
class DrawerLink extends StatelessWidget {
  final String title;
  final Function() func;
  final String img;

  const DrawerLink({Key? key,
    required this.title,
    required this.func,
    required this.img,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ListTile(
      hoverColor: Colors.yellow,
        visualDensity: VisualDensity(vertical: -4),
        leading: Image.asset(img, width: 30, height: 30,),
        minLeadingWidth: 30,
        title: Text(title, style: TextStyle(
        fontSize:16,fontFamily: 'bold',color: MyColors.white),),

    onTap: func,
      contentPadding: EdgeInsets.symmetric(vertical: 5),
    );



    // GestureDetector(
    //   onTap: func,
    //   child: Container(
    //     padding: EdgeInsets.symmetric(vertical: 8, horizontal: 2),
    //     margin: EdgeInsets.only(bottom: 15),
    //     width: context.width,
    //     child: Text(title,style: TextStyle(
    //         fontSize:14,fontFamily: 'regular',color: Color(0xFF1A1C1E)
    //     ),),
    //   ),
    // );
  }
}
