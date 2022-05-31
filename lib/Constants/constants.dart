import 'package:flutter/material.dart';

class SecureConst {
  static String baseurl = "https://erp.cobijhajjar.org/";
  static String Clientsecret = "fashgf12346@#*&^k1NBRt";
  static String ClientID = "COBIAPP";
}

final Color primarytextcolor = Colors.black;
final Color primaryiconcolor = Colors.black;

final Color appbarbgcolor = Colors.black;

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
