import 'dart:developer';

import 'package:Cobi/controllers/api_controller.dart';
import 'package:Cobi/screens/registrationscreen/registrationscreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class forgotscreen extends StatefulWidget {
  const forgotscreen({Key? key}) : super(key: key);

  @override
  State<forgotscreen> createState() => _forgotscreenState();
}

class _forgotscreenState extends State<forgotscreen> {
  TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                alignment: Alignment.center,
                child: Image.asset(
                  "lib/assets/COBI.png",
                  width: MediaQuery.of(context).size.width * 0.70,
                  height: MediaQuery.of(context).size.height * 0.30,
                ),
              ),
            ),
            Container(
              child: Text(
                "Reset Your Password..",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Text(
                "Enter Registered Email Address\nto Reset your Password",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w200,
                    color: Colors.white),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    fillColor: Colors.white,
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "Enter Registered Email..."),
                controller: passwordcontroller,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              child: RaisedButton(
                color: Colors.blue,
                onPressed: () {
                  resetpassword();
                },
                child: Text(
                  "Reset Password",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }

  Future<void> resetpassword() async {
    showLoaderDialog(context);
    try {
      FormData formData = FormData();
      formData = FormData.fromMap({
        "email_id": passwordcontroller.text.toString(),
      });

      var response = await centreAPI("api/forgotpassword", formData);
      log((response).toString());

      if (response.containsKey('status')) {
        Navigator.pop(context);
        if (response['status'].toString() == "1") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.blue,
              behavior: SnackBarBehavior.floating,
              content: Text(
                  "Password Reset Sucessfully \nNew Password Sent on Email and Whatsapp")));
        } else if (response['error']['email_id'].toString() ==
            "Invalid Username!") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.redAccent,
              behavior: SnackBarBehavior.floating,
              content: Text("The Username Doesn't Exist !!")));
        } else if (response['error']['email_id'].toString() ==
            "<p>The Email Id field must contain a valid email address.</p>") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.redAccent,
              behavior: SnackBarBehavior.floating,
              content: Text("Enter a valid Email Address")));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.redAccent,
              behavior: SnackBarBehavior.floating,
              content: Text("Email is Required")));
        }
      }
    } catch (error) {}
  }
}
