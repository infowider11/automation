


import 'dart:developer';

import 'package:automation/services/auth.dart';
import 'package:automation/services/getDashboardData.dart';
import 'package:automation/services/webservices.dart';
import 'package:automation/widget/CustomTexts.dart';
import 'package:automation/widget/appbar.dart';
import 'package:automation/widget/customLoader.dart';
import 'package:automation/widget/size.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:fl_chart/fl_chart.dart' as chart;
import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'dart:math' as math;

import 'constants/colors.dart';
import 'constants/sized_box.dart';

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}

class DetailPage extends StatefulWidget {
  final String speed;
  final String power;
  final Map data;
  const DetailPage(
      {Key? key, required this.power, required this.speed, required this.data})
      : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  double _pointerValue = 45;
  Map detail = {};
  bool load = false;
  bool isSpeed = true;
  bool isPower = false;
  bool isProduction = false;

  int maxValueProduction = 1000;

  List<FlSpot> buildpowerflSpots(){


    List<FlSpot> flspots = [];


    List points = [];


    // if(detail['powerWindSpeed']['powerkw'].runtimeType)

    (detail['powerWindSpeed']['powerkw'] as Map).forEach((key, value){
      print('the points are(${key}, ${value[1]})');
    points.add(
      {'x':key,'y':value[1]}
    );



    });


    int count = 0;
    for(int i = points.length-1;i>=0;i--){
      if(points[i]['y']==0 &&count==0){

      }else{
        count++;
        if(double.parse('${points[i]['x']}')>=1)
        flspots.add(
          FlSpot(
            double.parse('${points[i]['x']}'),
            double.parse('${points[i]['y']}').floorToDouble(),
          ),
        );
      }

    }
    return flspots;

  }



  getDetail() async {
    setState(() {
      load = true;
    });
    Map data = {
      'action': {'value': 'get_detail'},
      'Account_ID': {'value': '${await getCurrentUserId()}'},
      'Format_Type': {'value': '${widget.data['Format_Type']}'},
      'IMEI': {'value': '${widget.data['IMEI']}'},
      'Pocket_Length': {'value': '${widget.data['Pocket_Length']}'},
      'Device': {'value': '${widget.data['Device_Name']}'},
    };

    print('object-----------$data');
    detail = await Webservices.getData('', data);
    setState(() {
      load = false;
    });
    // log("is list or object ---------------${detail['powerWindSpeed']['powerkw'].runtimeType}");
    if(detail['status'].toString()=='1'){
      log("detail---------detail----${detail['powerSpeed']}");
      for(int i=0;i<detail['powerSpeed'].length;i++){
        var time=detail['powerSpeed'][i]['Time_S'].toString().split(':')[0];
        var time1=detail['powerSpeed'][i]['Time_S'].toString().split(':')[1];
        var time2=detail['powerSpeed'][i]['Time_S'].toString().split(':')[2];
        // log('message-----${detail['powerSpeed'][i]['Time_S']}---------${time} --------${time2}');
        var fTime=(int.parse(time.toString())*60)+(int.parse(time1.toString())+(int.parse(time.toString())/60));
        detail['powerSpeed'][i]['final_time']=double.parse(fTime.toString());
        // log('ftime------------------${fTime}');
      }
      for(int i=0;i<detail['production']['data'].length;i++){
        if(detail['production']['data'][i]['value']>maxValueProduction){
          try{
            maxValueProduction = (detail['production']['data'][i]['value'] as double).ceil();
          }catch(e){
            maxValueProduction = detail['production']['data'][i]['value'];
          }
        }
      }

      maxValueProduction += 1000-(maxValueProduction%1000);
      setState(() {

      });
    }
    else{
      detail={};
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    getDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      appBar: appBar(

          context: context,
          appBarType: AppBarType.sub,
          // title: 'Information',
          title: '',
          widgetTitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
            // Text("Information"),
              Container(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                vSizedBox05,
              MainHeadingText(

                text: '${widget.data['Device_Name']}',
                fontFamily: 'bold',
                fontSize: 22,
                color: MyColors.white,
              ),
              MainHeadingText(
                text: '${widget.data['Connect_Feeder']}',
                fontFamily: 'regular',
                fontSize: 14,
                color: MyColors.white,
              ),
            ],)
          ],),
          scaffoldKey: scaffoldKey),
      body: load
          ? CustomLoader()
          : SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child:detail['status'].toString()=='1'? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  vSizedBox,
                  // MainHeadingText(
                  //   text: '${widget.data['CurrentSite']}',
                  //   fontFamily: 'bold',
                  //   fontSize: 22,
                  //   color: MyColors.white,
                  // ),
                  // MainHeadingText(
                  //   text: '${widget.data['Connect_Feeder']}',
                  //   fontFamily: 'regular',
                  //   fontSize: 14,
                  //   color: MyColors.white,
                  // ),
                  // vSizedBox4,
                  Row(
                    children: [
                      Expanded(
                          flex: 9,
                          child: Center(
                              child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Image.asset(
                                  'assets/images/shape-center.png',
                                  width: 140,
                                ),
                              ),
                              SizedBox(
                                height: 150,
                                child: SfRadialGauge(
                                  enableLoadingAnimation: true,
                                  animationDuration: 3500,
                                  axes: <RadialAxis>[
                                    RadialAxis(
                                      pointers: <GaugePointer>[
                                        RangePointer(
                                          width: 8,
                                          animationDuration: 1200,
                                          // animationType: ,
                                          value: double.parse(detail['data']['Power']??widget.power)/10.5,
                                          color: MyColors.secondarycolor,
                                          cornerStyle: CornerStyle.bothCurve,
                                          enableAnimation: true,
                                        )
                                      ],
                                      annotations: <GaugeAnnotation>[
                                        GaugeAnnotation(
                                            angle: 10,
                                            axisValue: 50,
                                            widget: Text(
                                              '${detail['data']['Power']??widget.power} kw',
                                              style: TextStyle(
                                                  fontFamily: 'bold',
                                                  color: MyColors.white,
                                                  fontSize: 18),
                                            ))
                                      ],
                                      showLabels: false,
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                  bottom: 2,
                                  left: 85,
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        color: MyColors.secondarycolor,
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: Center(
                                        child: MainHeadingText(
                                            // text: '${detail['data']['Power']??widget.power}',
                                            text: '-50',
                                            fontSize: 10,
                                            fontFamily: 'bold',
                                            color: MyColors.white)),
                                  )),
                              Positioned(
                                  bottom: 3,
                                  right: 75,
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        color: Color(0xFE262733),
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: Center(
                                        child: MainHeadingText(
                                            text: '1000',
                                            fontSize: 10,
                                            fontFamily: 'bold',
                                            color: MyColors.white)),
                                  )),
                            ],
                          ))),
                      Expanded(
                          flex: 3,
                          child: Center(
                            child: RotatedBox(
                              quarterTurns: 1,
                              child: MainHeadingText(
                                text: 'POWER',
                                fontFamily: 'medium',
                                fontSize: 30,
                                color: MyColors.white,
                              ),
                            ),
                          ))
                    ],
                  ),
                  vSizedBox,
                  Row(
                    children: [
                      Expanded(
                          flex: 3,
                          child: Center(
                            child: RotatedBox(
                              quarterTurns: 3,
                              child: MainHeadingText(
                                text: 'SPEED',
                                fontFamily: 'medium',
                                fontSize: 30,
                                color: MyColors.white,
                              ),
                            ),
                          )),
                      Expanded(
                          flex: 9,
                          child: Center(
                              child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Image.asset(
                                  'assets/images/shape-center.png',
                                  width: 140,
                                ),
                              ),
                              SizedBox(
                                height: 150,
                                child: SfRadialGauge(
                                  enableLoadingAnimation: true,
                                  animationDuration: 3500,
                                  axes: <RadialAxis>[
                                    RadialAxis(
                                      pointers: <GaugePointer>[
                                        RangePointer(
                                          width: 8,
                                          animationDuration: 1200,
                                          // animationType: ,
                                          value: double.parse(detail['data']['Windspeed']??widget.speed)*3.33,
                                          // value: double.parse(detail['data']['Windspeed']??widget.speed),
                                          color: MyColors.secondarycolor,
                                          cornerStyle: CornerStyle.bothCurve,
                                          enableAnimation: true,
                                        )
                                      ],
                                      annotations: <GaugeAnnotation>[
                                        GaugeAnnotation(
                                            angle: 10,
                                            axisValue: 50,
                                            widget: Text(
                                              '${detail['data']['Windspeed']??widget.speed} m/s',
                                              style: TextStyle(
                                                  fontFamily: 'bold',
                                                  color: MyColors.white,
                                                  fontSize: 18),
                                            ))
                                      ],
                                      showLabels: false,
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                  bottom: 2,
                                  left: 85,
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        color: MyColors.secondarycolor,
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: Center(
                                        child: MainHeadingText(
                                            // text: '${detail['data']['Windspeed']??widget.speed}',
                                            text: '0',
                                            fontSize: 10,
                                            fontFamily: 'bold',
                                            color: MyColors.white)),
                                  )),
                              Positioned(
                                  bottom: 3,
                                  right: 85,
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        color: Color(0xFE262733),
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: Center(
                                        child: MainHeadingText(
                                            text: '30',
                                            fontSize: 10,
                                            fontFamily: 'bold',
                                            color: MyColors.white)),
                                  )),
                            ],
                          ))),
                    ],
                  ),
                  vSizedBox4,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            'assets/images/start.png',
                            width: 40,
                          ),
                          vSizedBox05,
                          MainHeadingText(
                            text: 'Start',
                            color: MyColors.white,
                            fontFamily: 'bold',
                            fontSize: 12,
                          ),
                        ],
                      ),
                      hSizedBox4,
                      Column(
                        children: [
                          Image.asset(
                            'assets/images/pause.png',
                            width: 40,
                          ),
                          vSizedBox05,
                          MainHeadingText(
                            text: 'Stop',
                            color: MyColors.white,
                            fontFamily: 'bold',
                            fontSize: 12,
                          ),
                        ],
                      ),
                      hSizedBox4,
                      Column(
                        children: [
                          Image.asset(
                            'assets/images/reset.png',
                            width: 40,
                          ),
                          vSizedBox05,
                          MainHeadingText(
                            text: 'Reset',
                            color: MyColors.white,
                            fontFamily: 'bold',
                            fontSize: 12,
                          ),
                        ],
                      )
                    ],
                  ),
                  vSizedBox4,
                  SizedBox(
                    height: 40,
                    child: ListView(
                      clipBehavior: Clip.none,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        GestureDetector(
                          onTap: () {
                            isSpeed = true;
                            isPower = false;
                            isProduction = false;
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: isSpeed
                                    ? Border.all(
                                        color: MyColors.white,
                                      )
                                    : Border.all(
                                        color: Colors.transparent,
                                      )),
                            child: Center(
                                child: MainHeadingText(
                              text: 'Wind Speed',
                              fontSize: 14,
                              color: MyColors.white,
                            )),
                          ),
                        ),
                        hSizedBox,
                        GestureDetector(
                          onTap: () {
                            isPower = true;
                            isSpeed = false;
                            isProduction = false;
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: isPower
                                    ? Border.all(
                                        color: MyColors.white,
                                      )
                                    : Border.all(
                                        color: Colors.transparent,
                                      ),
                                color: MyColors.primaryColor,
                                boxShadow: [
                                  BoxShadow(
                                      color: MyColors.black.withOpacity(0.3),
                                      blurRadius: 5)
                                ]),
                            // child: Center(child: MainHeadingText(text: 'Blade 1 Pos. (Sensor 1)', fontSize: 14, color: MyColors.white,)),
                            child: Center(
                                child: MainHeadingText(
                              text: 'Power',
                              fontSize: 14,
                              color: MyColors.white,
                            )),
                          ),
                        ),
                        hSizedBox,
                        GestureDetector(
                          onTap: () {
                            isPower = false;
                            isSpeed = false;
                            isProduction = true;
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: isProduction
                                    ? Border.all(
                                        color: MyColors.white,
                                      )
                                    : Border.all(
                                        color: Colors.transparent,
                                      ),
                                color: MyColors.primaryColor,
                                boxShadow: [
                                  BoxShadow(
                                      color: MyColors.black.withOpacity(0.3),
                                      blurRadius: 5)
                                ]),
                            // child: Center(child: MainHeadingText(text: 'Power 1 sec Avg', fontSize: 14, color: MyColors.white,)),
                            child: Center(
                                child: MainHeadingText(
                              text: 'Prodution',
                              fontSize: 14,
                              color: MyColors.white,
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  vSizedBox,
                  if (detail['production'] != null && isProduction)
                    Container(

                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      height: 210,
                      child: BarChart(

                          BarChartData(

                            maxY: maxValueProduction +0.0,
                            minY: 0,
                            // rangeAnnotations: RangeAnnotations(
                            //   horizontalRangeAnnotations: [HorizontalRangeAnnotation()]
                            // ),
                            barTouchData: BarTouchData(
                              enabled: true,
                              // touchCallback: (){
    // setState(() {
    // if (!event.isInterestedForInteractions ||
    // barTouchResponse == null ||
    // barTouchResponse.spot == null) {
    // touchedIndex = -1;
    // return;
    // }
    // touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
    //                           }
                            ),
                            titlesData: FlTitlesData(
                              show: true,
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (double m, TitleMeta a){


                                      return Text(a.formattedValue, style: TextStyle(color: Colors.white, fontSize: 9),);
                                  }

                                ),
                              ),

                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                    showTitles: true,
                                     // interval: 3,
                                    // reservedSize:5 ,
                                    getTitlesWidget: (double m, TitleMeta a){
                                      print('kjlsjljdljdljlsjfklsdkjl---------');
                                      // print(m);
                                      // if(m%3==0)
                                      return Text(a.formattedValue.toString(), style: TextStyle(color: Colors.white, fontSize: 12),);
                                      // else
                                      //   return Text("");
                                    }

                                ),
                              ),
                              topTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles:false ,
                                ),
                              ),
                              rightTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: false,
                                ),
                              ),
                            ),
                            borderData: FlBorderData(
                              border: Border(
                                left: BorderSide(
                                    width: 2,
                                    color: Colors.white,
                                    style: BorderStyle.solid), //BorderSide
                                bottom:BorderSide(
                                    width: 2,
                                    color: Colors.white,
                                    style: BorderStyle.solid),

                              ),
                              show: true,
                            ),

                            barGroups: makeGroupData(),
                            gridData: FlGridData(show: true
                            ),
                          ),



                      ),
                    ),
                  if (detail['powerWindSpeed'] != null && isSpeed)
                    Container(

                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      height: 210,
                      child: LineChart(

                        LineChartData(
                            gridData: FlGridData(show:true),
                            borderData: FlBorderData(
                              border: Border(
                                left: BorderSide(
                                    width: 2,
                                    color: Colors.white,
                                    style: BorderStyle.solid), //BorderSide
                                bottom:BorderSide(
                                    width: 2,
                                    color: Colors.white,
                                    style: BorderStyle.solid),

                              ),
                              show: true,
                            ),

                            extraLinesData: ExtraLinesData(
                                extraLinesOnTop: false,

                            ),
                            maxX: 23,
                            // maxX: double.parse('${detail['powerWindSpeed']['windspeed'].length}'),
                            minX:0,
                            minY:0,
                            maxY: 30,
                            baselineX: 1,
                            // lineTouchData: LineTouchData,



                            backgroundColor: MyColors.primaryColor,
                            // borderData: FlBorderData(show: true,),

                            titlesData: FlTitlesData(
                                topTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles:false ,
                                  ),
                                ),
                                rightTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: false,
                                  ),
                                ),

                                  leftTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                        showTitles: true,
                                        interval: 5,
                                        getTitlesWidget: (double m, TitleMeta a){

                                          return Text(a.formattedValue, style: TextStyle(color: Colors.white, fontSize: 12),);

                                        }

                                    ),
                                  ),

                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                        showTitles: true,
                                        interval: 1,
                                        // reservedSize:10 ,
                                        reservedSize: 38,


                                        getTitlesWidget: (double m, TitleMeta a){
                                          return Column(
                                            children: [
                                              SizedBox(height: 4,),
                                              if(m%2==0)
                                                vSizedBox2,
                                              Text(a.formattedValue.toString(), style: TextStyle(color: Colors.white, fontSize: 10),),
                                            ],
                                          );
                                            // return Text(a.formattedValue.toString(), style: TextStyle(color: Colors.white, fontSize: 10),);

                                        }

                                    ),
                                  ),
                            ),
                            lineBarsData: [
                              LineChartBarData(
                                  dotData: FlDotData(show: true, getDotPainter: (a, b, c,d){
                                    return chart.FlDotCirclePainter(color: Colors.red);
                                  }),
                                  isCurved: true,
                                  curveSmoothness: 0.5,
                                  // color: MyColors.white,
                                  color: Colors.blue,

                                  spots: [
                                    if(detail['powerWindSpeed']['windspeed']!=null)

                                        for (int i = 0;
                                    i < detail['powerWindSpeed']['windspeed'].length;
                                    i++)
                                    // for(int j=0;j<6;j++)
                                      if(detail['powerWindSpeed']['windspeed'][i]['x']!=null && detail['powerWindSpeed']['windspeed'][i]['y']!=null)
                                      FlSpot(
                                        double.parse('${detail['powerWindSpeed']['windspeed'][i]['x']}'),
                                          double.parse('${detail['powerWindSpeed']['windspeed'][i]['y']}').floorToDouble(),
                                      ),

                                  ]
                              ),

                            ]),
                      ),
                    ),
                  if (detail['powerWindSpeed'] != null && isPower)
                    Container(

                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      height: 210,
                      child: LineChart(

                        LineChartData(
                            gridData: FlGridData(show:true),
                            borderData: FlBorderData(
                              border: Border(
                                left: BorderSide(
                                    width: 2,
                                    color: Colors.white,
                                    style: BorderStyle.solid), //BorderSide
                                bottom:BorderSide(
                                    width: 2,
                                    color: Colors.white,
                                    style: BorderStyle.solid),

                              ),
                              show: true,
                            ),

                            extraLinesData: ExtraLinesData(
                              extraLinesOnTop: false,

                            ),
                            maxX: 23,
                            minX:1,
                            minY:-10,
                            maxY: 1000,
                            // maxY: 1000,
                            baselineX: 1,
                            // lineTouchData: LineTouchData,



                            backgroundColor: MyColors.primaryColor,
                            // borderData: FlBorderData(show: true,),

                            titlesData: FlTitlesData(
                              topTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles:false ,
                                ),
                              ),
                              rightTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: false,
                                ),
                              ),

                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                    showTitles: true,
                                    interval: 200,
                                    getTitlesWidget: (double m, TitleMeta a){

                                      return Text(a.formattedValue, style: TextStyle(color: Colors.white, fontSize: 9),);
                                    }

                                ),
                              ),

                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                    showTitles: true,
                                    interval: 1,
                                    reservedSize: 38,
                                    // reservedSize:10 ,


                                    getTitlesWidget: (double m, TitleMeta a){

                                      return Column(
                                        children: [
                                          SizedBox(height: 4,),
                                          if(m%2==0)
                                            vSizedBox2,
                                          Text(a.formattedValue.toString(), style: TextStyle(color: Colors.white, fontSize: 10),),
                                        ],
                                      );

                                    }

                                ),
                              ),
                            ),
                            lineBarsData: [
                              LineChartBarData(
                                  dotData: FlDotData(show: true, getDotPainter: (a, b, c,d){
                                    return chart.FlDotCirclePainter(color: Colors.red);
                                  }),
                                  isCurved: true,
                                  curveSmoothness: 0.5,
                                  // color: MyColors.white,
                                  color: Colors.blue,

                                  spots: buildpowerflSpots()
                              ),

                            ]),
                      ),
                    ),
                    // Container(
                    //
                    //   padding: const EdgeInsets.all(10),
                    //   width: double.infinity,
                    //   height: 210,
                    //   child: LineChart(
                    //
                    //
                    //     LineChartData(
                    //         gridData: FlGridData(show:true),
                    //
                    //         minY: -50,
                    //         maxX: 24,
                    //         minX:0,
                    //         maxY: 1000,
                    //         // baselineX: 5,
                    //         // lineTouchData: LineTouchData,
                    //
                    //
                    //
                    //         backgroundColor: MyColors.primaryColor,
                    //         borderData: FlBorderData(
                    //           border: Border(
                    //             left: BorderSide(
                    //                 width: 2,
                    //                 color: Colors.white,
                    //                 style: BorderStyle.solid), //BorderSide
                    //             bottom:BorderSide(
                    //                 width: 2,
                    //                 color: Colors.white,
                    //                 style: BorderStyle.solid),
                    //
                    //           ),
                    //           show: true,
                    //         ),
                    //
                    //         titlesData: FlTitlesData(
                    //
                    //               topTitles: AxisTitles(
                    //                 sideTitles: SideTitles(
                    //                   showTitles:false ,
                    //                 ),
                    //               ),
                    //               rightTitles: AxisTitles(
                    //                 sideTitles: SideTitles(
                    //                   showTitles: false,
                    //                 ),
                    //               ),
                    //           leftTitles: AxisTitles(
                    //             sideTitles: SideTitles(
                    //                 showTitles: true,
                    //                 getTitlesWidget: (double m, TitleMeta a){
                    //
                    //                   return Text(a.formattedValue, style: TextStyle(color: Colors.white, fontSize: 12),);
                    //                 }
                    //
                    //             ),
                    //           ),
                    //
                    //           bottomTitles: AxisTitles(
                    //             sideTitles: SideTitles(
                    //                 showTitles: true,
                    //                 // interval: 3,
                    //                 // reservedSize:5 ,
                    //                 getTitlesWidget: (double m, TitleMeta a){
                    //
                    //                   return Text(a.formattedValue.toString(), style: TextStyle(color: Colors.white, fontSize: 12),);
                    //
                    //                 }
                    //
                    //             ),
                    //           ),
                    //
                    //         ),
                    //         lineBarsData: [
                    //           // LineChartBarData(
                    //           //     dotData: FlDotData(show: false),
                    //           //     color: MyColors.white,
                    //           //
                    //           //
                    //           //     // isStepLineChart: true,
                    //           //     spots: [
                    //           //       for (int i = 0;
                    //           //       i < detail['powerSpeed'].length;
                    //           //       i++)
                    //           //       // for(int j=0;j<6;j++)
                    //           //         FlSpot(
                    //           //             double.parse(detail['powerSpeed'][i]['Power']
                    //           //                 .toString()),
                    //           //             detail['powerSpeed'][i]['final_time']),
                    //           //
                    //           //     ]
                    //           // ),
                    //
                    //         ]),
                    //   ),
                    // ),

                  vSizedBox2,
                  MainHeadingText(
                    text: 'Current Status',
                    color: MyColors.white,
                    fontSize: 18,
                    fontFamily: 'bold',
                  ),
                  vSizedBox,
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: MyColors.white)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MainHeadingText(
                          text: 'Machine Status',
                          color: MyColors.white,
                          fontSize: 18,
                          fontFamily: 'medium',
                        ),
                        MainHeadingText(
                          text: '${detail['data']['current_status'] ?? '-'}',
                          color: detail['data']['current_status_color']=='green'?MyColors.secondarycolor:detail['data']['current_status_color']=='red'?Colors.red:Colors.blue,
                          fontSize: 14,
                          fontFamily: 'bold',
                        ),
                      ],
                    ),
                  ),

                  vSizedBox2,
                  MainHeadingText(
                    text: 'GAD Details',
                    color: MyColors.white,
                    fontSize: 18,
                    fontFamily: 'bold',
                  ),
                  vSizedBox,
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: MyColors.white)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            MainHeadingText(
                              text: 'GAD for Today',
                              color: MyColors.white,
                              fontSize: 18,
                              fontFamily: 'medium',
                            ),
                            MainHeadingText(
                              text:
                                  '${detail['data']['GAD_for_Today'] ?? 'NIL'}',
                              color: MyColors.white,
                              fontSize: 14,
                              fontFamily: 'bold',
                            ),
                          ],
                        ),
                        vSizedBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            MainHeadingText(
                              text: 'GAD for Yesterday',
                              color: MyColors.white,
                              fontSize: 18,
                              fontFamily: 'medium',
                            ),
                            MainHeadingText(
                              text:
                                  '${detail['data']['GAD_for_Yesterday'] ?? 'NIL'}',
                              color: MyColors.white,
                              fontSize: 14,
                              fontFamily: 'bold',
                            ),
                          ],
                        ),
                        // vSizedBox,
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   crossAxisAlignment: CrossAxisAlignment.center,
                        //   children: [
                        //     MainHeadingText(
                        //       text: 'GAD for This Week',
                        //       color: MyColors.white,
                        //       fontSize: 18,
                        //       fontFamily: 'medium',
                        //     ),
                        //     MainHeadingText(
                        //       text:
                        //           '${detail['data']['GAD_for_This_Week'] ?? 'NIL'}',
                        //       color: MyColors.white,
                        //       fontSize: 14,
                        //       fontFamily: 'bold',
                        //     ),
                        //   ],
                        // ),
                        // vSizedBox,
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   crossAxisAlignment: CrossAxisAlignment.center,
                        //   children: [
                        //     MainHeadingText(
                        //       text: 'GAD for Previous Week',
                        //       color: MyColors.white,
                        //       fontSize: 18,
                        //       fontFamily: 'medium',
                        //     ),
                        //     MainHeadingText(
                        //       text:
                        //           '${detail['data']['GAD_for_Previous_Week'] ?? 'NIL'}',
                        //       color: MyColors.white,
                        //       fontSize: 14,
                        //       fontFamily: 'bold',
                        //     ),
                        //   ],
                        // ),
                        vSizedBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            MainHeadingText(
                              text: 'GAD for Month',
                              color: MyColors.white,
                              fontSize: 18,
                              fontFamily: 'medium',
                            ),
                            MainHeadingText(
                              text:
                                  '${detail['data']['GAD_for_This_month'] ?? 'NIL'}',
                              color: MyColors.white,
                              fontSize: 14,
                              fontFamily: 'bold',
                            ),
                          ],
                        ),
                        // vSizedBox,
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   crossAxisAlignment: CrossAxisAlignment.center,
                        //   children: [
                        //     MainHeadingText(
                        //       text: 'GAD for Year',
                        //       color: MyColors.white,
                        //       fontSize: 18,
                        //       fontFamily: 'medium',
                        //     ),
                        //     MainHeadingText(
                        //       text:
                        //       '${detail['data']['GAD_for_This_month'] ?? 'NIL'}',
                        //       color: MyColors.white,
                        //       fontSize: 14,
                        //       fontFamily: 'bold',
                        //     ),
                        //   ],
                        // ),
                        // vSizedBox,
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   crossAxisAlignment: CrossAxisAlignment.center,
                        //   children: [
                        //     MainHeadingText(text: 'GAD for Year', color: MyColors.white, fontSize: 18, fontFamily: 'medium',),
                        //     MainHeadingText(text: '${detail['data']['GAD_for_Today']} Kwh', color: MyColors.white, fontSize: 14, fontFamily: 'bold',),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                  vSizedBox2
                ],
              )
                  :
              Container(
                height: 300,
                child: Center(child: Text('No communication!'),),
              ),
            ),
    );
  }
  List<BarChartGroupData> makeGroupData(
      {
        bool isTouched = false,
        List<int> showTooltips = const [1],
      }
      ) {

    List<BarChartGroupData> c = [];

    for (int i = 0; i < detail['production']['data'].length;i++){
      double y = double.parse(detail['production']['data'][i]['value'].toString());
      int x = int.parse(detail['production']['data'][i]['date'].toString());

      c.add(
          BarChartGroupData(
        x: x,
        barRods: [
          BarChartRodData(
            borderRadius: BorderRadius.circular(0),
            toY: y,
            color: isTouched ? Colors.orange :Colors.yellow,
            width: 8,

            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              // toY: 20,
              color: Colors.yellow,
            ),
          ),
        ],
        showingTooltipIndicators: showTooltips,
      )
      );
    }

      // FlSpot(
      //     double.parse(detail['production']
      //     ['data'][i]['date']
      //         .toString()),
      //     double.parse(detail['production']
      //     ['data'][i]['value']
      //         .toString())),





    return c;
  }
}
