import 'package:automation/services/auth.dart';
import 'package:automation/services/webservices.dart';
import 'package:automation/widget/CustomTexts.dart';
import 'package:automation/widget/appbar.dart';
import 'package:automation/widget/buttons.dart';
import 'package:automation/widget/customLoader.dart';
import 'package:automation/widget/customtextfield.dart';
import 'package:automation/widget/snakeBar.dart';
import 'package:flutter/material.dart';

import 'constants/colors.dart';
import 'constants/navigation.dart';
import 'constants/sized_box.dart';
import 'functions/validations.dart';
import 'package:flutter/cupertino.dart' as cupertino;

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController currentpassword = TextEditingController();
  TextEditingController newpassword = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  bool load=false;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      appBar: appBar(context: context, title: 'Change Password', appBarType: AppBarType.sub, scaffoldKey: scaffoldKey),
      body:Padding(
        padding: const EdgeInsets.all(16.0),
        child:SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MainHeadingText(text: 'Change Password', fontSize: 26, color: MyColors.white, fontFamily: 'bold',),
                  vSizedBox05,
                  MainHeadingText(text: 'Please login to receive instructions for windmill power generator', fontSize: 16, color: MyColors.white,),
                  vSizedBox4,
                  CustomTextField(controller: currentpassword, label: 'Current Password',obscureText: true,),
                  vSizedBox2,
                  CustomTextField(controller: newpassword, label: 'New Password',obscureText: true,),
                  vSizedBox2,
                  CustomTextField(controller: confirmpassword, label: 'Confirm Password',obscureText: true,),
                  vSizedBox2,
                  if(!load)
                  RoundEdgedButton(text: 'Submit Now',
                  onTap: ()async{
                    Map data={

                      "action":{"value":'change_password', "type":"NO", "msg":""},
                      "Account_ID":{"value":'${await getCurrentUserId()}', "type":"NO", "msg":""},
                      "current_password":{"value":currentpassword.text, "type":"NO", "msg":"Please enter your current password"},
                      "new_password":{"value":newpassword.text, "type":"NO", "msg":"Please enter new password"},
                      "confirm_password":{"value":confirmpassword.text, "type":"NO", "msg":""},




                    };

                    if(validateMap(data)==1){
                      if(newpassword.text==confirmpassword.text){
                        // print("success-----" + data.toString());
                        load = true;
                        setState(() {});
                        Map res = await Webservices.postData('', data,null);
                        print("success res-----" + res.toString());
                        load =false;
                        setState(() {});
                        if(res['status'].toString()=="1"){
                          showSnackbar(res['message']);
                          Navigator.pop(context);

                        }
                        else{
                          showSnackbar(res['message']);
                        }
                      }
                      else{
                        showSnackbar("New password and confirm new password should be matched..");
                      }


                    }
                  },),
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
                                'Submit Now',
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
            ),
            // Expanded(flex: 3, child: Container(),)

      ),
    );
  }
}
