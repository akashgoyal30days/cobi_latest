import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:Cobi/Constants/constants.dart';
import 'package:Cobi/Widgets/descriptionfield.dart';
import 'package:Cobi/Widgets/inputfield.dart';
import 'package:Cobi/screens/registrationscreen/registrationscreen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';

class addproductscreen extends StatefulWidget {
  addproductscreen({Key? key}) : super(key: key);

  @override
  State<addproductscreen> createState() => _addproductscreenState();
}

class _addproductscreenState extends State<addproductscreen> {
  TextEditingController hsncodecontroller = TextEditingController();
  TextEditingController productnamecontroller = TextEditingController();
  TextEditingController productdescriptioncontroller = TextEditingController();
  void addproductAPI() async {
    var a;
    String? mimet;
    setState(() {
      a = finalimage!.path.toString().split('/');
      mimet = lookupMimeType(a[a.length - 1].toString());
    });
    final binary = ContentType("application", "octet-stream");
    SharedPreferences userdetails = await SharedPreferences.getInstance();
    var user = userdetails.getString('userid').toString();
    var url = SecureConst.baseurl + "api/addproduct";
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
      request.fields['hsn_code'] = hsncodecontroller.text;
      request.fields['product_name'] = productnamecontroller.text;
      request.fields['product_description'] = productdescriptioncontroller.text;

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
              content: Text("Product Added Successfully")));

          setState(() {
            hsncodecontroller.clear();
            productnamecontroller.clear();
            productdescriptioncontroller.clear();
            finalimage = null;
          });
        } else {}
      }
    } catch (error) {}
  }

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
        title: Text("Add Products"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            SizedBox(height: 10),
            inputfield(
                keyboardtype: TextInputType.emailAddress,
                inputController: hsncodecontroller,
                hinttext: "Enter HSN Code",
                labeltext: "HSN Code *"),
            SizedBox(
              height: 15,
            ),
            inputfield(
                keyboardtype: TextInputType.emailAddress,
                inputController: productnamecontroller,
                hinttext: "Enter Product Name",
                labeltext: " Product Name*"),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 10,
            ),
            descriptionfield(
                inputController: productdescriptioncontroller,
                hinttext: "Enter Product Description",
                labeltext: "Product Description *"),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                "Product Image *",
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
                    if (hsncodecontroller.text.isNotEmpty &&
                        productnamecontroller.text.isNotEmpty &&
                        productdescriptioncontroller.text.isNotEmpty &&
                        finalimage != null) {
                      addproductAPI();
                      showLoaderDialog(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          padding: EdgeInsets.all(20),
                          backgroundColor: Colors.redAccent,
                          behavior: SnackBarBehavior.floating,
                          content: Text("Please Fill All Required Fields...")));
                    }
                    if (hsncodecontroller.text.length < 4) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          padding: EdgeInsets.all(20),
                          backgroundColor: Colors.redAccent,
                          behavior: SnackBarBehavior.floating,
                          content:
                              Text("HSN Code Should be greater than 4 Digit")));
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
