import 'dart:developer';

import 'package:automation/services/auth.dart';
import 'package:automation/services/getDashboardData.dart';
import 'package:automation/services/webservices.dart';
import 'package:automation/terms.dart';
import 'package:automation/widget/CustomTexts.dart';
import 'package:automation/widget/buttons.dart';
import 'package:automation/widget/customLoader.dart';
import 'package:automation/widget/customtextfield.dart';
import 'package:automation/widget/snakeBar.dart';
import 'package:flutter/material.dart';

import 'constants/colors.dart';
import 'constants/navigation.dart';
import 'constants/sized_box.dart';
import 'forgot-password.dart';
import 'home.dart';
import 'package:flutter/cupertino.dart' as cupertino;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  bool load = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              flex: 11,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 108.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MainHeadingText(
                        text: 'Log In Here!',
                        fontSize: 26,
                        color: MyColors.white,
                        fontFamily: 'bold',
                      ),
                      vSizedBox05,
                      MainHeadingText(
                        text:
                            'Please login to receive instructions for windmill power generator',
                        fontSize: 16,
                        color: MyColors.white,
                      ),
                      vSizedBox4,
                      CustomTextField(controller: name, label: 'Username'),
                      vSizedBox2,
                      CustomTextField(
                        controller: password,
                        label: 'Password',
                        obscureText: true,
                      ),
                      vSizedBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () => push(
                                  context: context, screen: ForgotPassword()),
                              child: MainHeadingText(
                                text: 'Forgot Password?',
                                fontSize: 14,
                                fontFamily: 'bold',
                                color: MyColors.white,
                              ))
                        ],
                      ),
                      vSizedBox2,
                      if (!load)
                        RoundEdgedButton(
                            // width: MediaQuery.of(context).size.width-32,
                            text: load ? '' : 'Login Now',
                            onTap: load
                                ? () {}
                                : () async {
                                    setState(() {
                                      load = true;
                                    });
                                    print('name----------------${name.text}');
                                    if (name.text == '') {
                                      showSnackbar('Please enter your name.');
                                      setState(() {
                                        load = false;
                                      });
                                    } else if (password.text == '') {
                                      showSnackbar(
                                          'Please enter your password.');
                                      setState(() {
                                        load = false;
                                      });
                                    } else {
                                      Map data = {
                                        'action': {'value': 'login'},
                                        'username': {'value': name.text},
                                        'password': {'value': password.text},
                                        // 'username':name.text,
                                        // 'password':password.text
                                      };

                                      log("data for api --------------$data");
                                      var res = await Webservices.postData(
                                          '', data, {});

                                      log("res from api --------------$res");
                                      showSnackbar(res['message']);
                                      if (res['status'].toString() == '1') {
                                        await updateUserDetails(res['data']);
                                        await getData();
                                        setState(() {
                                          load = false;
                                        });
                                        pushAndPopAll(
                                            context: context,
                                            screen: HomePage());
                                      }
                                      else{
                                        setState(() {
                                          load = false;
                                        });
                                      }
                                    }

                                    // push(context: context, screen: HomePage());
                                  }),
                      if (load)
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
                                    'Login Now',
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
                      vSizedBox2,
                      SizedBox(
                        height: 220,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Center(
                            child: TextButton(
                                onPressed: () => push(
                                    context: context,
                                    screen: TermsConditionPage()),
                                child: MainHeadingText(
                                  text: 'Terms & Conditions',
                                  fontFamily: 'bold',
                                  color: MyColors.white,
                                  fontSize: 16,
                                ))),
                      )
                    ],
                  ),
                ),
              ),
            ),
            // Expanded(
            //   flex: 1,
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: [
            //       TextButton(onPressed: () => push(context: context, screen: TermsConditionPage()), child: MainHeadingText(text: 'Terms & Conditions', fontFamily: 'bold', color: MyColors.white, fontSize: 16,))
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
