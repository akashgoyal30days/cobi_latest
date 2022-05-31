import 'dart:developer';

import 'package:Cobi/Constants/constants.dart';
import 'package:Cobi/controllers/api_controller.dart';
import 'package:Cobi/screens/registrationscreen/registrationscreen.dart';
import 'package:Cobi/screens/searchproductviewdetailsscreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class searchproductscreen extends StatefulWidget {
  final bool searchviadashboard;
  final String? searchKeyword;
  const searchproductscreen({
    Key? key,
    this.searchKeyword,
    required this.searchviadashboard,
  }) : super(key: key);

  @override
  State<searchproductscreen> createState() => _searchproductscreenState();
}

class _searchproductscreenState extends State<searchproductscreen> {
  bool productnotfound = false;
  String? searchkeyword;
  TextEditingController searchkeywordcontroller = TextEditingController();

  List searchproductresultlist = [];
  @override
  void initState() {
    super.initState();
    if (widget.searchviadashboard == true) {
      searchproductviadashboard();
    }
  }

  void searchproductviadashboard() async {
    try {
      FormData formData = FormData();
      formData = FormData.fromMap({"keyword": widget.searchKeyword});

      var response = await centreAPI("api/search_product", formData);
      if (response.containsKey("status")) {
        Navigator.pop(context);
        log(response.toString());

        if (response["status"].toString() == "1") {
          setState(() {});
          productnotfound = false;

          searchproductresultlist = response["data"]["product"];
          log("Result :" + searchproductresultlist.toString());
        } else {
          productnotfound = true;
          setState(() {});
          searchproductresultlist = [];
        }
      }
    } catch (error) {
      log(error.toString());
    }
  }

  void searchproduct() async {
    try {
      FormData formData = FormData();
      formData = FormData.fromMap({"keyword": searchkeyword});

      var response = await centreAPI("api/search_product", formData);
      if (response.containsKey("status")) {
        Navigator.pop(context);
        log(response.toString());

        if (response["status"].toString() == "1") {
          setState(() {});
          productnotfound = false;

          searchproductresultlist = response["data"]["product"];
          log("Result :" + searchproductresultlist.toString());
        } else {
          productnotfound = true;
          setState(() {});
          searchproductresultlist = [];
        }
      }
    } catch (error) {
      log(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Product List"),
        backgroundColor: appbarbgcolor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(height: 10),
            Container(
              child: TextFormField(
                cursorColor: Colors.white,
                controller: searchkeywordcontroller,
                onChanged: (value) {
                  searchkeyword = value.toString();
                },
                style: const TextStyle(fontSize: 14, color: Colors.white),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  suffixIcon: IconButton(
                      onPressed: () {
                        showLoaderDialog(context);
                        searchproduct();
                      },
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                      )),
                  filled: true,
                  fillColor: Colors.black,
                  hintText: "Search Any Product Here",
                  hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontWeight: FontWeight.w300),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                ),
              ),
            ),
            SizedBox(height: 10),
            productnotfound == false
                ? Expanded(
                    child: ListView.builder(
                      itemCount: searchproductresultlist.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.shade300),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.black,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Text(
                                              " Product Name ",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(searchproductresultlist[index]
                                            ["product_name"]),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Colors.black,
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Text(
                                                " Product Description ",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Html(
                                            data: searchproductresultlist[index]
                                                        ["product_description"]
                                                    .toString()
                                                    .substring(3, 100) +
                                                "..."),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.black,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Text(
                                              " Sold By ",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(searchproductresultlist[index]
                                            ["company_name"]),
                                      ],
                                    ),
                                  ),
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
                                                    builder: ((context) => searchproductdetailsviewscreen(
                                                        userID: searchproductresultlist[index]
                                                            ["user_id"],
                                                        productimage: searchproductresultlist[index]
                                                            ["product_image"],
                                                        companyName: searchproductresultlist[index]
                                                            ["company_name"],
                                                        productid:
                                                            searchproductresultlist[
                                                                index]["id"],
                                                        productHSNCode:
                                                            searchproductresultlist[index]
                                                                ["hsn_code"],
                                                        productName:
                                                            searchproductresultlist[index][
                                                                "product_name"],
                                                        ProductDEscription:
                                                            searchproductresultlist[index]
                                                                ["product_description"]))));
                                          },
                                          child: Text("View Details"),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : Expanded(
                    child: Center(
                        child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_off,
                        color: Colors.grey,
                        size: 40,
                      ),
                      Text(
                        "Sorry ! No Such Product Found",
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                    ],
                  ))),
          ],
        ),
      ),
    );
  }
}
