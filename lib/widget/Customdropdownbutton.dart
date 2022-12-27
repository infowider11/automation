// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:flutter/material.dart';
// import '../constants/colors.dart';
//
// class CustomDropdownButton<T> extends StatelessWidget {
//   final String text;
//   final bool isLabel;
//   final Color labelColor;
//   final List<T> items;
//   final T? selectedItem;
//   final String hint;
//   final BoxBorder? border;
//   final void Function(T? value)? onChanged;
//   final double margin;
//   final double labelFontSize;
//   final String itemMapKey;
//   final Color fieldColor;
//   final CrossAxisAlignment crossAxisAlignment;
//   const CustomDropdownButton({Key? key,
//     this.margin = 16,
//     this.labelFontSize = 15,
//     required this.text,
//     this.selectedItem,
//     this.labelColor = Colors.black12,
//     required this.items,
//     required this.hint,
//     this.onChanged,
//     this.border,
//     this.isLabel = true,
//     this.itemMapKey = 'title',
//     this.fieldColor=Colors.transparent,
//     this.crossAxisAlignment = CrossAxisAlignment.start
//
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: crossAxisAlignment,
//       children: [
//         if(isLabel)
//           Text(text, style: TextStyle(fontSize: labelFontSize, color: labelColor, fontFamily: 'bold'),),
//         Container(
//           // height: 50,
//           padding:EdgeInsets.only(top:10, bottom:10, left:8) ,
//           margin: EdgeInsets.symmetric(vertical: margin),
//           decoration: BoxDecoration(
//             color: fieldColor,
//             border: Border(
//                 bottom: BorderSide(color: Colors.black12, width: 1)
//             ),
//             // borderRadius: BorderRadius.circular(8)
//           ),
//           // padding: EdgeInsets.only(left: 0, top: 0),
//           child: Stack(
//             children: [
//               DropdownSearch<T>(
//                 popupBackgroundColor: Colors.transparent,
//                 popupElevation: 0,
//                 // dro
//                 dropdownSearchDecoration: InputDecoration.collapsed(
//
//                     hintText: hint,
//                     hintStyle: TextStyle(color: Color(0xFF999999), fontFamily: 'light')
//                 ),
//                 mode: Mode.MENU,
//                 items: items,
//
//                 popupItemBuilder: (context,value,a){
//                   print('the value is ${value.toString()}');
//                   try{
//                     return Container(
//
//                       decoration: BoxDecoration(
//                           color:Colors.white,
//                           border: Border(bottom: BorderSide(color: Colors.black12))
//                       ),
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text((value as Map)['${itemMapKey}']),
//                           // Divider(),
//                         ],
//                       ),
//                     );
//
//                   }catch(e){
//                     print('Error in catch block  5d55 $e');
//                   }
//                   return Container(
//                     decoration: BoxDecoration(
//                         color:Colors.white,
//                         border: Border(bottom: BorderSide(color: Colors.black12))
//                     ),
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Text(value.toString()),
//                         // Divider(),
//                       ],
//                     ),
//                   );
//
//
//                 },
//                 itemAsString: (T? value){
//                   print('this is called');
//                   try{
//                     return (value as Map)['${itemMapKey}'];
//                   }catch(e){
//                     print('Error in catch block  555 $e');
//                   }
//                   return value.toString();
//                 },
//                 selectedItem: selectedItem,
//
//                 onChanged: onChanged,
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }