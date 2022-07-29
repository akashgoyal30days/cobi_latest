import 'dart:developer';

import 'package:Cobi/Constants/constants.dart';
import 'package:Cobi/controllers/api_controller.dart';
import 'package:Cobi/screens/dashboardscreen.dart';
import 'package:Cobi/screens/registrationscreen/registrationscreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class feedbackscreen extends StatefulWidget {
  const feedbackscreen({Key? key}) : super(key: key);

  @override
  State<feedbackscreen> createState() => _feedbackscreenState();
}

class _feedbackscreenState extends State<feedbackscreen> {
  TextEditingController subjectcontroller = TextEditingController();
  TextEditingController desciptioncontroller = TextEditingController();

  void sendfeedback() async {
    try {
      FormData formData = FormData();
      formData = FormData.fromMap({
        "subject": subjectcontroller.text.toString(),
        "description": desciptioncontroller.text.toString(),
      });

      var response = await centreAPI("api/addsuggestion", formData);
      log(response.toString());
      if (response.containsKey("status")) {
        Navigator.pop(context);
        if (response["status"].toString() == "1") {
          Future.delayed(Duration(seconds: 0), () {
            showcustomDailog(
                "Thankyou !!", "Your Feedback Recorded Successfully...");
          });
        } else {
          log("error");
        }
      }
      ;
    } catch (error) {}
  }

  void showcustomDailog(
    String title,
    String bodymessage,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
          ),
          content: Text(
            bodymessage,
            style: TextStyle(height: 1.5, fontWeight: FontWeight.w300),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              color: Colors.black,
              child: new Text(
                "Close",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => dashboard_screen()),
                    (route) => false);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Feedback"),
        centerTitle: true,
        backgroundColor: appbarbgcolor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(children: [
          Container(
            margin: EdgeInsets.all(5),
            child: Text(
              "Send Us Your Feedback !!",
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: EdgeInsets.all(5),
            child: Text(
              "Tell us your issue or any idea regarding to the service Or application..",
              style: TextStyle(
                  height: 1.2,
                  letterSpacing: 1.0,
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w300),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                child: Image.asset(
              "lib/assets/feedback.png",
              height: 200,
            )),
          ),
          Container(
            child: TextField(
              controller: subjectcontroller,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Subject...",
                  filled: true,
                  border: InputBorder.none,
                  fillColor: Colors.grey.shade200),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: TextField(
              controller: desciptioncontroller,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Description...",
                  filled: true,
                  border: InputBorder.none,
                  fillColor: Colors.grey.shade200),
              minLines: 6,
              maxLines: 6,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 50,
            child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                textColor: Colors.white,
                color: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Send Feedback",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      FontAwesomeIcons.paperPlane,
                      size: 20,
                    )
                  ],
                ),
                onPressed: () {
                  if (subjectcontroller.text.isNotEmpty &&
                      desciptioncontroller.text.isNotEmpty) {
                    showLoaderDialogwithName(context, "Sending....");
                    sendfeedback();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        padding: EdgeInsets.all(20),
                        backgroundColor: Colors.redAccent,
                        behavior: SnackBarBehavior.floating,
                        content: Text("Please fill all required fields..!!")));
                  }
                }),
          )
        ]),
      ),
    );
  }
}
