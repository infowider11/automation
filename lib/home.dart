import 'dart:async';
import 'dart:developer';

import 'package:automation/constants/globaldata.dart';
import 'package:automation/graph.dart';
import 'package:automation/services/auth.dart';
import 'package:automation/services/getDashboardData.dart';
import 'package:automation/services/webservices.dart';
import 'package:automation/widget/CustomTexts.dart';
import 'package:automation/widget/appbar.dart';
import 'package:automation/widget/customLoader.dart';
import 'package:automation/widget/home-widget.dart';
import 'package:flutter/material.dart';

import 'constants/colors.dart';
import 'constants/navigation.dart';
import 'constants/sized_box.dart';
import 'detail-page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  Timer? timer;
  // List<dynamic> data=[];
  // Map res={};
  // bool load=false;
  // String Total_Power='';
  // String Total_Export='';
  // String WTG_Run='';
  // String Mysql_Record_Count='';
  // String location='';
  // // "Total_Power": 1.0999999999999999,
  // // "Total_Export": 357,
  // // "WTG_Run": 10,
  // // "Mysql_Record_Count": 10,
  // getData()async{
  //   Map data={
  //     'action':{'value':'get_list'},
  //     'Account_ID':{'value': '${await getCurrentUserId()}'}
  //   };
  //   setState(() {
  //     load=true;
  //   });
  //   res = await Webservices.getData('', data);
  //   setState(() {
  //     load=false;
  //   });
  //   log("res---------getlist----${res}");
  //   log("res---------getlist----${res['data'].length}");
  //   Total_Export=res['Total_Export'].toString();
  //   location=res['CurrentState'].toString();
  //   WTG_Run=res['WTG_Run'].toString();
  //   Mysql_Record_Count=res['Mysql_Record_Count'].toString();
  //   // data=res['data'];
  //   Total_Power=(res['Total_Power'].round()).toString();
  //   print('length----------------${Total_Power}');
  //
  //   setState(() {
  //
  //   });
  //
  // }
  @override
  void initState() {
    // TODO: implement initState
    timer =  Timer.periodic(Duration(minutes: 3), (timer) async{
      await getData();
      setState(() {

      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      key: scaffoldKey,
      drawer: DrawerWidget(),
      appBar: appBar(context: context, appBarType: AppBarType.main,  scaffoldKey: scaffoldKey,location: '${location}'),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MainHeadingText(text: 'Welcome \n ${user_data!['Firstname']??""} !!!', fontFamily: 'bold', fontSize: 22, color: MyColors.white,),
            vSizedBox4,
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                    decoration: BoxDecoration(
                      color: MyColors.white,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/home-icon.png', width: 12,),
                            hSizedBox05,
                            MainHeadingText(text: 'Total Power', fontSize: 14, color: MyColors.primaryColor.withOpacity(0.5),),
                          ],
                        ),
                        Divider(
                          color: MyColors.black,
                          thickness: 1,
                        ),
                        MainHeadingText(text: '${Total_Power} Kw', fontSize: 16, fontFamily: 'bold',)
                      ],
                    ),
                  ),
                ),
                hSizedBox,
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                    decoration: BoxDecoration(
                        color: MyColors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/icon-2.png', width: 12,),
                            hSizedBox05,
                            MainHeadingText(text: 'Total Export', fontSize: 14, color: MyColors.primaryColor.withOpacity(0.5),),
                          ],
                        ),
                        Divider(
                          color: MyColors.black,
                          thickness: 1,
                        ),
                        MainHeadingText(text: '${Total_Export}  kwh', fontSize: 16, fontFamily: 'bold',)
                      ],
                    ),
                  ),
                ),
                hSizedBox,
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                    decoration: BoxDecoration(
                        color: MyColors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/icon-3.png', width: 12,),
                            hSizedBox05,
                            MainHeadingText(text: 'WTG Run', fontSize: 14, color: MyColors.primaryColor.withOpacity(0.5),),
                          ],
                        ),
                        Divider(
                          color: MyColors.black,
                          thickness: 1,
                        ),
                        MainHeadingText(text: '${WTG_Run}/${Mysql_Record_Count}', fontSize: 16, fontFamily: 'bold',)
                      ],
                    ),
                  ),
                ),
              ],
            ),
            vSizedBox4,
            for(var i=0; i<res['data'].length; i++) ...[
              GestureDetector(
                  onTap:( () =>
                  // push(context: context, screen: GraphPage())),
                  push(context: context, screen: DetailPage(speed: res['data'][i]['WindSpeed'],power: res['data'][i]['PV_Instant_Power'],data:res['data'][i]))),
                  // onTap:()async{
                  //   showDialog(
                  //     context: context,
                  //     builder: (BuildContext context) {
                  //       return AlertDialog(
                  //         title: Text(""),
                  //         content: Text("coming soon..."),
                  //         actions: [
                  //       TextButton(
                  //       child: Text("OK"),
                  //       onPressed: () {
                  //       Navigator.of(context).pop();
                  //       },
                  //       ),
                  //         ],
                  //       );
                  //     },
                  //   );
                  // },
                  child: HomeWidget(data:res['data'][i],)),
              vSizedBox2
            ]
          ],
        ),
      ),
    );
  }
}
