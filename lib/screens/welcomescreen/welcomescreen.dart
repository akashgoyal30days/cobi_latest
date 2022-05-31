import 'dart:ui';

import 'package:Cobi/Constants/constants.dart';
import 'package:Cobi/Widgets/widgets.dart';
import 'package:Cobi/screens/loginscreen/loginscreen.dart';
import 'package:Cobi/screens/registrationscreen/registrationscreen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_version/new_version.dart';

import '../../main.dart';

class welcome_screen extends StatefulWidget {
  welcome_screen({Key? key}) : super(key: key);

  @override
  State<welcome_screen> createState() => _registration_screenState();
}

class _registration_screenState extends State<welcome_screen> {
  void _checkVersion() async {
    final newVersion = NewVersion(
      androidId: "com.in30days.cobi",
    );
    final status = await newVersion.getVersionStatus();

    if (status!.localVersion != status.storeVersion) {
      newVersion.showUpdateDialog(
          context: context,
          versionStatus: status,
          dialogTitle: "New Update !!",
          dismissButtonText: "Skip",
          dialogText: "Please update the app from " +
              "${status.localVersion}" +
              " to " +
              "${status.storeVersion}",
          updateButtonText: "Update Now",
          dismissAction: () {
            Navigator.pop(context);
          });
    }
  }

  TextEditingController usernamecontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkVersion();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: EdgeInsets.all(20.w),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            FadeIn(
              duration: Duration(milliseconds: 800),
              child: Padding(
                padding: EdgeInsets.fromLTRB(40.w, 40.w, 40.w, 20.w),
                child: Image.asset(
                  "lib/assets/COBI.png",
                  width: MediaQuery.of(context).size.width * 0.80,
                  height: MediaQuery.of(context).size.height * 0.40,
                ),
              ),
            ),
            FadeIn(
              duration: Duration(milliseconds: 1200),
              child: Text(
                "Welcome to COBI",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
            FadeIn(
              duration: Duration(milliseconds: 1600),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.80,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.r)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => registrationscreen()));
                  },
                  child: Text(
                    "REGISTER NOW",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
            FadeIn(
              duration: Duration(milliseconds: 2000),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.80,
                child: RaisedButton(
                  textColor: Colors.white,
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1.0, color: Colors.white),
                      borderRadius: BorderRadius.circular(5)),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => loginscreen()));
                  },
                  child: Text(
                    "LOGIN NOW",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
