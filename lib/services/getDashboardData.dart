
import 'dart:async';
import 'dart:developer';

import 'package:automation/services/auth.dart';
import 'package:automation/services/webservices.dart';

List<dynamic> data=[];
Map res={};
bool load=false;
String Total_Power='';
String Total_Export='';
String WTG_Run='';
String Mysql_Record_Count='';
// String Mysql_Record_Count1='';
String location='';

getData()async{



    Map data = {
      'action': {'value': 'get_list'},
      'Account_ID': {'value': '${await getCurrentUserId()}'}
    };

    res = await Webservices.getData('', data);

    log("res---------getlist----${res}");
    log("res---------getlist----${res['data']}");
    Total_Export = res['Total_Export'].toString();
    location = res['CurrentState'].toString();
    WTG_Run = res['WTG_Run'].toString();
    Mysql_Record_Count = res['Mysql_Record_Count'].toString();
    // data=res['data'];
    Total_Power = (res['Total_Power'].round()).toString();
    print('length----------------${Total_Power}');


}