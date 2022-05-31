import 'package:Cobi/Constants/constants.dart';
import 'package:Cobi/Widgets/widgets.dart';
import 'package:Cobi/controllers/api_controller.dart';
import 'package:Cobi/controllers/registration_input_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    contentPadding: EdgeInsets.all(15),
    content: Row(
      children: [
        CircularProgressIndicator(
          color: Colors.black,
        ),
        Container(
            margin: EdgeInsets.only(left: 25),
            child: Text(
              "Loading...",
              style: TextStyle(fontWeight: FontWeight.w500),
            )),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showLoaderDialogwithName(BuildContext context, String message) {
  AlertDialog alert = AlertDialog(
    contentPadding: EdgeInsets.all(15),
    content: Row(
      children: [
        CircularProgressIndicator(
          color: Colors.black,
        ),
        Container(
            margin: EdgeInsets.only(left: 25),
            child: Text(
              message,
              style: TextStyle(fontWeight: FontWeight.w500),
            )),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class registrationscreen extends StatefulWidget {
  registrationscreen({Key? key}) : super(key: key);

  @override
  State<registrationscreen> createState() => _registrationscreenState();
}

class _registrationscreenState extends State<registrationscreen> {
  void register() async {
    showLoaderDialog(context);
    try {
      FormData formData = FormData();
      formData = FormData.fromMap({
        "industry_type": dropdownvalue.toString(),
        "company_name": companynamecontroller.text.toString(),
        "company_address": companyadresscontroller.text.toString(),
        "name": applicantnamecontroller.text.toString(),
        "designation": designationcontroller.text.toString(),
        "mobile_no": mobilenocontroller.text.toString(),
        "email_id": emailcontroller.text.toString(),
      });

      var rsp = await centreAPI("api/register", formData);
      debugPrint(rsp.toString());
      if (rsp.containsKey('status')) {
        if (rsp['status'].toString() == "1") {
          setState(() {
            dropdownvalue = null;
            companynamecontroller.clear();
            companyadresscontroller.clear();
            applicantnamecontroller.clear();
            designationcontroller.clear();
            designationcontroller.clear();
            mobilenocontroller.clear();
            emailcontroller.clear();
          });
          Navigator.pop(context);

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              padding: EdgeInsets.all(20),
              backgroundColor: Colors.green.shade800,
              behavior: SnackBarBehavior.floating,
              content: Text(
                "Registration Successful",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )));
        } else if (rsp['error']['email_id'].toString() ==
            "<p>The Email Id field must contain a unique value.</p>") {
          Navigator.pop(context);

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              padding: EdgeInsets.all(20),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.redAccent,
              content: Text(
                "Email Already Exist !!",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )));
          if (rsp['error'].toString() == "invalid_auth") {}
        } else if (rsp['status'].toString() == "already_exist") {}
      }
    } catch (error, stacktrace) {
      // // debugPrint('Stacktrace: ' + stacktrace.toString());
      // // debugPrint(error.toString());
    }
  }

  List dropdownitems = [
    "Manufacturing",
    "IT Industry",
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding:
              EdgeInsets.only(top: 40.w, left: 30.w, right: 30.w, bottom: 10.w),
          child: ListView(
            children: [
              Container(
                child: Padding(
                  padding: EdgeInsets.all(5.w),
                  child: Text(
                    "Register your account",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(width: 1.0, color: Colors.white)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 60),
                    child: DropdownButton(
                        dropdownColor: Colors.black,
                        style: TextStyle(color: Colors.white),
                        icon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.keyboard_arrow_down,
                          ),
                        ),
                        underline: SizedBox(),
                        iconEnabledColor: Colors.white,
                        iconDisabledColor: Colors.white,
                        hint: Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: Text("Select Industry Type",
                              style: TextStyle(color: Colors.grey)),
                        ),
                        isExpanded: true,
                        value: dropdownvalue,
                        items: dropdownitems
                            .map((e) =>
                                DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: (v) {
                          setState(() {
                            dropdownvalue = v.toString();
                          });
                        }),
                  ),
                ),
              ),
              SizedBox(
                height: 9.h,
              ),
              RectangleInputField(
                  hidedetails: false,
                  textEditingController: companynamecontroller,
                  icon: Icons.business,
                  hintText: "Company Name",
                  cursorColor: Colors.white,
                  iconColor: Colors.white,
                  editTextBackgroundColor: Colors.transparent),
              RectangleInputField(
                  hidedetails: false,
                  textEditingController: companyadresscontroller,
                  hintText: "Company Address",
                  icon: Icons.business_rounded,
                  cursorColor: Colors.white,
                  iconColor: Colors.white,
                  editTextBackgroundColor: Colors.transparent),
              RectangleInputField(
                  hidedetails: false,
                  textEditingController: applicantnamecontroller,
                  hintText: "Applicant Name",
                  icon: Icons.person,
                  cursorColor: Colors.white,
                  iconColor: Colors.white,
                  editTextBackgroundColor: Colors.transparent),
              RectangleInputField(
                  hidedetails: false,
                  textEditingController: designationcontroller,
                  hintText: "Designation",
                  icon: Icons.badge,
                  cursorColor: Colors.white,
                  iconColor: Colors.white,
                  editTextBackgroundColor: Colors.transparent),
              RectangleInputField(
                  // onchanged: (value) {
                  //   if (value.length == 10) {
                  //     return;
                  //   } else {
                  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //         backgroundColor: Colors.redAccent,
                  //         content: Text("Mobile No Should be 10 digit")));
                  //   }
                  // },
                  keyboardtype: TextInputType.number,
                  hidedetails: false,
                  textEditingController: mobilenocontroller,
                  hintText: "Mobile No (Whatsapp prefered)",
                  icon: Icons.phone,
                  cursorColor: Colors.white,
                  iconColor: Colors.white,
                  editTextBackgroundColor: Colors.transparent),
              RectangleInputField(
                  // onchanged: (v) {
                  //   if (v.contains("@")) {
                  //     return;
                  //   } else {
                  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //         backgroundColor: Colors.redAccent,
                  //         content: Text("Enter a valid Email Address")));
                  //   }
                  // },
                  keyboardtype: TextInputType.emailAddress,
                  hidedetails: false,
                  textEditingController: emailcontroller,
                  hintText: "Email Address",
                  icon: Icons.email,
                  cursorColor: Colors.white,
                  iconColor: Colors.white,
                  editTextBackgroundColor: Colors.transparent),
              SizedBox(
                height: 10.h,
              ),
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width * 0.80,
                child: RaisedButton(
                  elevation: 0,
                  textColor: primarytextcolor,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1.0, color: Colors.black),
                      borderRadius: BorderRadius.circular(5)),
                  onPressed: () {
                    if (dropdownvalue != null &&
                        companynamecontroller.text.isNotEmpty &&
                        companyadresscontroller.text.isNotEmpty &&
                        applicantnamecontroller.text.isNotEmpty &&
                        designationcontroller.text.isNotEmpty &&
                        mobilenocontroller.text.isNotEmpty &&
                        emailcontroller.text.isNotEmpty) {
                      register();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        padding: EdgeInsets.all(20),
                        behavior: SnackBarBehavior.floating,
                        content: Text(
                          "All fields are Required",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        backgroundColor: Colors.blue,
                      ));
                    }

                    if (mobilenocontroller.text.length == 10) {
                      return;
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          padding: EdgeInsets.all(20),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.redAccent,
                          content: Text("Mobile no should be 10 digit ")));
                    }

                    if (emailcontroller.text.contains("@")) {
                      return;
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          padding: EdgeInsets.all(20),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.redAccent,
                          content: Text("Enter a valid Email Address")));
                    }
                  },
                  child: Text(
                    "Register Now",
                    style: TextStyle(fontSize: 15.sp),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
