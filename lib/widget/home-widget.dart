import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/sized_box.dart';
import 'CustomTexts.dart';

class HomeWidget extends StatelessWidget {
  final Map data;
  const HomeWidget({Key? key,required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MainHeadingText(text: '${data['CurrentSite']}', color: MyColors.white, fontSize: 16, fontFamily: 'bold',),
            MainHeadingText(text: '${data['Connect_Feeder']}', color: MyColors.white, fontSize: 12, fontFamily: 'bold',),
          ],
        ),
        Container(
          decoration: BoxDecoration(
              color: MyColors.white,
              borderRadius: BorderRadius.circular(10)
          ),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Row(
                            children: [
                              Image.asset('assets/images/box-icon-3.png', width: 35,),
                              hSizedBox05,
                              MainHeadingText(text: '${data['Date']}', color: MyColors.black, fontSize: 12, fontFamily: 'medium',),
                            ],
                          ),
                        ),

                        Expanded(
                          flex: 7,
                          child: Row(
                            children: [
                              Image.asset('assets/images/box-icon-2.png', width: 35,),
                              hSizedBox05,
                              MainHeadingText(text: 'Speed: ', color: MyColors.secondarycolor, fontSize: 12, fontFamily: 'medium',),
                              MainHeadingText(text: '${data['WindSpeed']} m/s', color: MyColors.black, fontSize: 12, fontFamily: 'medium',),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Row(
                            children: [
                              Image.asset('assets/images/box-icon-1.png', width: 35,),
                              hSizedBox05,
                              MainHeadingText(text: '${data['Time']}', color: MyColors.black, fontSize: 12, fontFamily: 'medium',),
                            ],
                          ),
                        ),

                        Expanded(
                          flex: 7,
                          child: Row(
                            children: [
                              Image.asset('assets/images/box-icon-4.png', width: 35,),
                              hSizedBox05,
                              MainHeadingText(text: 'Power: ', color: MyColors.secondarycolor, fontSize: 12, fontFamily: 'medium',),
                              MainHeadingText(text: '${data['Power']} KW', color: MyColors.black, fontSize: 12, fontFamily: 'medium',),
                            ],
                          ),
                        ),
                      ],
                    ),
                    vSizedBox,
                    MainHeadingText(text: 'HTSC No: ${data['HTSCno']}', fontSize: 14, fontFamily: 'bold',),
                    MainHeadingText(text: 'Name: ${data['Device_Name']}', fontSize: 14, fontFamily: 'bold',),
                    MainHeadingText(text: 'Gen.Daily: ${data['G1']} kwh/${data['G2']}h/${data['GD_Hours']}h', fontSize: 14, fontFamily: 'bold',),

                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Image.network('${data['Tower_Img']}')
                // Image.asset('assets/images/windmill.png',),
              )
            ],
          ),
        )
      ],
    );
  }
}
