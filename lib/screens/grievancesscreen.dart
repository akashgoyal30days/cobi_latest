import 'dart:developer';

import 'package:Cobi/Constants/constants.dart';
import 'package:Cobi/controllers/api_controller.dart';
import 'package:Cobi/screens/addgrievancesscreen.dart';
import 'package:Cobi/screens/grievancesdetailsviewscreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class grievancesviewscreen extends StatefulWidget {
  const grievancesviewscreen({Key? key}) : super(key: key);

  @override
  State<grievancesviewscreen> createState() => _grievancesviewscreenState();
}

class _grievancesviewscreenState extends State<grievancesviewscreen> {
  @override
  void initState() {
    super.initState();
    fetchgrievancesdetails();
  }

  List GrievancesList = [];

  fetchgrievancesdetails() async {
    try {
      FormData formData = FormData();
      formData = FormData.fromMap({});

      var response = await centreAPI("api/allgrievances", formData);
      log(response.toString());
      if (response.containsKey("status")) {
        Navigator.pop(context);

        if (response["status"].toString() == "1") {
          GrievancesList = response["data"];
          setState(() {});
        } else {
          log("error");
        }
      }
    } catch (error) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Grievances"),
        centerTitle: true,
        backgroundColor: appbarbgcolor,
      ),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.black,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => addgrievancesscreen(),
                ));
          },
          label: Row(
            children: [
              Icon(FontAwesomeIcons.plus, size: 15),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text("Add New Grievances"),
              ),
            ],
          )),
      body: GrievancesList.isNotEmpty
          ? ListView.builder(
              itemCount: GrievancesList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                            height: 150,
                            child: Center(
                              child: Image.network(
                                "https://erp.cobijhajjar.org/" +
                                    GrievancesList[index]["image"],
                                fit: BoxFit.contain,
                                width: double.infinity,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                "Subject",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                GrievancesList[index]["subject"],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300),
                                maxLines: 2,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                "Posted On",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                GrievancesList[index]["dtime"]
                                    .toString()
                                    .substring(0, 11),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                "Queries",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  GrievancesList[index]["queries"],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                "Posted By",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  GrievancesList[index]["company_name"],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 260,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  textColor: Colors.white,
                                  color: Colors.black,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                grievancesdetailsviewscreen(
                                                  postedby:
                                                      GrievancesList[index]
                                                          ["company_name"],
                                                  grievanceimage:
                                                      "https://erp.cobijhajjar.org/" +
                                                          GrievancesList[index]
                                                              ["image"],
                                                  Grievanceid:
                                                      GrievancesList[index]
                                                          ["id"],
                                                  subject: GrievancesList[index]
                                                      ["subject"],
                                                  postedon:
                                                      GrievancesList[index]
                                                              ["dtime"]
                                                          .toString()
                                                          .substring(0, 11),
                                                  queries: GrievancesList[index]
                                                      ["queries"],
                                                ))));
                                  },
                                  child: Text("View Details"),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          : Center(
              child: Container(
                child: Text("No Data Available"),
              ),
            ),
    );
  }
}
