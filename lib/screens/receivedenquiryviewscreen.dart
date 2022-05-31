import 'dart:developer';

import 'package:Cobi/Constants/constants.dart';
import 'package:Cobi/controllers/api_controller.dart';
import 'package:Cobi/screens/receivedenquirydetailsviewscreen.dart';
import 'package:Cobi/screens/registrationscreen/registrationscreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class receivedenquiryviewscreen extends StatefulWidget {
  const receivedenquiryviewscreen({Key? key}) : super(key: key);

  @override
  State<receivedenquiryviewscreen> createState() =>
      _receivedenquiryviewscreenState();
}

class _receivedenquiryviewscreenState extends State<receivedenquiryviewscreen> {
  @override
  void initState() {
    super.initState();
    fetchreceivedenquiries();
  }

  List EnquiryList = [];
  fetchreceivedenquiries() async {
    FormData formData = FormData();
    formData = FormData.fromMap({});

    try {
      var response = await centreAPI("api/enquiries_received", formData);
      if (response.containsKey("status")) {
        Navigator.pop(context);

        if (response["status"].toString() == "1") {
          EnquiryList = response["data"]["enquiry"];
          log(EnquiryList.isEmpty.toString());

          setState(() {});
        } else {}
      }

      log(response.toString());
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
        title: Text("Received Enquiries"),
      ),
      body: EnquiryList.isNotEmpty.toString() == "true"
          ? ListView.builder(
              itemCount: EnquiryList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade300),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.black,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: Text(
                                    " Enquiry ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                            Html(
                                data: EnquiryList[index]["enquiry"]
                                        .toString()
                                        .substring(3, 150) +
                                    "..."),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.black,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: Text(
                                    " Company Name ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: Text(
                                    EnquiryList[index]["company_name"],
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.black,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: Text(
                                    " Posted On ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: Text(
                                    EnquiryList[index]["dtime"]
                                        .toString()
                                        .substring(0, 11),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 260,
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    textColor: Colors.white,
                                    color: Colors.black,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: ((context) =>
                                                  receivedenquiriesdetailsviewscreen(
                                                    enquiryid:
                                                        EnquiryList[index]
                                                            ["id"],
                                                    companyName:
                                                        EnquiryList[index]
                                                            ["company_name"],
                                                    Enquirydescription:
                                                        EnquiryList[index]
                                                            ["enquiry"],
                                                  ))));
                                    },
                                    child: Text("View Details"),
                                  ),
                                ),
                              ],
                            ),
                          ]),
                    ),
                  ),
                );
              },
            )
          : Center(
              child: Container(
              child: Text(
                "No Data Available",
              ),
            )),
    ));
  }
}
