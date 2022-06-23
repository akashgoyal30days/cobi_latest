import 'dart:convert';
import 'dart:developer';
import 'package:Cobi/screens/Companydetailsscreen.dart';
import 'package:Cobi/Constants/constants.dart';
import 'package:Cobi/Widgets/widgets.dart';
import 'package:Cobi/controllers/api_controller.dart';
import 'package:Cobi/controllers/login_input_controller.dart';
import 'package:Cobi/screens/dashboardscreen.dart';
import 'package:Cobi/screens/forgotscreen.dart';
import 'package:Cobi/screens/registrationscreen/registrationscreen.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class loginscreen extends StatefulWidget {
  loginscreen({Key? key}) : super(key: key);

  @override
  State<loginscreen> createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {
  void userlogin() async {
    showLoaderDialog(context);
    try {
      FormData formData = new FormData();
      formData = FormData.fromMap({
        "username": loginusernamecontroller.text.toString(),
        "password": loginpasswordcontroller.text.toString(),
      });

      var rsp = await centreAPI("api/login", formData);
      debugPrint(jsonEncode(rsp).toString());
      if (rsp.containsKey('status')) {
        Navigator.pop(context);
        if (rsp['status'].toString() == '1') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              padding: EdgeInsets.all(20),
              backgroundColor: Colors.green.shade800,
              behavior: SnackBarBehavior.floating,
              content: Text("Login Successful")));

          SharedPreferences userdetails = await SharedPreferences.getInstance();
          userdetails.setString('userid', rsp['data']['id'].toString());
          userdetails.setString('uname', rsp['data']['username'].toString());
          userdetails.setString('level', rsp['data']['level'].toString());
          userdetails.setString('stt', rsp['data']['status'].toString());
          userdetails.setString(
              'is_approved', rsp['data']['is_approved'].toString());
          userdetails.setString(
              'device_token', rsp['data']['device_token'].toString());
          userdetails.setString(
              'pername', rsp['data']['per']['name'].toString());
          userdetails.setString(
              'desig', rsp['data']['per']['designation'].toString());
          userdetails.setString(
              'profile_pic', rsp['data']['per']['profile_pic'].toString());
          userdetails.setString(
              'company_id', rsp['data']['comp']['company_id'].toString());
          userdetails.setString(
              'industry_type', rsp['data']['comp']['industry_type'].toString());
          userdetails.setString(
              'company_name', rsp['data']['comp']['company_name'].toString());
          userdetails.setString('token', rsp['data']['token'].toString());
          userdetails.setString('logo', rsp['data']['comp']['logo'].toString());
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => dashboard_screen()),
              (Route<dynamic> route) => false);
          // Navigator.pushReplacement(context,
          //     MaterialPageRoute(builder: (context) => dashboard_screen()));
        } else if (rsp['error'].toString() == 'Invalid Username or Password') {
          log("Invalid Error");

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              padding: EdgeInsets.all(20),
              backgroundColor: Colors.redAccent,
              behavior: SnackBarBehavior.floating,
              content: Text("Invalid Username or Password !!")));
        } else if (rsp['error']['username'] ==
            '<p>The Username field must contain a valid email address.</p>') {
          log("Email Error");
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              padding: EdgeInsets.all(20),
              backgroundColor: Colors.redAccent,
              behavior: SnackBarBehavior.floating,
              content: Text("Enter a valid Email Address")));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              padding: EdgeInsets.all(20),
              backgroundColor: Colors.redAccent,
              behavior: SnackBarBehavior.floating,
              content: Text("Invalid Username Or Password !!")));
        }
      }
    } catch (error, stacktrace) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          padding: EdgeInsets.all(20),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
          content: Text("Error Please Check Details !!")));

      log(stacktrace.toString());

      debugPrint(error.toString());
    }
  }

  void glogin(String uname) async {
    showLoaderDialog(context);
    String token = "";
    try {
      FormData formData = new FormData();
      formData = FormData.fromMap({
        "username": uname.toString(),
        "type": "google",
      });

      var rsp = await centreAPI("api/googlelogin", formData);
      // debugPrint(rsp.toString());
      // debugPrint(jsonEncode(rsp).toString());
      if (rsp.containsKey('status')) {
        googlelogout();
        Navigator.pop(context);
        if (rsp['status'].toString() == '1') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.black,
              behavior: SnackBarBehavior.floating,
              content: Text("Login Successful")));
          // debugPrint(rsp['msg'].toString());
          SharedPreferences userdetails = await SharedPreferences.getInstance();
          userdetails.setString('userid', rsp['data']['id'].toString());
          userdetails.setString('uname', rsp['data']['username'].toString());
          userdetails.setString('level', rsp['data']['level'].toString());
          userdetails.setString('stt', rsp['data']['status'].toString());
          userdetails.setString(
              'is_approved', rsp['data']['is_approved'].toString());
          userdetails.setString(
              'device_token', rsp['data']['device_token'].toString());
          userdetails.setString(
              'pername', rsp['data']['per']['name'].toString());
          userdetails.setString(
              'desig', rsp['data']['per']['designation'].toString());
          userdetails.setString(
              'profile_pic', rsp['data']['per']['profile_pic'].toString());
          userdetails.setString(
              'company_id', rsp['data']['comp']['company_id'].toString());
          userdetails.setString(
              'industry_type', rsp['data']['comp']['industry_type'].toString());
          userdetails.setString(
              'company_name', rsp['data']['comp']['company_name'].toString());
          userdetails.setString('token', rsp['data']['token'].toString());
          userdetails.setString('logo', rsp['data']['comp']['logo'].toString());
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => dashboard_screen()),
              (Route<dynamic> route) => false);
          // Navigator.pushReplacement(context,
          //     MaterialPageRoute(builder: (context) => dashboard_screen()));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.blue,
              behavior: SnackBarBehavior.floating,
              content: Text("Login Failed! Try again...")));
        }
      }
    } catch (error, stacktrace) {
      googlelogout();
      setState(() {});
      // debugPrint('Stacktrace: ' + stacktrace.toString());
      // debugPrint(error.toString());
    }
  }

  googlelogin() async {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      log("googleresult".toString());

      var googleresult = await _googleSignIn.signIn();

      if (googleresult == null) {
        return;
      }

      final userData = await googleresult.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: userData.accessToken, idToken: userData.idToken);
      var finalResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
      log("Google Result");
      log("Result $googleresult");
      log(googleresult.displayName.toString());
      log(googleresult.email.toString());

      if (googleresult.email != null) {
        glogin(googleresult.email);
      } else {
        googlelogout();
      }
      debugPrint(googleresult.photoUrl);
    } catch (error) {
      log(error.toString());
    }
  }

  Future<void> googlelogout() async {
    await GoogleSignIn().disconnect();
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.only(top: 30.w, left: 30.w, right: 30.w),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(40.w, 30.w, 40.w, 10.w),
              child: Image.asset(
                "lib/assets/COBI.png",
                width: MediaQuery.of(context).size.width * 0.70,
                height: MediaQuery.of(context).size.height * 0.30,
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.all(5.w),
                child: Text(
                  "Login to your account",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            RectangleInputField(
                hidedetails: false,
                textEditingController: loginusernamecontroller,
                hintText: "Username",
                icon: Icons.person,
                cursorColor: Colors.white,
                iconColor: Colors.white,
                editTextBackgroundColor: Colors.transparent),
            RectangleInputField(
              hidedetails: true,
              textEditingController: loginpasswordcontroller,
              icon: Icons.vpn_key,
              hintText: "Password",
              cursorColor: Colors.white,
              iconColor: Colors.white,
              editTextBackgroundColor: Colors.transparent,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 2, 5, 10),
              child: Container(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => forgotscreen()));
                  },
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Container(
              height: 35,
              width: MediaQuery.of(context).size.width * 0.80,
              child: RaisedButton(
                elevation: 0,
                textColor: primarytextcolor,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1.0, color: Colors.black),
                    borderRadius: BorderRadius.circular(5)),
                onPressed: () {
                  if (loginusernamecontroller.text.isNotEmpty &&
                      loginpasswordcontroller.text.isNotEmpty) {
                    userlogin();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.white,
                        behavior: SnackBarBehavior.floating,
                        content: Text(
                          "Please fill login details",
                          style: TextStyle(color: Colors.black),
                        )));
                  }
                },
                child: Text(
                  "Login Now",
                  style: TextStyle(fontSize: 15.sp),
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Container(
              height: 35,
              width: MediaQuery.of(context).size.width * 0.80,
              child: RaisedButton(
                elevation: 0,
                textColor: primarytextcolor,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1.0, color: Colors.black),
                    borderRadius: BorderRadius.circular(5)),
                onPressed: () {
                  googlelogin();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "lib/assets/google_icon.png",
                      width: 45,
                      height: 45,
                    ),
                    Text(
                      "Google Sign in",
                      style: TextStyle(fontSize: 15.sp),
                    ),
                    SizedBox(
                      width: 20,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SignInWithAppleButton(
              borderRadius: BorderRadius.circular(5),
              height: 30,
              style: SignInWithAppleButtonStyle.whiteOutlined,
              onPressed: () async {
                final credential = await SignInWithApple.getAppleIDCredential(
                  scopes: [
                    AppleIDAuthorizationScopes.email,
                    AppleIDAuthorizationScopes.fullName,
                  ],
                );

                log(credential.email.toString());
                
                glogin(credential.email.toString());

                // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
                // after they have been validated with Apple (see `Integration` section for more information on how to do this)
              },
            ),
            // Container(
            //   height: 30,
            //   width: MediaQuery.of(context).size.width * 0.80,
            //   child: RaisedButton(
            //     elevation: 0,
            //     textColor: primarytextcolor,
            //     color: Colors.grey,
            //     shape: RoundedRectangleBorder(
            //         side: BorderSide(width: 1.0, color: Colors.black),
            //         borderRadius: BorderRadius.circular(5)),
            //     onPressed: () {
            //       googlelogin();
            //     },
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Image.asset(
            //           "lib/assets/apple.png",
            //           width: 45,
            //           height: 45,
            //         ),
            //         Text(
            //           "Apple Sign in",
            //           style: TextStyle(fontSize: 15.sp),
            //         ),
            //         SizedBox(
            //           width: 20,
            //         )
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
