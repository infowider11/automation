import 'dart:async';
import 'dart:developer';

import 'package:automation/constants/globaldata.dart';
import 'package:automation/home.dart';
import 'package:automation/services/auth.dart';
import 'package:automation/services/getDashboardData.dart';
import 'package:automation/services/webservices.dart';
import 'package:automation/welcome.dart';
import 'package:flutter/material.dart';
import 'constants/colors.dart';
import 'constants/navigation.dart';

class SplashScreen extends StatefulWidget {
  static const id = 'splash_screen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();


  }

  get()async{
    if(await isUserLoggedIn()){
      await check();
    }
    else{
      Future.delayed(Duration(seconds: 3)).then((value){
        push(context: context, screen: WelcomePage());
        // push(context: context, screen: WelcomePage());
      });
    }
  }
  check()async{
    print('await isUserLoggedIn()-------------${await isUserLoggedIn()}');
    if(await isUserLoggedIn()){
      print('user_id-------------${await getCurrentUserId()}');
      Map data={
        'action':{'value':'userdata_by_id'},
        'Account_ID':{'value': '${await getCurrentUserId()}'}
      };
      var res = await Webservices.getData('', data);
      log("res-------------$res");
      await updateUserDetails(res['data']);
      // timer =  Timer.periodic(Duration(minutes: 3), (timer) async{
        await getData();
      // });
      pushAndPopAll(context: context, screen: HomePage());
    }
    else{
      push(context: context, screen: WelcomePage());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.black,
      body: Center(
        child: Image.asset(
          'assets/images/logo.jpg',
          width: MediaQuery.of(context).size.width - 100,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}