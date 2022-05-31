import 'dart:developer';

import 'package:Cobi/Constants/constants.dart';
import 'package:Cobi/controllers/api_controller.dart';
import 'package:Cobi/screens/addnewjobscreeen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_html/flutter_html.dart';

class jobportalscreen extends StatefulWidget {
  const jobportalscreen({Key? key}) : super(key: key);

  @override
  State<jobportalscreen> createState() => _jobportalscreenState();
}

class _jobportalscreenState extends State<jobportalscreen> {
  @override
  void initState() {
    super.initState();
    fetchjobpostdetails();
  }

  List jobpostdetails = [];
  fetchjobpostdetails() async {
    try {
      FormData formData = FormData();
      formData = FormData.fromMap({});

      var response = await centreAPI("api/jobs", formData);
      log(response.toString());
      if (response.containsKey("status")) {
        if (response["status"].toString() == "1") {
          jobpostdetails = response["data"];
          setState(() {});
        } else {
          log("error");
        }
      }
    } catch (error) {}
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.black,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => addnewjobscreen(),
                ));
          },
          label: Row(
            children: [
              Icon(FontAwesomeIcons.plus, size: 15),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text("Add New Job"),
              ),
            ],
          )),
      appBar: AppBar(
        backgroundColor: appbarbgcolor,
        centerTitle: true,
        title: Text("Job Section"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: jobpostdetails.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade300),
                child: Column(
                  children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Job Type :",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              jobpostdetails[index]["job_type"],
                              style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300),
                              maxLines: 3,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Eligibility :",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                                Html(
                                    data: jobpostdetails[index]
                                            ["job_description"]
                                        .toString()),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Date :",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  jobpostdetails[index]["dtime"],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  "Status :",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: jobpostdetails[index]["status"]
                                                  .toString() ==
                                              "1"
                                          ? Colors.green.shade200
                                          : Colors.red.shade200,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 2),
                                    child: Text(
                                      jobpostdetails[index]["status"]
                                                  .toString() ==
                                              "1"
                                          ? " Active "
                                          : " InActive ",
                                      style: TextStyle(
                                          color: jobpostdetails[index]["status"]
                                                      .toString() ==
                                                  "1"
                                              ? Colors.green.shade800
                                              : Colors.red.shade800,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ));
  }
}
