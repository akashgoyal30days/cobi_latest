import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class productdetailsviewscreen extends StatefulWidget {
  final String productimage;
  final String productHSNCode;
  final String productName;
  final String ProductDEscription;

  const productdetailsviewscreen(
      {Key? key,
      required this.productimage,
      required this.productHSNCode,
      required this.productName,
      required this.ProductDEscription})
      : super(key: key);

  @override
  State<productdetailsviewscreen> createState() =>
      _productdetailsviewscreenState();
}

class _productdetailsviewscreenState extends State<productdetailsviewscreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.transparent,
          toolbarHeight: 300,
          flexibleSpace: Image(
            image: NetworkImage(widget.productimage),
            fit: BoxFit.cover,
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
              Html(data: widget.ProductDEscription),
            ],
          ),
        ),
      ),
    );
  }
}
