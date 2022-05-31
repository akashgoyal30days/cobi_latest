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

class addgrievancesscreen extends StatefulWidget {
  const addgrievancesscreen({Key? key}) : super(key: key);

  @override
  State<addgrievancesscreen> createState() => _addgrievancesscreenState();
}

class _addgrievancesscreenState extends State<addgrievancesscreen> {
  void showcustomDailog(
    String title,
    String bodymessage,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
          ),
          content: Text(
            bodymessage,
            style: TextStyle(height: 1.5, fontWeight: FontWeight.w300),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              color: Colors.black,
              child: new Text(
                "Close",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  TextEditingController subjectcontroller = TextEditingController();
  TextEditingController grievancescontroller = TextEditingController();

  void addgrievances() async {
    var a;
    String? mimet;
    setState(() {
      a = finalimage!.path.toString().split('/');
      mimet = lookupMimeType(a[a.length - 1].toString());
    });
    final binary = ContentType("application", "octet-stream");
    SharedPreferences userdetails = await SharedPreferences.getInstance();
    var user = userdetails.getString('userid').toString();
    var url = SecureConst.baseurl + "api/addgrievance";
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
      request.fields['subject'] = subjectcontroller.text;
      request.fields['queries'] = grievancescontroller.text;

      request.files.add(await http.MultipartFile(
        'image',
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
          showcustomDailog("Success!!", "Your Grievances sent For approval");

          setState(() {
            subjectcontroller.clear();
            grievancescontroller.clear();
            finalimage = null;
          });
        } else {}
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
        title: Text("Add Grievance Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            SizedBox(height: 10),
            inputfield(
                inputController: subjectcontroller,
                keyboardtype: TextInputType.emailAddress,
                hinttext: "Enter Subject",
                labeltext: "Subject *"),
            SizedBox(
              height: 15,
            ),
            descriptionfield(
                inputController: grievancescontroller,
                hinttext: "Enter Your Grievances",
                labeltext: "Grievances *"),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                "Image *",
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
                height: 150,
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
                  if (subjectcontroller.text.isNotEmpty &&
                      grievancescontroller.text.isNotEmpty &&
                      finalimage != null) {
                    addgrievances();
                    showLoaderDialog(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        padding: EdgeInsets.all(20),
                        backgroundColor: Colors.red,
                        behavior: SnackBarBehavior.floating,
                        content: Text("All fields are required")));
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
