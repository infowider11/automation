import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' as cupertino;
import '../constants/colors.dart';
class CustomLoader extends StatelessWidget {
  final Color? color;
  final double? radius;
  const CustomLoader({Key? key, this.color,this.radius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Center(
    //   child: CircularProgressIndicator(
    //     color:color?? MyColors.primaryColor,
    //   ),
    // );
    return Center(
      child: CircularProgressIndicator(

        // strokeWidth:1 ,
        color:color?? MyColors.white,
        // radius:radius?? 24,
      )
    );
    // return cupertino.CupertinoActivityIndicator
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart' as cupertino;
// import '../constants/colors.dart';
// class CustomLoader extends StatelessWidget {
//   final Color? color;
//   final double? radius;
//   CustomLoader({Key? key, this.color,this.radius}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     // return Center(
//     //   child: CircularProgressIndicator(
//     //     color:color?? MyColors.primaryColor,
//     //   ),
//     // );
//     return Center(
//         child: cupertino.CupertinoActivityIndicator(
//           color:color?? MyColors.primaryColor,
//           radius:radius?? 24,
//         )
//     );
//     // return cupertino.CupertinoActivityIndicator
//   }
// }
