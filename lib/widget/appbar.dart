import 'package:automation/constants/globaldata.dart';
import 'package:flutter/material.dart';

import '../change-password.dart';
import '../constants/colors.dart';
import '../constants/navigation.dart';
import '../constants/sized_box.dart';
import '../home.dart';
import '../login.dart';
import '../services/auth.dart';
import '../services/getDashboardData.dart';
import '../terms.dart';
import 'CustomTexts.dart';
import 'drawerLink.dart';
enum AppBarType{
  main, sub
}

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: MyColors.primaryColor,
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 200,
            child: DrawerHeader(
              padding: EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image.asset('assets/images/profile.png',height: 120,),
                  vSizedBox,
                  SizedBox(
                      height: 50
                  ),
                  Text('${user_data!['Firstname']}',style: TextStyle(fontSize: 18,fontFamily: 'bold',color:MyColors.white),textAlign: TextAlign.start,),
                  // vSizedBox05,
                  Text('${user_data!['E_Mail']??''}',style: TextStyle(fontSize: 14,fontFamily: 'regular',color: MyColors.white),textAlign: TextAlign.start,),
                ],
              )
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                DrawerLink(title: 'Dashboard', img: 'assets/images/menu-1.png',
                func:
                    () async{
                  Navigator.pop(context);
                  await getData();
                  push(context: context, screen: HomePage());
                }),

                    // func: ()=>push(context: context, screen: HomePage())),
                // DrawerLink(title: 'Change Password', img: 'assets/images/menu-2.png',
                //     func:
                //     () {
                //   Navigator.pop(context);
                //       push(context: context, screen: ChangePassword());
                // }),

                // DrawerLink(title: 'Terms & Conditions', img: 'assets/images/menu-3.png',
                //     func:
                //         () {
                //       Navigator.pop(context);
                //       push(context: context, screen: TermsConditionPage());
                //     }),
                    // func: ()=>push(context: context, screen: TermsConditionPage())),
                DrawerLink(title: 'Logout', img: 'assets/images/menu-4.png',
                    func: ()async{
                      logOutModal(context);
                    },

                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



AppBar appBar(
    {
      String title = '',
      Widget? widgetTitle = null,
      String location = '',
      AppBarType appBarType = AppBarType.main,
      Color appBarColor = Colors.transparent,
      Color titleColor = MyColors.headingcolor,
      bool implyLeading = true,
      IconData backIcon = Icons.arrow_back_outlined,
      double fontsize = 16,
      double size = 20,
      // double toolbarHeight = 50,
      String badge = '0',
      String fontfamily = 'light',
      bool titlecenter = true,
      bool isAction = false,
      String iconImage = '',
      required BuildContext context,
      required  GlobalKey<ScaffoldState> scaffoldKey,

      List<Widget>? actions, leading
    }) {
        if(appBarType==AppBarType.main){
          return AppBar(
            backgroundColor: MyColors.primaryColor,
            elevation: 0,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
            leading: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    scaffoldKey.currentState?.openDrawer();
                  },
                  child: Image.asset('assets/images/menu.png', width: 25,),
                ),
              ],
            ),
            actions: [
              Row(
                children: [
                  Image.asset('assets/images/google.png', width: 20,),
                  hSizedBox05,
                  MainHeadingText(text: '${location}', color: MyColors.white, fontSize: 14, fontFamily: 'medium',),
                  hSizedBox
                ],
              )
            ],
          );
        }else{
          return AppBar(
            automaticallyImplyLeading: true,
            title: (widgetTitle==true)?Text(
              title,
              style: TextStyle(
                color: MyColors.white, fontFamily: 'SemiBold', fontSize: 18),
            ):widgetTitle,
            leadingWidth: 35,
            leading: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Icon(Icons.chevron_left_rounded, color: MyColors.white),
              ),
            ),
            shape: Border(bottom: BorderSide(color:Color(0xFF333333).withOpacity(0.20), width: 1)),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: false,
            actions: actions
          );
        }







      }
Future<dynamic> logOutModal(context){
  return  showDialog(
    context: context,

    builder: (contexta) {
      double h = MediaQuery.of(contexta).size.height;
      double w = MediaQuery.of(contexta).size.width;
      return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          insetPadding: const EdgeInsets.all(50),
          elevation: 16,
          child: Stack(
              clipBehavior: Clip.none,
              // width: double.infinity,
              // alignment: Alignment.center,
              children:[
                Container(
                    width: double.infinity,
                    child:
                    Padding(
                      padding:const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                      child: ListView(
                        shrinkWrap: true,
                        children: <Widget>[

                          Text(
                            // translate("message.kycpending"), textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWaeight.bold, fontSize: 18),),
                            "Are you sure you want to logout?",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontFamily: 'semibold',
                              color: Colors.black,
                              fontSize: 18, height: 1.8,
                            ),
                          ),

                          const SizedBox(height:10),

                          const SizedBox(height:20),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children:[
                                Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0),

                                    ),
                                    // margin: const EdgeInsets.only(top: 20, left: 200, right: 0),
                                    // left: 20,
                                    height: 40,
                                    width:80,
                                    child:
                                    ElevatedButton(

                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.transparent,
                                        textStyle: TextStyle(color: MyColors.primaryColor),
                                        onSurface: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30.0),
                                            side: BorderSide(width:2.0,color: MyColors.primaryColor)
                                        ),
                                      ),
                                      onPressed:(){
                                        // log('hee');
                                        Navigator.pop(contexta, false);
                                        // Navigator.of(contexta).pop();
                                      },
                                      child:  Text(
                                          "NO",

                                          textAlign: TextAlign.center,style: TextStyle(
                                        fontFamily: 'semibold',
                                        color: MyColors.primaryColor,
                                        fontSize: 16,
                                      )
                                      ),
                                    )
                                ),
                                // SizedBox(width:10),
                                Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0),
                                      gradient: const LinearGradient(
                                        begin: Alignment(-0.95, 0.0),
                                        end: Alignment(1.0, 0.0),
                                        colors: [ MyColors.primaryColor,  MyColors.primaryColor],
                                        stops: [0.0, 1.0],
                                      ),
                                    ),
                                    // margin: const EdgeInsets.only(top: 20, left: 200, right: 0),
                                    // left: 20,
                                    height: 40,
                                    width: 80,
                                    child:
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.transparent,
                                        onSurface: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30.0),
                                        ),
                                      ),
                                      onPressed:() async{
                                        await logout();
                                        pushReplacement(context: context, screen: LoginPage());
                                      },
                                      child:  Text(
                                          "Yes",
                                          textAlign: TextAlign.center,style: TextStyle(
                                        fontFamily: 'semibold',
                                        fontSize: 18,
                                      )
                                      ),
                                    )
                                )




                              ]
                          ),
                          // SizedBox(height: 20),

                          // SizedBox(height: 20),

                        ],
                      ),
                    )

                ),
              ]
          )

      );
    },
  ).then((exit) {

  });
}
// AppBar(
// // toolbarHeight: toolbarHeight,
// automaticallyImplyLeading: false,
// backgroundColor: appBarColor,
// elevation: 0,
// centerTitle: titlecenter,
// title: title == null
// ? null
// : AppBarHeadingText(
// text: title,
// color: titleColor,
// fontSize: fontsize,
// fontFamily: fontfamily,
// ),
// leading: implyLeading
// ? IconButton(
// icon:
// Icon(
// backIcon,
// color: titleColor,
// size: size,
// ),
// onPressed: () {
// Navigator.pop(context);
// },
// )
// : leading,
// actions: actions,
// )