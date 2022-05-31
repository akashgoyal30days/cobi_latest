import 'dart:developer';

import 'package:Cobi/Constants/constants.dart';
import 'package:Cobi/Widgets/descriptionfield.dart';
import 'package:Cobi/controllers/api_controller.dart';
import 'package:Cobi/screens/registrationscreen/registrationscreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class sendenquiryscreen extends StatefulWidget {
  final String productid;
  final String productimage;

  final String productName;
  final String SoldbyName;

  const sendenquiryscreen({
    Key? key,
    required this.productid,
    required this.productimage,
    required this.productName,
    required this.SoldbyName,
  }) : super(key: key);

  @override
  State<sendenquiryscreen> createState() => _sendenquiryscreenState();
}

class _sendenquiryscreenState extends State<sendenquiryscreen> {
  TextEditingController enquirymessagecontroller = TextEditingController();

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
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  sendproductenquiry() async {
    try {
      FormData formdata = FormData();
      formdata = FormData.fromMap({
        "product_id": widget.productid,
        "message": enquirymessagecontroller.text
      });

      var response = await centreAPI("api/add_enquiry", formdata);
      log(response.toString());

      if (response.containsKey("status")) {
        Navigator.pop(context);

        if (response["status"].toString() == "1") {
          showcustomDailog("ThankYou !", "Your Enquiry Posted Successfully");
          setState(() {
            enquirymessagecontroller.clear();
          });
        } else {
          if (response["status"].toString() == "0" &&
              response["error"]["message"].toString() ==
                  "<p>The Message field is required.</p>") {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                padding: EdgeInsets.all(20),
                backgroundColor: Colors.redAccent,
                behavior: SnackBarBehavior.floating,
                content: Text("Message Field is Required")));
          }
        }
      }
    } catch (error) {
      log(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: appbarbgcolor,
          title: Text("Send Enquiry"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              Container(
                child: Center(
                  child: Image(
                      height: 150,
                      image: NetworkImage("https://erp.cobijhajjar.org/" +
                          widget.productimage)),
                ),
              ),
              Text(
                "Enquiry For",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.productName,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w300),
              ),
              Divider(),
              Text(
                "Sold By",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.SoldbyName,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w300),
              ),
              Divider(),
              descriptionfield(
                  inputController: enquirymessagecontroller,
                  hinttext: "Enter Enquiry Message",
                  labeltext: "Message *"),
              SizedBox(
                height: 20,
              ),
              Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width - 50,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    onPressed: () {
                      sendproductenquiry();
                      showLoaderDialogwithName(context, "Sending..");
                    },
                    child: Text(" Send Enquiry "),
                    color: Colors.black,
                    textColor: Colors.white,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
