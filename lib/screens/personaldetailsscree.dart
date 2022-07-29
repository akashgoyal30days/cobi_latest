import 'package:Cobi/Constants/constants.dart';
import 'package:Cobi/Widgets/widgets.dart';
import 'package:Cobi/controllers/api_controller.dart';
import 'package:Cobi/controllers/personal_details_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class personaldetailscreen extends StatefulWidget {
  personaldetailscreen({Key? key}) : super(key: key);

  @override
  State<personaldetailscreen> createState() => _profiledetailsscreenState();
}

class _profiledetailsscreenState extends State<personaldetailscreen> {
  bool showloader = true;

  var isapproved;

  void getpersonaldetails() async {
    try {
      FormData formData = FormData();

      var rsp = await centreAPI("api/personaldetails", formData);

      debugPrint(rsp.toString());
      if (rsp.containsKey('status')) {
        if (rsp['status'].toString() == "1") {
          setState(() {
            Pnamecontroller.text = (rsp['data']['name']).toString();
            Pfathernamecontroller.text =
                (rsp['data']['father_name']).toString();

            Pdesignationcontroller.text =
                (rsp['data']['designation']).toString();
            PPancontroller.text = (rsp['data']['pan']).toString();
            Paadharcontroller.text = (rsp['data']['aadhar']).toString();
            Pdobcontroller.text = (rsp['data']['dob']).toString();
            Pmobnocontroller.text = (rsp['data']['mobile_no']).toString();
            Pmobile2controller.text = (rsp['data']['mobile_no2']).toString();

            Pemailcontroller.text = (rsp['data']['email_id']).toString();
            Pemail2controller.text = (rsp['data']['email_id2']).toString();

            Ppermntaddrescontroller.text =
                (rsp['data']['permanent_address']).toString();
            Pcrsaddrescontroller.text =
                (rsp['data']['correspondance_address']).toString();
            isapproved = rsp["data"]["is_aproved"];
          });
          showloader = false;
        } else if (rsp['status'].toString() == "false") {
          if (rsp['error'].toString() == "invalid_auth") {}
        } else if (rsp['status'].toString() == "already_exist") {}
      }
    } catch (error) {
      // debugPrint('Stacktrace: ' + stacktrace.toString());
      // debugPrint(error.toString());
    }
  }

  void updatepersonaldetails() async {
    try {
      FormData formData = FormData();
      formData = FormData.fromMap({
        "name": Pnamecontroller.text.toString(),
        "father_name": Pfathernamecontroller.text.toString(),
        "designation": Pdesignationcontroller.text.toString(),
        "pan": PPancontroller.text.toString(),
        "aadhar": Paadharcontroller.text.toString(),
        "dob": Pdobcontroller.text.toString(),
        "mobile_no": Pmobnocontroller.text.toString(),
        "mobile_no2": Pmobile2controller.text.toString(),
        "email_id": Pemailcontroller.text.toString(),
        "email_id2": Pemail2controller.text.toString(),
        "permanent_address": Ppermntaddrescontroller.text.toString(),
        "correspondance_address": Pcrsaddrescontroller.text.toString(),
      });

      var rsp = await centreAPI("api/editpersonaldetails", formData);
      // debugPrint(rsp.toString());
      if (rsp.containsKey('status')) {
        setState(() {
          showloader = false;
        });
        if (rsp['status'].toString() == "1") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text(rsp["msg"].toString())));
        } else if (rsp['status'].toString() == "0") {
          if (rsp['error'].toString() == "invalid_auth") {}
        } else if (rsp['status'].toString() == "already_exist") {}
      }
    } catch (error) {
      // debugPrint('Stacktrace: ' + stacktrace.toString());
      // debugPrint(error.toString());
    }
  }

  final perdetailskey = GlobalKey<FormState>();

  bool isreadonly = true;
  @override
  void initState() {
    super.initState();

    getpersonaldetails();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Personal Details"),
          backgroundColor: appbarbgcolor,
        ),
        drawer: Navigationdrawer(),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(10.w),
            child: Padding(
              padding: EdgeInsets.all(8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10.0),
                          topLeft: Radius.circular(10.0)),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Personal Details",
                            style: TextStyle(
                                color: primarytextcolor,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w400),
                          ),
                          isapproved == "0"
                              ? isreadonly == true
                                  ? FlatButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      onPressed: () {
                                        setState(() {
                                          isreadonly = false;
                                        });
                                      },
                                      child: Text("Edit"),
                                      color: Colors.black,
                                      textColor: Colors.white,
                                    )
                                  : FlatButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      onPressed: () {
                                        if (perdetailskey.currentState!
                                            .validate()) {
                                          showloader = true;
                                          updatepersonaldetails();

                                          setState(() {
                                            isreadonly = true;
                                          });
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  content: Text(
                                                      "Please Fill All Required Fields")));
                                        }
                                      },
                                      child: Text("Save"),
                                      color: Colors.black,
                                      textColor: Colors.white,
                                    )
                              : SizedBox()
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Form(
                      key: perdetailskey,
                      child: showloader == true
                          ? Center(
                              child: CircularProgressIndicator(
                                color: Colors.black,
                              ),
                            )
                          : ListView(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.w),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 120.w,
                                            child: Padding(
                                              padding: EdgeInsets.all(15.w),
                                              child: Text(
                                                'Name *',
                                                style: TextStyle(
                                                    fontSize: 13.sp,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Expanded(
                                            child: Container(
                                              child: TextFormField(
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Field is Required";
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: isreadonly ==
                                                                    true
                                                                ? Colors
                                                                    .transparent
                                                                : Colors
                                                                    .black))),
                                                readOnly: isreadonly,
                                                controller: Pnamecontroller,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.w),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 120.w,
                                            child: Padding(
                                              padding: EdgeInsets.all(15.w),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Father's",
                                                    style: TextStyle(
                                                        fontSize: 13.sp,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Text(
                                                    "Name *",
                                                    style: TextStyle(
                                                        fontSize: 13.sp,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Expanded(
                                            child: Container(
                                              child: TextFormField(
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Field is Required";
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: isreadonly ==
                                                                    true
                                                                ? Colors
                                                                    .transparent
                                                                : Colors
                                                                    .black))),
                                                readOnly: isreadonly,
                                                controller:
                                                    Pfathernamecontroller,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.white, boxShadow: []),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.w),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 120.w,
                                            child: Padding(
                                              padding: EdgeInsets.all(15.w),
                                              child: Text(
                                                'Designation *',
                                                style: TextStyle(
                                                    fontSize: 13.sp,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Expanded(
                                            child: Container(
                                              child: TextFormField(
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Field is Required";
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: isreadonly ==
                                                                    true
                                                                ? Colors
                                                                    .transparent
                                                                : Colors
                                                                    .black))),
                                                readOnly: isreadonly,
                                                controller:
                                                    Pdesignationcontroller,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.white, boxShadow: []),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.w),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 120.w,
                                            child: Padding(
                                              padding: EdgeInsets.all(15.w),
                                              child: Text(
                                                'PAN *',
                                                style: TextStyle(
                                                    fontSize: 13.sp,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Expanded(
                                            child: Container(
                                              child: TextFormField(
                                                validator: (value) {
                                                  if (value!.isEmpty ||
                                                      value.length < 10 ||
                                                      value.length > 10) {
                                                    return "PAN No Should be 10-digit No";
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: isreadonly ==
                                                                    true
                                                                ? Colors
                                                                    .transparent
                                                                : Colors
                                                                    .black))),
                                                readOnly: isreadonly,
                                                controller: PPancontroller,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.white, boxShadow: []),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.w),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 120.w,
                                            child: Padding(
                                              padding: EdgeInsets.all(15.w),
                                              child: Text(
                                                'Aadhar *',
                                                style: TextStyle(
                                                    fontSize: 13.sp,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Expanded(
                                            child: Container(
                                              child: TextFormField(
                                                validator: (value) {
                                                  if (value!.isEmpty ||
                                                      value.length < 12 ||
                                                      value.length > 12) {
                                                    return "Aadhar No Should be 12-digit No";
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: isreadonly ==
                                                                    true
                                                                ? Colors
                                                                    .transparent
                                                                : Colors
                                                                    .black))),
                                                readOnly: isreadonly,
                                                controller: Paadharcontroller,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(10.0),
                                        bottomLeft: Radius.circular(10.0)),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.w),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 120.w,
                                            child: Padding(
                                              padding: EdgeInsets.all(15.w),
                                              child: Text(
                                                'D.O.B *',
                                                style: TextStyle(
                                                    fontSize: 13.sp,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Expanded(
                                            child: Container(
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: isreadonly ==
                                                                    true
                                                                ? Colors
                                                                    .transparent
                                                                : Colors
                                                                    .black))),
                                                readOnly: isreadonly,
                                                controller: Pdobcontroller,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.w),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 120.w,
                                            child: Padding(
                                              padding: EdgeInsets.all(15.w),
                                              child: Text(
                                                'Mobile No *',
                                                style: TextStyle(
                                                    fontSize: 13.sp,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Expanded(
                                            child: Container(
                                              child: TextFormField(
                                                validator: (value) {
                                                  if (value!.isEmpty ||
                                                      value.length < 10 ||
                                                      value.length > 10) {
                                                    return "Mobile No Should be 10 digit No";
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: isreadonly ==
                                                                    true
                                                                ? Colors
                                                                    .transparent
                                                                : Colors
                                                                    .black))),
                                                readOnly: isreadonly,
                                                controller: Pmobnocontroller,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.w),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 120.w,
                                            child: Padding(
                                              padding: EdgeInsets.all(15.w),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Alternate',
                                                    style: TextStyle(
                                                        fontSize: 13.sp,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Text(
                                                    'Mobile No',
                                                    style: TextStyle(
                                                        fontSize: 13.sp,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Expanded(
                                            child: Container(
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: isreadonly ==
                                                                    true
                                                                ? Colors
                                                                    .transparent
                                                                : Colors
                                                                    .black))),
                                                readOnly: isreadonly,
                                                controller: Pmobile2controller,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.w),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 120.w,
                                            child: Padding(
                                              padding: EdgeInsets.all(15.w),
                                              child: Text(
                                                'Email id *',
                                                style: TextStyle(
                                                    fontSize: 13.sp,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Expanded(
                                            child: Container(
                                              child: TextFormField(
                                                minLines: 2,
                                                maxLines: 2,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Enter a Valid Email id ";
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: isreadonly ==
                                                                    true
                                                                ? Colors
                                                                    .transparent
                                                                : Colors
                                                                    .black))),
                                                readOnly: isreadonly,
                                                controller: Pemailcontroller,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.w),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 120.w,
                                            child: Padding(
                                              padding: EdgeInsets.all(15.w),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Alternate',
                                                    style: TextStyle(
                                                        fontSize: 13.sp,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Text(
                                                    'Email id',
                                                    style: TextStyle(
                                                        fontSize: 13.sp,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Expanded(
                                            child: Container(
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: isreadonly ==
                                                                    true
                                                                ? Colors
                                                                    .transparent
                                                                : Colors
                                                                    .black))),
                                                readOnly: isreadonly,
                                                controller: Pemail2controller,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.w),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 120.w,
                                            child: Padding(
                                              padding: EdgeInsets.all(15.w),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Permanent',
                                                    style: TextStyle(
                                                        fontSize: 13.w,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Text(
                                                    'Address',
                                                    style: TextStyle(
                                                        fontSize: 13.w,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Expanded(
                                            child: Container(
                                              child: TextFormField(
                                                minLines: 2,
                                                maxLines: 5,
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: isreadonly ==
                                                                    true
                                                                ? Colors
                                                                    .transparent
                                                                : Colors
                                                                    .black))),
                                                readOnly: isreadonly,
                                                controller:
                                                    Ppermntaddrescontroller,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.w),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 120.w,
                                            child: Padding(
                                              padding: EdgeInsets.all(15.w),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Corres.',
                                                    style: TextStyle(
                                                        fontSize: 13.sp,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Text(
                                                    'Address',
                                                    style: TextStyle(
                                                        fontSize: 13.sp,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Expanded(
                                            child: Container(
                                              child: TextFormField(
                                                minLines: 2,
                                                maxLines: 5,
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: isreadonly ==
                                                                    true
                                                                ? Colors
                                                                    .transparent
                                                                : Colors
                                                                    .black))),
                                                readOnly: isreadonly,
                                                controller:
                                                    Pcrsaddrescontroller,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
