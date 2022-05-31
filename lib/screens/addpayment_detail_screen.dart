import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:Cobi/Constants/constants.dart';
import 'package:Cobi/Widgets/descriptionfield.dart';
import 'package:Cobi/Widgets/inputfield.dart';
import 'package:Cobi/controllers/api_controller.dart';
import 'package:Cobi/screens/registrationscreen/registrationscreen.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';

class addpaymentdeyailsscreen extends StatefulWidget {
  addpaymentdeyailsscreen({Key? key}) : super(key: key);

  @override
  State<addpaymentdeyailsscreen> createState() =>
      _addpaymentdeyailsscreenState();
}

class _addpaymentdeyailsscreenState extends State<addpaymentdeyailsscreen> {
  TextEditingController banknamecontroller = TextEditingController();
  TextEditingController chequenumbercontroller = TextEditingController();
  TextEditingController chequeamountcontroller = TextEditingController();

  DateTime currentDate = DateTime.now();
  Future<void> select_cheque_Date(BuildContext context) async {
    final DateTime? pickedchequeDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedchequeDate != null && pickedchequeDate != currentDate)
      setState(() {
        currentDate = pickedchequeDate;
      });
  }

  @override
  void initState() {
    super.initState();
    getbanklist();
  }

  String? bankdropdownvalue;
  String? bankid;

  List bankdropdownitems = [];
  getbanklist() async {
    try {
      FormData formData = FormData();
      formData = FormData.fromMap({});

      var response = await centreAPI("api/banks", formData);
      if (response.containsKey("status")) {
        if (response["status"].toString() == "1") {
          bankdropdownitems = response["data"];
          log(bankdropdownitems.toString());
        } else {}
      }
    } catch (error) {}
  }

  void addpaymentAPI() async {
    var a;
    String? mimet;
    setState(() {
      a = finalimage!.path.toString().split('/');
      mimet = lookupMimeType(a[a.length - 1].toString());
    });
    final binary = ContentType("application", "octet-stream");
    SharedPreferences userdetails = await SharedPreferences.getInstance();
    var user = userdetails.getString('userid').toString();
    var url = SecureConst.baseurl + "api/addpayment";
    Map<String, String> headers = user != "null"
        ? {
            'Accept': 'application/json',
            'Client-ID': SecureConst.ClientID,
            'Client-Secret': SecureConst.Clientsecret,
            'Auth-Token': userdetails.getString('token').toString(),
            'uid': user,
            'cid': userdetails.getString('comapny_id').toString(),
            'Content-Type': mimet.toString()
          }
        : {
            'Accept': 'application/json',
            'Content-Type': mimet.toString(),
            'Client-ID': SecureConst.ClientID,
            'Client-Secret': SecureConst.Clientsecret,
          };

    try {
      var request = http.MultipartRequest("POST", Uri.parse(url));
      request.headers.addAll(headers);
      request.fields['cheque_no'] = chequenumbercontroller.text;
      request.fields['cheque_amount'] = chequeamountcontroller.text;
      request.fields['cheque_date'] =
          DateFormat('yyyy-MM-dd').format(currentDate);
      request.fields['bank_id'] = bankid!;

      request.files.add(await http.MultipartFile(
        'file',
        finalimage!.readAsBytes().asStream(),
        finalimage!.lengthSync(),
        filename: a[a.length - 1].toString(),
      ));
      http.Response response =
          await http.Response.fromStream(await request.send());

      var rsp = json.decode(response.body);
      log(rsp.toString());

      if (rsp.containsKey("status")) {
        Navigator.pop(context);
        if (rsp["status"].toString() == "1") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              padding: EdgeInsets.all(20),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              content: Text("Payment Details Added Successfully")));

          setState(() {
            bankdropdownvalue = null;
            chequeamountcontroller.clear();
            chequenumbercontroller.clear();
            finalimage = null;
          });
        } else {
          if (rsp["status"].toString() == "0" &&
              rsp["error"].toString() ==
                  "<p>The uploaded file exceeds the maximum allowed size in your PHP configuration file.</p>") {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                padding: EdgeInsets.all(20),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                content: Text("File size Should be Less than 2 MB")));
          }
        }
      }
    } catch (error) {}
  }

  chooseimagesheet() {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton(
                  color: Colors.black,
                  textColor: Colors.white,
                  child: Text("Gallery"),
                  onPressed: () {
                    imagepicker(ImageSource.gallery);
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  width: 20,
                ),
                FlatButton(
                  color: Colors.black,
                  textColor: Colors.white,
                  child: Text("Camera"),
                  onPressed: () {
                    imagepicker(ImageSource.camera);
                  },
                ),
              ],
            ),
          );
        });
  }

  File? finalimage;

  Future imagepicker(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    setState(() {
      if (image != null) {
        finalimage = File(image.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: appbarbgcolor,
        centerTitle: true,
        title: Text("Add Payment Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    "Bank *",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Card(
                  color: Colors.grey.shade200,
                  elevation: 0,
                  child: DropdownButton(
                      dropdownColor: Colors.white,
                      style: TextStyle(color: Colors.black),
                      icon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                        ),
                      ),
                      underline: SizedBox(),
                      iconEnabledColor: Colors.black,
                      iconDisabledColor: Colors.black,
                      hint: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text("Select Bank",
                            style: TextStyle(color: Colors.grey)),
                      ),
                      isExpanded: true,
                      value: bankdropdownvalue,
                      items: bankdropdownitems
                          .map((e) => DropdownMenuItem(
                              value: e["name"],
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(e["name"]),
                              )))
                          .toList(),
                      onChanged: (v) {
                        setState(() {
                          bankdropdownvalue = v.toString();
                          log(bankdropdownvalue.toString());
                          bankdropdownitems.forEach((index) {
                            if (index['name'].toString().toLowerCase() ==
                                v.toString().toLowerCase()) {
                              setState(() {
                                bankid = index['id'].toString();
                              });
                            }
                          });
                        });
                      }),
                ),
              ],
            ),
            SizedBox(height: 10),
            inputfield(
                keyboardtype: TextInputType.emailAddress,
                inputController: chequenumbercontroller,
                hinttext: "Enter Cheque Number",
                labeltext: "Cheque Number *"),
            SizedBox(
              height: 15,
            ),
            inputfield(
                keyboardtype: TextInputType.emailAddress,
                inputController: chequeamountcontroller,
                hinttext: "Enter Cheque Amount",
                labeltext: "Cheque Amount *"),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                "Select Cheque Date*",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat('yyyy-MM-dd').format(currentDate),
                      style: TextStyle(color: Colors.black),
                    ),
                    IconButton(
                        onPressed: () {
                          select_cheque_Date(context);
                        },
                        icon: Icon(Icons.calendar_month))
                  ],
                ),
              ),
              decoration: BoxDecoration(color: Colors.grey.shade200),
              height: 50,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                "Cheque Image *",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                chooseimagesheet();
              },
              child: Container(
                child: finalimage == null
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.upload_sharp),
                            Text("Choose Image")
                          ],
                        ),
                      )
                    : Image.file(
                        File(finalimage!.path),
                        height: 200,
                        fit: BoxFit.contain,
                      ),
                height: 100,
                width: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade200),
              ),
            ),
            SizedBox(
              height: 15,
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
                  if (bankid != null &&
                      chequenumbercontroller.text.isNotEmpty &&
                      chequeamountcontroller.text.isNotEmpty &&
                      currentDate != null &&
                      finalimage != null) {
                    addpaymentAPI();
                    showLoaderDialog(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        padding: EdgeInsets.all(20),
                        backgroundColor: Colors.redAccent,
                        behavior: SnackBarBehavior.floating,
                        content: Text("Please Fill All Required Fields...")));
                  }
                  if (chequenumbercontroller.text.length != 6) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        padding: EdgeInsets.all(20),
                        backgroundColor: Colors.redAccent,
                        behavior: SnackBarBehavior.floating,
                        content: Text("Cheque No Should be Exact 6 digit")));
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
