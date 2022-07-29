import 'dart:developer';

import 'package:Cobi/Constants/constants.dart';
import 'package:Cobi/controllers/api_controller.dart';
import 'package:Cobi/screens/addpayment_detail_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class paymentdetailsscreen extends StatefulWidget {
  const paymentdetailsscreen({Key? key}) : super(key: key);

  @override
  State<paymentdetailsscreen> createState() => _paymentdetailsscreen();
}

class _paymentdetailsscreen extends State<paymentdetailsscreen> {
  @override
  void initState() {
    super.initState();
    fetchpaymentdetails();
    setState(() {});
  }

  List paymentdetails = [];

  fetchpaymentdetails() async {
    try {
      FormData formData = FormData();
      formData = FormData.fromMap({});

      var response = await centreAPI("api/payments", formData);
      log(response.toString());
      if (response.containsKey("status")) {
        if (response["status"].toString() == "1") {
          paymentdetails = response["data"];
          setState(() {});
        } else {
          log("error");
        }
      }
    } catch (error) {}
  }

  showchequeimagedailog(int index) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Image.network(
              "https://erp.cobijhajjar.org/uploads/cheques/" +
                  paymentdetails[index]['cheque_img'].toString()),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.black,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => addpaymentdeyailsscreen(),
                ));
          },
          label: Row(
            children: [
              Icon(FontAwesomeIcons.plus, size: 15),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text("Add New Payment"),
              ),
            ],
          )),
      appBar: AppBar(
        backgroundColor: appbarbgcolor,
        centerTitle: true,
        title: Text("Payment Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: paymentdetails.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                  height: 230,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade300),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Bank :",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                paymentdetails[index]["name"],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Cheque Number :",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                paymentdetails[index]["cheque_no"],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Cheque Amount :",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                paymentdetails[index]["cheque_amount"],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Cheque Date :",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                paymentdetails[index]["cheque_date"],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Cheque Status :",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                paymentdetails[index]["cheque_status"],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RaisedButton(
                              textColor: Colors.white,
                              color: Colors.black,
                              onPressed: () {
                                showchequeimagedailog(index);
                              },
                              child: Text("View File"),
                            ),
                          ],
                        )
                      ],
                    ),
                  )),
            );
          },
        ),
      ),
    ));
  }
}
