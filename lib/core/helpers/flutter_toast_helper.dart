import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FlutterToastHelper {

  static void showToast(String message,{ Color? color}) {

    Fluttertoast.showToast(

        msg: message,

        toastLength: Toast.LENGTH_SHORT,

        gravity: ToastGravity.TOP,

        timeInSecForIosWeb: 1,

        backgroundColor: color??Colors.green,

        textColor: Colors.white,

        fontSize: 16.0
    );
  }
}