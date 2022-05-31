import 'dart:developer';

import 'package:Cobi/Constants/constants.dart';
import 'package:Cobi/Widgets/descriptionfield.dart';
import 'package:Cobi/controllers/api_controller.dart';
import 'package:Cobi/screens/registrationscreen/registrationscreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class sentenquiriesdetailsviewscreen extends StatefulWidget {
  final String enquiryid;
  final String companyName;
  final String Enquirydescription;

  const sentenquiriesdetailsviewscreen(
      {Key? key,
      required this.companyName,
      required this.Enquirydescription,
      required this.enquiryid})
      : super(key: key);

  @override
  State<sentenquiriesdetailsviewscreen> createState() =>
      _sentenquiriesdetailsviewscreenState();
}

class _sentenquiriesdetailsviewscreenState
    extends State<sentenquiriesdetailsviewscreen> {
  @override
  void initState() {
    super.initState();
    viewallenquirymessages();
  }

  TextEditingController leavemessagecontroller = TextEditingController();

  void showcustomDailog(
    String title,
    String bodymessage,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            title,
          ),
          content: new Text(bodymessage),
          actions: <Widget>[
            new FlatButton(
              color: Colors.black,
              child: new Text(
                "Close",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                viewallenquirymessages();
                Navigator.pop(context);
                setState(() {});
              },
            ),
          ],
        );
      },
    );
  }

  List AllEnquirymessages = [];
  viewallenquirymessages() async {
    try {
      FormData formData = FormData();
      formData = FormData.fromMap({
        "enquiry_id": widget.enquiryid,
      });

      var response = await centreAPI("api/enquiry_messages", formData);
      log(response.toString());

      if (response.containsKey("status")) {
        if (response["status"].toString() == "1") {
          AllEnquirymessages = response["data"]["messages"];
          setState(() {});
        }
        // } else {
        //   if (response["status"].toString() == "0" &&
        //       response["error"]["message"].toString() ==
        //           "<p>The Message field is required.</p>") {
        //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //         padding: EdgeInsets.all(20),
        //         backgroundColor: Colors.redAccent,
        //         behavior: SnackBarBehavior.floating,
        //         content: Text("Message Field is Required")));
        //   }
        // }
      }
    } catch (error) {
      log(error.toString());
    }
  }

  addmessageonenquiry() async {
    try {
      FormData formData = FormData();
      formData = FormData.fromMap({
        "enquiry_id": widget.enquiryid,
        "message": leavemessagecontroller.text
      });

      var response = await centreAPI("api/add_enquiry_message", formData);
      log(response.toString());

      if (response.containsKey("status")) {
        Navigator.pop(context);

        if (response["status"].toString() == "1") {
          leavemessagecontroller.clear();
          showcustomDailog("Success!!",
              "Message added successfully\n\nScroll down to view all messages");
          setState(() {});
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
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  "Enquiry To",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  widget.companyName,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w300),
                  maxLines: 2,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  "Enquiry",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Html(data: widget.Enquirydescription),
              Divider(),
              descriptionfield(
                  inputController: leavemessagecontroller,
                  hinttext: "Leave a message",
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
                      addmessageonenquiry();
                      showLoaderDialog(context);
                    },
                    child: Text("Leave a message"),
                    color: Colors.black,
                    textColor: Colors.white,
                  )),
              Divider(),
              Container(
                height: 500,
                child: ListView.builder(
                  itemCount: AllEnquirymessages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AllEnquirymessages[index]["company_name"],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 10),
                              Expanded(
                                child: Text(
                                  AllEnquirymessages[index]["message"],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
