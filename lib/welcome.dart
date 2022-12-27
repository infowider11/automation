import 'package:automation/widget/CustomTexts.dart';
import 'package:automation/widget/buttons.dart';
import 'package:automation/widget/size.dart';
import 'package:flutter/material.dart';

import 'constants/colors.dart';
import 'constants/navigation.dart';
import 'login.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: context.height,
        width: context.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/welcome.png'),
            fit: BoxFit.cover
          )
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MainHeadingText(text: 'Welcome to versatilescada!', color: MyColors.white, fontFamily: 'bold', fontSize: 46,),
                  ],
                )
              ),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RoundEdgedButton(text: 'Yes! Get me started', onTap: () => push(context: context, screen: LoginPage())),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
