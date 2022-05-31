import 'dart:ui';

import 'package:Cobi/Constants/constants.dart';
import 'package:Cobi/Widgets/widgets.dart';
import 'package:Cobi/controllers/api_controller.dart';
import 'package:Cobi/controllers/company_details_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

List industryitems = ["Manufacturing", "IT Industry"];
String? industrytypevalue;

List stateitems = [];
String? statevalue;

String? areavalue;
List Areaitems = [];

String? districtvalue;
List districtitems = [];

String? constitutionalue;
List constitutionitems = [];

String? areaidvalue;
List areaiditems = [];

class Companydetailsscreen extends StatefulWidget {
  Companydetailsscreen({Key? key}) : super(key: key);

  @override
  State<Companydetailsscreen> createState() => _CompanydetailsscreenState();
}

class _CompanydetailsscreenState extends State<Companydetailsscreen> {
  bool showloader = true;
  final GlobalKey<FormState> cdetailsformkey = new GlobalKey<FormState>();
  getstates() async {
    try {
      FormData formData = FormData();

      var rsp = await centreAPI("api/states", formData);

      // // debugPrint(rsp.toString());
      if (rsp.containsKey('status')) {
        if (rsp['status'].toString() == "1") {
          return rsp["data"];
        } else if (rsp['status'].toString() == "false") {
          if (rsp['error'].toString() == "invalid_auth") {}
        } else if (rsp['status'].toString() == "already_exist") {}
      }
    } catch (error, stacktrace) {
      // debugPrint('Stacktrace: ' + stacktrace.toString());
      // debugPrint(error.toString());
    }
  }

  getarea() async {
    try {
      FormData formData = FormData();

      var rsp = await centreAPI("api/area", formData);

      debugPrint(rsp.toString());
      if (rsp.containsKey('status')) {
        if (rsp['status'].toString() == "1") {
          setState(() {
            Areaitems = rsp["data"]["all_area"];
          });
        } else if (rsp['status'].toString() == "false") {
          if (rsp['error'].toString() == "invalid_auth") {}
        } else if (rsp['status'].toString() == "already_exist") {}
      }
    } catch (error, stacktrace) {
      // debugPrint('Stacktrace: ' + stacktrace.toString());
      // debugPrint(error.toString());
    }
  }

  getdistrict() async {
    try {
      FormData formData = FormData();

      var rsp = await centreAPI("api/district", formData);

      // // debugPrint(rsp.toString());
      if (rsp.containsKey('status')) {
        if (rsp['status'].toString() == "1") {
          return rsp["data"];
        } else if (rsp['status'].toString() == "false") {
          if (rsp['error'].toString() == "invalid_auth") {}
        } else if (rsp['status'].toString() == "already_exist") {}
      }
    } catch (error, stacktrace) {
      // debugPrint('Stacktrace: ' + stacktrace.toString());
      // debugPrint(error.toString());
    }
  }

  getconstitution() async {
    try {
      FormData formData = FormData();

      var rsp = await centreAPI("api/constitution", formData);

      // // debugPrint(rsp.toString());
      if (rsp.containsKey('status')) {
        if (rsp['status'].toString() == "1") {
          return rsp["data"];
        } else if (rsp['status'].toString() == "false") {
          if (rsp['error'].toString() == "invalid_auth") {}
        } else if (rsp['status'].toString() == "already_exist") {}
      }
    } catch (error, stacktrace) {
      // debugPrint('Stacktrace: ' + stacktrace.toString());
      // debugPrint(error.toString());
    }
  }

  var isapproved;
  void getcompanydetails() async {
    try {
      FormData formData = FormData();

      var rsp = await centreAPI("api/companydetails", formData);

      if (rsp.containsKey('status')) {
        debugPrint(rsp.toString());
        showloader = false;
        if (rsp['status'].toString() == "1") {
          setState(() {
            if (rsp['data']['industry_type'].toString() != '') {
              industrytypevalue = rsp['data']['industry_type'].toString();
            }
            if (rsp['data']['comp_constitution'].toString() != '') {
              constitutionalue = rsp['data']['comp_constitution'].toString();
            }
            if (rsp['data']['district'].toString() != '') {
              districtvalue = rsp['data']['district'].toString();
            }
            if (rsp['data']['state'].toString() != '') {
              statevalue = rsp['data']['state'].toString();
            }
            if (rsp['data']['area'].toString() != '') {
              areavalue = rsp['data']['area'].toString();
            }
            isapproved = rsp["data"]["is_aproved"];
            //
            debugPrint(isapproved);

            Cnamecontroller.text = rsp['data']['company_name'].toString();
            Cpancontroller.text = rsp['data']['company_pan'].toString();
            Cgstnocontroller.text = rsp['data']['company_gstn'].toString();
            Caddresscontroller.text = rsp['data']['company_address'].toString();
            CIECcontroller.text = rsp['data']['company_iec'].toString();
            Cudhyamregcontroller.text =
                rsp['data']['company_udhyam'].toString();
            Cudhyamaadharcontroller.text =
                rsp['data']['company_udhyamad'].toString();
            Cwebsitecontroller.text = rsp['data']['website'].toString();
          });
        } else if (rsp['status'].toString() == "false") {
          if (rsp['error'].toString() == "invalid_auth") {}
        } else if (rsp['status'].toString() == "already_exist") {}
      }
    } catch (error, stacktrace) {
      // debugPrint('Stacktrace: ' + stacktrace.toString());
      // debugPrint(error.toString());
    }
  }

  String? areadid;

  void updatecompanydetails() async {
    try {
      FormData formData = FormData();
      formData = FormData.fromMap({
        "industry_type": industrytypevalue,
        "comp_constitution": constitutionalue,
        "company_name": Cnamecontroller.text.toString(),
        "company_pan": Cpancontroller.text.toString(),
        "company_gstn": Cgstnocontroller.text.toString(),
        "company_address": Caddresscontroller.text.toString(),
        "district": districtvalue.toString(),
        "state": statevalue.toString(),
        "area_id": areadid.toString(),
      });
      debugPrint(Areaitems.toString());
      debugPrint(industrytypevalue.toString());
      debugPrint(constitutionalue.toString());
      debugPrint(Cindustrytypecontroller.text.toString());
      debugPrint(Cnamecontroller.text.toString());
      debugPrint(Cpancontroller.text.toString());
      debugPrint(Cgstnocontroller.text.toString());
      debugPrint(Caddresscontroller.text.toString());
      debugPrint(areadid.toString());

      var rsp = await centreAPI("api/editcompanydetails", formData);
      debugPrint(rsp.toString());
      if (rsp.containsKey('status')) {
        setState(() {
          showloader = false;
        });
        debugPrint(rsp.toString());

        if (rsp['status'].toString() == "1") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              behavior: SnackBarBehavior.floating, content: Text(rsp["msg"])));
        } else if (rsp['status'].toString() == "0") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              behavior: SnackBarBehavior.floating, content: Text(rsp["msg"])));
          if (rsp['error'].toString() == "invalid_auth") {}
        } else if (rsp['status'].toString() == "already_exist") {}
      }
    } catch (error, stacktrace) {
      // debugPrint('Stacktrace: ' + stacktrace.toString());
      // debugPrint(error.toString());
    }
  }

  bool isreadonly = true;
  @override
  void initState() {
    super.initState();
    setState(() {
      industrytypevalue = null;
      constitutionalue = null;
      districtvalue = null;
      statevalue = null;
      areavalue = null;
    });

    getstateslist();
    getdistrictlist();
    getarea();
    getconstitutionlist();
    getcompanydetails();
  }

  Future getstateslist() async {
    var abc = await getstates();
    if (abc.runtimeType == List<dynamic>) {
      setState(() {
        stateitems = abc;
      });
    }
  }

  Future getdistrictlist() async {
    var abc = await getdistrict();
    if (abc.runtimeType == List<dynamic>) {
      setState(() {
        districtitems = abc;
      });
    }
  }

  Future getconstitutionlist() async {
    var abc = await getconstitution();
    if (abc.runtimeType == List<dynamic>) {
      setState(() {
        constitutionitems = abc;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Company Details"),
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
                            "Company Details",
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
                                        if (cdetailsformkey.currentState!
                                                .validate() &&
                                            constitutionalue != null &&
                                            industrytypevalue != null &&
                                            areavalue != null &&
                                            districtvalue != null &&
                                            statevalue != null) {
                                          showloader = true;
                                          updatecompanydetails();

                                          setState(() {
                                            isreadonly = true;
                                          });
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  backgroundColor: Colors.black,
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
                      key: cdetailsformkey,
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
                                                'Industry Type *',
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
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: IgnorePointer(
                                                ignoring: isreadonly,
                                                child: DropdownButton(
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                    icon: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Icon(
                                                        Icons
                                                            .keyboard_arrow_down,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    underline: SizedBox(),
                                                    iconEnabledColor:
                                                        Colors.white,
                                                    iconDisabledColor:
                                                        Colors.white,
                                                    hint: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20),
                                                      child: Text(
                                                          "Select Industry Type",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black)),
                                                    ),
                                                    isExpanded: true,
                                                    value: industrytypevalue,
                                                    items: industryitems
                                                        .map((e) =>
                                                            DropdownMenuItem(
                                                                value: e,
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 10),
                                                                  child:
                                                                      Text(e),
                                                                )))
                                                        .toList(),
                                                    onChanged: (v) {
                                                      setState(() {
                                                        industrytypevalue =
                                                            v.toString();
                                                      });
                                                    }),
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
                                                'Constitution *',
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
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: IgnorePointer(
                                                ignoring: isreadonly,
                                                child: DropdownButton(
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                    icon: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Icon(
                                                        Icons
                                                            .keyboard_arrow_down,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    underline: SizedBox(),
                                                    iconEnabledColor:
                                                        Colors.white,
                                                    iconDisabledColor:
                                                        Colors.white,
                                                    hint: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10),
                                                      child: Text(
                                                          "Select Constitution",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black)),
                                                    ),
                                                    isExpanded: true,
                                                    value: constitutionalue,
                                                    items: constitutionitems
                                                        .map((e) =>
                                                            DropdownMenuItem(
                                                                value: e,
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 10),
                                                                  child:
                                                                      Text(e),
                                                                )))
                                                        .toList(),
                                                    onChanged: (v) {
                                                      setState(() {
                                                        constitutionalue =
                                                            v.toString();
                                                      });
                                                    }),
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
                                                controller: Cnamecontroller,
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
                                                'PAN No *',
                                                style: TextStyle(
                                                    fontSize: 13.sp,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
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
                                                controller: Cpancontroller,
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
                                                'GST No *',
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
                                                      value.length < 15 ||
                                                      value.length > 15) {
                                                    return "Gst No Should be 15-digit No";
                                                  }
                                                  ;
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
                                                controller: Cgstnocontroller,
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
                                                'Address *',
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
                                                controller: Caddresscontroller,
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
                                                'District *',
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
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: IgnorePointer(
                                                ignoring: isreadonly,
                                                child: DropdownButton(
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                    icon: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Icon(
                                                        Icons
                                                            .keyboard_arrow_down,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    underline: SizedBox(),
                                                    iconEnabledColor:
                                                        Colors.white,
                                                    iconDisabledColor:
                                                        Colors.white,
                                                    hint: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10),
                                                      child: Text(
                                                          "Select District",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black)),
                                                    ),
                                                    isExpanded: true,
                                                    value: districtvalue,
                                                    items: districtitems
                                                        .map((e) =>
                                                            DropdownMenuItem(
                                                                value: e,
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 10),
                                                                  child:
                                                                      Text(e),
                                                                )))
                                                        .toList(),
                                                    onChanged: (v) {
                                                      setState(() {
                                                        districtvalue =
                                                            v.toString();
                                                      });
                                                    }),
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
                                                'State *',
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
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: IgnorePointer(
                                                ignoring: isreadonly,
                                                child: DropdownButton(
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                    icon: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Icon(
                                                        Icons
                                                            .keyboard_arrow_down,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    underline: SizedBox(),
                                                    iconEnabledColor:
                                                        Colors.white,
                                                    iconDisabledColor:
                                                        Colors.white,
                                                    hint: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10),
                                                      child: Text(
                                                          "Select State",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black)),
                                                    ),
                                                    isExpanded: true,
                                                    value: statevalue,
                                                    items: stateitems
                                                        .map((e) =>
                                                            DropdownMenuItem(
                                                                value: e,
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 10),
                                                                  child:
                                                                      Text(e),
                                                                )))
                                                        .toList(),
                                                    onChanged: (v) {
                                                      setState(() {
                                                        statevalue =
                                                            v.toString();
                                                      });
                                                    }),
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
                                                'Area *',
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
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: IgnorePointer(
                                                ignoring: isreadonly,
                                                child: DropdownButton(
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                    icon: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Icon(
                                                        Icons
                                                            .keyboard_arrow_down,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    underline: SizedBox(),
                                                    iconEnabledColor:
                                                        Colors.white,
                                                    iconDisabledColor:
                                                        Colors.white,
                                                    hint: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10),
                                                      child: Text("Select Area",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black)),
                                                    ),
                                                    isExpanded: true,
                                                    value: areavalue,
                                                    items: Areaitems.map(
                                                        (e) => DropdownMenuItem(
                                                            value: e["area"],
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 10),
                                                              child: Text(
                                                                e["area"],
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            ))).toList(),
                                                    onChanged: (v) {
                                                      setState(() {
                                                        areavalue =
                                                            v.toString();
                                                        Areaitems.forEach(
                                                            (item) {
                                                          if (item['area']
                                                                  .toString()
                                                                  .toLowerCase() ==
                                                              v
                                                                  .toString()
                                                                  .toLowerCase()) {
                                                            setState(() {
                                                              debugPrint(item
                                                                  .toString());
                                                              areadid = item[
                                                                      'id']
                                                                  .toString();
                                                              debugPrint(areadid
                                                                  .toString());
                                                            });
                                                          }
                                                        });
                                                      });
                                                    }),
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
                                                'IEC Code',
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
                                                controller: CIECcontroller,
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
                                      boxShadow: []),
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
                                                    'Udhyam',
                                                    style: TextStyle(
                                                        fontSize: 13.sp,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Text(
                                                    'Reg. No.',
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
                                                controller:
                                                    Cudhyamregcontroller,
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
                                      boxShadow: []),
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
                                                    'Udhyam',
                                                    style: TextStyle(
                                                        fontSize: 13.sp,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Text(
                                                    'Aadhar No.',
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
                                                controller:
                                                    Cudhyamaadharcontroller,
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
                                      boxShadow: []),
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
                                                'Website',
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
                                                controller: Cwebsitecontroller,
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
