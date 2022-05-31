import 'dart:developer';

import 'package:Cobi/Constants/constants.dart';
import 'package:Cobi/Widgets/descriptionfield.dart';
import 'package:Cobi/Widgets/inputfield.dart';
import 'package:Cobi/controllers/api_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class addnewjobscreen extends StatefulWidget {
  addnewjobscreen({Key? key}) : super(key: key);

  @override
  State<addnewjobscreen> createState() => _addnewjobscreenState();
}

class _addnewjobscreenState extends State<addnewjobscreen> {
  TextEditingController job_titlecontroller = TextEditingController();
  TextEditingController job_desciptioncontroller = TextEditingController();
  TextEditingController job_eligibilitycontroller = TextEditingController();

  void addnewjob() async {
    try {
      FormData formData = FormData();
      formData = FormData.fromMap({
        "job_type": job_titlecontroller.text.toString(),
        "job_description": job_desciptioncontroller.text.toString(),
        "eligibility": job_eligibilitycontroller.text.toString(),
      });

      var response = await centreAPI("api/addsuggestion", formData);
      log(response.toString());
      if (response.containsKey("status")) {
        Navigator.pop(context);
        if (response["status"].toString() == "1") {
        } else {
          log("error");
        }
      }
      ;
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          padding: EdgeInsets.all(20),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
          content: Text(error.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: appbarbgcolor,
        centerTitle: true,
        title: Text("Add New Job"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            inputfield(
                keyboardtype: TextInputType.emailAddress,
                inputController: job_titlecontroller,
                hinttext: "Enter Job Title.....",
                labeltext: "Job Title *"),
            SizedBox(
              height: 15,
            ),
            descriptionfield(
                inputController: job_desciptioncontroller,
                hinttext: "Enter Job Desciption.....",
                labeltext: "Description *"),
            SizedBox(
              height: 15,
            ),
            descriptionfield(
                inputController: job_eligibilitycontroller,
                hinttext: "Enter Eligibility Criteria.....",
                labeltext: "Eligibility *"),
            SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Colors.black,
                      textColor: Colors.white,
                      child: Text("Save"),
                      onPressed: () {
                        if (job_titlecontroller.text.isNotEmpty &&
                            job_desciptioncontroller.text.isNotEmpty &&
                            job_eligibilitycontroller.text.isNotEmpty) {
                          addnewjob();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              padding: EdgeInsets.all(20),
                              backgroundColor: Colors.redAccent,
                              behavior: SnackBarBehavior.floating,
                              content:
                                  Text("Please Fill All Required Fields...")));
                        }
                      }),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
