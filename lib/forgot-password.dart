import 'package:automation/constants/globaldata.dart';
import 'package:automation/services/webservices.dart';
import 'package:automation/widget/CustomTexts.dart';
import 'package:automation/widget/appbar.dart';
import 'package:automation/widget/buttons.dart';
import 'package:automation/widget/customLoader.dart';
import 'package:automation/widget/customtextfield.dart';
import 'package:automation/widget/snakeBar.dart';
import 'package:flutter/material.dart';

import 'change-password.dart';
import 'constants/colors.dart';
import 'constants/navigation.dart';
import 'constants/sized_box.dart';
import 'functions/validations.dart';
import 'package:flutter/cupertino.dart' as cupertino;

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController email = TextEditingController();
  bool load=false;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    // email.text=user_data!['E_Mail'];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      appBar: appBar(context: context, title: 'Forgot password', appBarType: AppBarType.sub, scaffoldKey: scaffoldKey),
      body:Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MainHeadingText(text: 'Enter Email Address', fontSize: 26, color: MyColors.white, fontFamily: 'bold',),
                vSizedBox05,
                MainHeadingText(text: 'Please login to receive instructions for windmill power generator', fontSize: 16, color: MyColors.white,),
                vSizedBox4,
                CustomTextField(controller: email, label: 'Email'),
                vSizedBox2,
                if(!load)
                RoundEdgedButton(text: 'Send Recovery mail', onTap: ()async{
                  Map data = {
                    "E_Mail": {
                      "value": email.text,
                      "type": "EMAIL",
                      "msg": "Please enter valid email!"
                    },
                    "action": {
                      "value": 'forget_password',
                      "type": "NO",
                      "msg": ""
                    },
                  };
                  if (validateMap(data) == 1) {
                    setState(() {
                      load=true;
                    });
                    var res =await Webservices.postData('', data, {});
                    setState(() {
                      load=false;
                    });
                    showSnackbar(res['message']??'Try again later!');


                    Navigator.pop(context);
                  }
                }
                ),
                if(load)
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    // color: Colors.white,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      // border: Border.all(color: isSolid? bordercolor: MyColors.primaryColor, width: 1),
                      // boxShadow: [
                      //   boxShadow
                      // ]
                    ),
                    child: Container(
                      height: 25,
                      width: 25,
                      padding: EdgeInsets.only(top: 5, bottom: 5),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Send Recovery mail',
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            cupertino.CupertinoActivityIndicator(
                              color: MyColors.primaryColor,
                              radius: 10,
                            ),
                            // CircularProgressIndicator(
                            //   color:MyColors.primaryColor,
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Expanded(flex: 7, child: Container(),)
          ],
        ),
      ),
    );
  }
}
