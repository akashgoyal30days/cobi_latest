import 'dart:developer';

import 'package:Cobi/Constants/constants.dart';
import 'package:Cobi/Widgets/descriptionfield.dart';
import 'package:Cobi/controllers/api_controller.dart';
import 'package:Cobi/screens/registrationscreen/registrationscreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class grievancesdetailsviewscreen extends StatefulWidget {
  final String subject;
  final String Grievanceid;
  final String grievanceimage;

  final String postedon;
  final String postedby;

  final String queries;

  const grievancesdetailsviewscreen(
      {Key? key,
      required this.subject,
      required this.postedon,
      required this.postedby,
      required this.queries,
      required this.Grievanceid,
      required this.grievanceimage})
      : super(key: key);

  @override
  State<grievancesdetailsviewscreen> createState() =>
      _grievancesdetailsviewscreenState();
}

class _grievancesdetailsviewscreenState
    extends State<grievancesdetailsviewscreen> {
  @override
  void initState() {
    super.initState();
    // viewallgrievancesmessages();
  }

  TextEditingController commentcontroller = TextEditingController();

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
                Navigator.pop(context);
                setState(() {});
              },
            ),
          ],
        );
      },
    );
  }

  List allgrievancesmessages = [];
  // viewallgrievancesmessages() async {
  //   try {
  //     FormData formData = FormData();
  //     formData = FormData.fromMap({});

  //     var response = await centreAPI("api/allgrievances", formData);
  //     log(response.toString());

  //     if (response.containsKey("status")) {
  //       if (response["status"].toString() == "1") {}
  //       // } else {
  //       //   if (response["status"].toString() == "0" &&
  //       //       response["error"]["message"].toString() ==
  //       //           "<p>The Message field is required.</p>") {
  //       //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       //         padding: EdgeInsets.all(20),
  //       //         backgroundColor: Colors.redAccent,
  //       //         behavior: SnackBarBehavior.floating,
  //       //         content: Text("Message Field is Required")));
  //       //   }
  //       // }
  //     }
  //   } catch (error) {
  //     log(error.toString());
  //   }
  // }

  addcommentongrievances() async {
    try {
      FormData formData = FormData();
      formData = FormData.fromMap(
          {"query_id": widget.Grievanceid, "comment": commentcontroller.text});

      var response = await centreAPI("api/addgrievancecomment", formData);
      log(response.toString());

      if (response.containsKey("status")) {
        Navigator.pop(context);
        if (response["status"].toString() == "1") {
          commentcontroller.clear();
          showcustomDailog("Success!!",
              "Comment Posted successfully\nscroll down to view all comments");
          setState(() {});
        } else {
          if (response["status"].toString() == "0" &&
              response["error"]["comment"].toString() ==
                  "<p>The Comment field is required.</p>") {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                padding: EdgeInsets.all(20),
                backgroundColor: Colors.redAccent,
                behavior: SnackBarBehavior.floating,
                content: Text("Comment field is Required")));
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
          title: Text("Grievances"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              Container(
                height: 150,
                child: Center(
                  child: Image.network(
                    widget.grievanceimage,
                    fit: BoxFit.contain,
                    width: double.infinity,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  "Subject",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  widget.subject,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w300),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  "Queries",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  widget.queries,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w300),
                ),
              ),
              Divider(),

              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  "Posted By",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  widget.postedby,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w300),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              descriptionfield(
                  inputController: commentcontroller,
                  hinttext: "Leave a Comment",
                  labeltext: "Comment *"),
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
                      addcommentongrievances();
                      showLoaderDialog(context);
                    },
                    child: Text("Leave a message"),
                    color: Colors.black,
                    textColor: Colors.white,
                  )),
              Divider(),
              // Container(
              //   height: 500,
              //   child: ListView.builder(
              //     itemCount: allgrievancesmessages.length,
              //     itemBuilder: (BuildContext context, int index) {
              //       return Padding(
              //         padding: const EdgeInsets.all(5.0),
              //         child: Container(
              //           height: 150,
              //           decoration: BoxDecoration(
              //               color: Colors.grey.shade200,
              //               borderRadius: BorderRadius.circular(10)),
              //           child: Padding(
              //             padding: const EdgeInsets.all(15.0),
              //             child: Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Text(
              //                   allgrievancesmessages[index]["company_name"],
              //                   style: TextStyle(
              //                       color: Colors.black,
              //                       fontWeight: FontWeight.w500),
              //                 ),
              //                 SizedBox(height: 10),
              //                 Expanded(
              //                   child: Text(
              //                     allgrievancesmessages[index]["message"],
              //                     style: TextStyle(
              //                         color: Colors.black,
              //                         fontWeight: FontWeight.w300),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ),
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
