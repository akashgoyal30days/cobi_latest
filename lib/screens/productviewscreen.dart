import 'dart:developer';
import 'package:Cobi/Constants/constants.dart';
import 'package:Cobi/controllers/api_controller.dart';
import 'package:Cobi/screens/addproductscreen.dart';
import 'package:Cobi/screens/productdetailsviewscreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class productviewscreen extends StatefulWidget {
  const productviewscreen({Key? key}) : super(key: key);

  @override
  State<productviewscreen> createState() => _productviewscreenState();
}

class _productviewscreenState extends State<productviewscreen> {
  @override
  void initState() {
    super.initState();
    fetchproductlist();
  }

  List productlist = [];
  fetchproductlist() async {
    try {
      FormData formData = FormData();
      formData = FormData.fromMap({});

      var response = await centreAPI("api/products", formData);
      log(response.toString());
      if (response.containsKey("status")) {
        if (response["status"].toString() == "1") {
          productlist = response["data"];
          setState(() {});
        } else {
          log("error");
        }
      }
    } catch (error) {}
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            floatingActionButton: FloatingActionButton.extended(
                backgroundColor: Colors.black,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => addproductscreen(),
                      ));
                },
                label: Row(
                  children: [
                    Icon(FontAwesomeIcons.plus, size: 15),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text("Add New Product"),
                    ),
                  ],
                )),
            appBar: AppBar(
              backgroundColor: appbarbgcolor,
              centerTitle: true,
              title: Text("Products"),
            ),
            body: Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: ListView.builder(
                itemCount: productlist.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 10,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Image.network(
                                    productlist[index]["product_image"],
                                    fit: BoxFit.contain,
                                    width: double.infinity,
                                    height: 250,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 20),
                              child: Row(
                                children: [
                                  Text("HSN Code :",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(productlist[index]["hsn_code"]),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 20),
                              child: Row(
                                children: [
                                  Text("Product Name :",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Text(
                                      productlist[index]["product_name"],
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 20),
                                  child: Text("Product Description :",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 1, horizontal: 15),
                                  child: Html(
                                      data: productlist[index]
                                                  ["product_description"]
                                              .toString()
                                              .substring(3, 150) +
                                          "..."),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 260,
                                      child: RaisedButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        textColor: Colors.white,
                                        color: Colors.black,
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: ((context) =>
                                                      productdetailsviewscreen(
                                                        ProductDEscription:
                                                            productlist[index][
                                                                "product_description"],
                                                        productHSNCode:
                                                            productlist[index]
                                                                ["hsn_code"],
                                                        productimage:
                                                            productlist[index][
                                                                "product_image"],
                                                        productName:
                                                            productlist[index][
                                                                "product_name"],
                                                      ))));
                                        },
                                        child: Text("View Details"),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )));
  }
}
