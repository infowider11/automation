import 'package:automation/widget/CustomTexts.dart';
import 'package:automation/widget/appbar.dart';
import 'package:automation/widget/buttons.dart';
import 'package:automation/widget/customtextfield.dart';
import 'package:flutter/material.dart';

import 'change-password.dart';
import 'constants/colors.dart';
import 'constants/navigation.dart';
import 'constants/sized_box.dart';

class TermsConditionPage extends StatefulWidget {
  const TermsConditionPage({Key? key}) : super(key: key);

  @override
  State<TermsConditionPage> createState() => _TermsConditionPageState();
}

class _TermsConditionPageState extends State<TermsConditionPage> {
  TextEditingController name = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      appBar: appBar(context: context, title: 'Terms & Conditions', appBarType: AppBarType.sub, scaffoldKey: scaffoldKey),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MainHeadingText(text: 'Your agreement', fontSize: 18, color: MyColors.white, fontFamily: 'bold',),
            vSizedBox,
            MainHeadingText(text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.", fontSize: 16, color: MyColors.white, height: 1.3,),
            vSizedBox2,
            MainHeadingText(text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.", fontSize: 16, color: MyColors.white, height: 1.3,),
            vSizedBox4,
            MainHeadingText(text: 'Cookies', fontSize: 18, color: MyColors.white, fontFamily: 'bold',),
            vSizedBox,
            MainHeadingText(text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.", fontSize: 16, color: MyColors.white, height: 1.3,),
            vSizedBox2,
            MainHeadingText(text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.", fontSize: 16, color: MyColors.white, height: 1.3,),
          ],
        ),
      ),
    );
  }
}
