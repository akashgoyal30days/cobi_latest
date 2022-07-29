import 'dart:developer';

import 'package:Cobi/screens/sendenquiryscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:shared_preferences/shared_preferences.dart';

class searchproductdetailsviewscreen extends StatefulWidget {
  final String productHSNCode;
  final String productName;
  final String companyName;

  final String productid;
  final String userID;

  final String productimage;

  final String ProductDEscription;

  const searchproductdetailsviewscreen(
      {Key? key,
      required this.productHSNCode,
      required this.productName,
      required this.companyName,
      required this.productid,
      required this.productimage,
      required this.ProductDEscription,
      required this.userID})
      : super(key: key);

  @override
  State<searchproductdetailsviewscreen> createState() =>
      _searchproductdetailsviewscreen();
}

class _searchproductdetailsviewscreen
    extends State<searchproductdetailsviewscreen> {
  bool disablesendenquirybutton = false;
  @override
  void initState() {
    super.initState();
    checkenquirybutton();
  }

  var userid;
  checkenquirybutton() async {
    SharedPreferences userdetails = await SharedPreferences.getInstance();
    userid = userdetails.get("userid");
    if (userid == widget.userID) {
      disablesendenquirybutton = true;
    }
    setState(() {});

    log(userid);
    log(widget.userID);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: disablesendenquirybutton == false
            ? Container(
                height: 50,
                width: MediaQuery.of(context).size.width - 50,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => sendenquiryscreen(
                                  SoldbyName: widget.companyName,
                                  productName: widget.productName,
                                  productid: widget.productid,
                                  productimage: widget.productimage,
                                )));
                  },
                  child: Text(" Send Enquiry "),
                  color: Colors.black,
                  textColor: Colors.white,
                ))
            : SizedBox(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.transparent,
          toolbarHeight: 300,
          flexibleSpace: Center(
            child: Image(
              image: NetworkImage(
                  "https://erp.cobijhajjar.org/" + widget.productimage),
              fit: BoxFit.cover,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  widget.productName,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text(
                      "HSN Code :",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      widget.productHSNCode,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Company Name",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.companyName,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
              Html(data: widget.ProductDEscription),
              SizedBox(height: 80)
            ],
          ),
        ),
      ),
    );
  }
}
