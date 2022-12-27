import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;


import 'api_urls.dart';
// https://developers.shestel.com/api/providers-list
const baseUrl = 'http://166.62.35.48:8080/2019/Api/api.php';

class Webservices {
  static Future<Map> getData(String url, Map? data) async {
    var str="?";
    (data as Map<dynamic, dynamic>).forEach((key, value) {
      str=str+key+"="+value['value']+"&";
    });

    str=str+"m="+DateTime.now().millisecondsSinceEpoch.toString();
    Map response = {"status":"0","message":"Something went wrong"};
    log('called ------'+baseUrl+url+str);
    try {
      Map<String,String> h = {
        "Content-Type": "application/json"
      };
      // if(token!=''){
      //   h={
      //     'Authorization':"Bearer "+token,
      //     "Content-Type": "application/json"
      //   };
      //
      // }
      var res = await http.get(
        Uri.parse(baseUrl+url+str), headers: h
      );
      if(res.statusCode!=200){
        print('The response status for api action $baseUrl$url is ${res.statusCode}');

      }
      else{
        // log('suy in $url : ------ ${res.body}');
        response = jsonDecode(res.body);
      }
      // log(url+"-"+res.body);
    } catch (e) {
      // showSnackbar(context, text)
      log('Error in $url : ------ $e');
    }
    return response;
  }

  static Future<Map<String, dynamic>> postData(String url, Map? data, Map? files) async {
    var str="?";
    str=str+"m="+DateTime.now().millisecondsSinceEpoch.toString();
print('Uri.parse(baseUrl+url+str)----------------${Uri.parse(baseUrl+url+str)}');
    try {
      var request = new http.MultipartRequest("POST", Uri.parse(baseUrl+url+str));
      (data as Map<dynamic, dynamic>).forEach((key, value) {
        request.fields[key]=value['value'];
      });
      // print('request----------------${value['value']}');

      if (files != null) {
        (files as Map<dynamic, dynamic>).forEach((key, value) async {
          request.files.add(await http.MultipartFile.fromPath(key, value.path));
        });
      }
      Map<String,String>? h =  {
        "Accept":"application/json"
      };
      // if(token!='') {
      //   h['Authorization']="Bearer "+token;
      //   request.headers.addAll(h);
      // }
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      // log("mizan-check1"+response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      // if (jsonResponse['status'] == 200) {
      // } else {
      // }
      return jsonResponse;
      // return response;
    } catch (e) {

      log('mizan-check'+e.toString());

      return {'status': 0, 'message': "Please check your internet connection and try again!."};
      // return null;
    }
  }


}
