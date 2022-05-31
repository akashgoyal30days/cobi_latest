import 'dart:convert';
import 'dart:io';

import 'package:Cobi/Constants/constants.dart';
import 'package:Cobi/Widgets/widgets.dart';
import 'package:Cobi/controllers/api_controller.dart';
import 'package:Cobi/screens/companypdfview.dart';
import 'package:Cobi/screens/personalpdfview.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';

class companydocscreen extends StatefulWidget {
  companydocscreen({Key? key}) : super(key: key);

  @override
  State<companydocscreen> createState() => _companydocscreenState();
}

class _companydocscreenState extends State<companydocscreen> with list {
  chooseimagesheet(int index) {
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
                    imagefromGAllery(index);
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
                    imagefromCamera(index);
                  },
                ),
              ],
            ),
          );
        });
  }

  List seletedimg = [];

  XFile? finalimage;

  void uploadImage(String id, String urla, int index) async {
    var a;
    String? mimet;
    setState(() {
      showloader = true;
      a = seletedimg[index]!.path.toString().split('/');
      mimet = lookupMimeType(a[a.length - 1].toString());
    });
    final binary = ContentType("application", "octet-stream");
    SharedPreferences userdetails = await SharedPreferences.getInstance();
    var user = userdetails.getString('userid').toString();
    var url = SecureConst.baseurl + urla;
    Map<String, String> headers = user.isNotEmpty
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
      request.fields['doc_id'] = id;
      request.files.add(await http.MultipartFile(
        'file',
        seletedimg[index]!.readAsBytes().asStream(),
        seletedimg[index]!.lengthSync(),
        
        filename: a[a.length - 1].toString(),
        contentType: MediaType('application', 'pdf'),
      ));
      http.Response response =
          await http.Response.fromStream(await request.send());
      var rsp = json.decode(response.body);
      //var rsp = response.body;
      // debugPrint(rsp.toString());
      // debugPrint(a[a.length - 1].toString());
      if (rsp.containsKey('status')) {
        setState(() {
          showloader = false;
        });
        if (rsp['status'].toString() == "1") {
          setState(() {
            seletedimg.clear();
            showloader = true;
            getcompanydoclist();
          });
        } else if (rsp['status'].toString() == "0") {
          setState(() {
            showloader = false;
          });
        }
      }
    } catch (error) {
      // debugPrint(error.toString());
    }
  }


  Future imagefromGAllery(int index) async {
    final image = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'png', 'jpeg'],
    );
    if (image != null) {
      File file = File(image.files.single.path!);
      setState(() {
        seletedimg[index] = file;
      });
      // debugPrint(file.toString());
      // debugPrint(seletedimg.toString());
    }
  }

  Future imagefromCamera(int index) async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      if (image != null) {
        finalimage = image;
        seletedimg[index] = File(finalimage!.path);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getcompanydoclist();
  }

  List docs = [];
  Future getcompanydoclist() async {
    var abc = await getcompanydocs();
    debugPrint(abc.toString());
    if (abc.runtimeType == List<dynamic>) {
      setState(() {
        docs = abc;
        showloader = false;
      });
      for (var i = 0; i < docs.length; i++) {
        if (docs[i]['is_uploaded'].toString() != '1') {
          seletedimg.add(File);
        } else {
          seletedimg.add('');
        }
      }
      // debugPrint(seletedimg.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Company Documents"),
          backgroundColor: appbarbgcolor,
        ),
        drawer: Navigationdrawer(),
        body: showloader == true
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                        child: ListView.builder(
                            itemCount: docs.length,
                            itemBuilder: (BuildContext context, index) {
                              return Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 20, 10, 10),
                                      child: Container(
                                        child: Text(
                                          docs[index]['doc_type'].toString(),
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade200,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          height: 140,
                                          child: Row(
                                            children: [
                                              Container(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: docs[index]['is_uploaded']
                                                                  .toString() ==
                                                              '0' &&
                                                          seletedimg[index]
                                                                  .toString() ==
                                                              "File"
                                                      ? Image.asset(
                                                          "lib/assets/noimage.png",
                                                        )
                                                      : docs[index]['is_uploaded'].toString() == '0' &&
                                                              seletedimg[index]
                                                                      .toString() !=
                                                                  "File" &&
                                                              seletedimg[index]
                                                                      .toString()
                                                                      .substring(seletedimg[index].toString().length -
                                                                          2)
                                                                      .toString() ==
                                                                  "f'"
                                                          ? Image.asset(
                                                              "lib/assets/pdfselected.png",
                                                            )
                                                          : docs[index]['is_uploaded'].toString() == '0' &&
                                                                  seletedimg[index].toString() !=
                                                                      "File" &&
                                                                  seletedimg[index]
                                                                          .toString()
                                                                          .substring(seletedimg[index].toString().length - 1)
                                                                          .toString() !=
                                                                      "f"
                                                              ? Image.file(File(seletedimg[index].path))
                                                              : docs[index]['is_uploaded'].toString() == '1' && docs[index]['doc_path'].toString().substring(docs[index]['doc_path'].toString().length - 1).toString() == "f"
                                                                  ? Image.asset(
                                                                      "lib/assets/pdfselected.png",
                                                                    )
                                                                  : docs[index]['is_uploaded'].toString() == '1' && docs[index]['doc_path'].toString().substring(docs[index]['doc_path'].toString().length - 1).toString() != "f"
                                                                      ? Image.network(
                                                                          docs[index]['doc_path']
                                                                              .toString(),
                                                                        )
                                                                      : Image.asset(''),
                                                ),
                                                width: 100,
                                              ),
                                              Expanded(
                                                  child: Padding(
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                child: Column(
                                                  children: [
                                                    docs[index]['is_uploaded']
                                                                .toString() ==
                                                            '0'
                                                        ? RaisedButton(
                                                            onPressed: () {
                                                              chooseimagesheet(
                                                                  index);
                                                            },
                                                            child: Text(
                                                                "Choose File"),
                                                          )
                                                        : RaisedButton(
                                                            onPressed: () {
                                                              if (docs[index][
                                                                          'doc_path']
                                                                      .toString()
                                                                      .substring(
                                                                          docs[index]['doc_path'].toString().length -
                                                                              1)
                                                                      .toString() ==
                                                                  "f") {
                                                                Navigator.of(
                                                                        context)
                                                                    .pushReplacement(
                                                                        MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                pdfview2(
                                                                                  url: docs[index]['doc_path'].toString(),
                                                                                )));
                                                              } else {
                                                                showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return AlertDialog(
                                                                      content: Image.network(docs[index]
                                                                              [
                                                                              'doc_path']
                                                                          .toString()),
                                                                    );
                                                                  },
                                                                );
                                                              }
                                                            },
                                                            child: Text(
                                                                "View Doc"),
                                                          ),
                                                    docs[index]['is_uploaded']
                                                                .toString() ==
                                                            '0'
                                                        ? RaisedButton(
                                                            color: Colors.black,
                                                            textColor:
                                                                Colors.white,
                                                            onPressed: () {
                                                              uploadImage(
                                                                  docs[index]
                                                                          ['id']
                                                                      .toString(),
                                                                  'api/uploadcompanydoc',
                                                                  index);
                                                            },
                                                            child: Text(
                                                                "Upload File"),
                                                          )
                                                        : RaisedButton(
                                                            disabledColor:
                                                                Colors.black,
                                                            disabledTextColor:
                                                                Colors.white,
                                                            onPressed: null,
                                                            child: Text(docs[
                                                                        index]
                                                                    ['status']
                                                                .toString()),
                                                          )
                                                  ],
                                                ),
                                              ))
                                            ],
                                          )),
                                    ),
                                  ],
                                ),
                              );
                            }))
                  ],
                ),
              ),
      ),
    );
  }
}
