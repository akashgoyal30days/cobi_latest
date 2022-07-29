import 'package:Cobi/Constants/constants.dart';
import 'package:Cobi/Widgets/widgets.dart';
import 'package:Cobi/screens/Companydetailsscreen.dart';
import 'package:Cobi/screens/companydocumentsscreen.dart';
import 'package:Cobi/screens/feedbackscreen.dart';
import 'package:Cobi/screens/jobscreen.dart';
import 'package:Cobi/screens/paymentdetailsscreen.dart';
import 'package:Cobi/screens/personaldetailsscree.dart';
import 'package:Cobi/screens/personaldocscreen.dart';
import 'package:Cobi/screens/productviewscreen.dart';
import 'package:Cobi/screens/registrationscreen/registrationscreen.dart';
import 'package:Cobi/screens/searchproductscreen.dart';
import 'package:Cobi/screens/tweet.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class dashboard_screen extends StatefulWidget {
  dashboard_screen({Key? key}) : super(key: key);

  @override
  State<dashboard_screen> createState() => _homescreenState();
}

class _homescreenState extends State<dashboard_screen> {
  String? searchkeyword;
  TextEditingController searchkeywordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Dashboard",
              style: TextStyle(fontSize: 20),
            ),
            backgroundColor: appbarbgcolor,
            actions: [
              Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => tweetscreen()))),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.twitter,
                              size: 15,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Tweets",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ))
            ],
          ),
          drawer: Navigationdrawer(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => searchproductscreen(
                                        searchviadashboard: true,
                                        searchKeyword: searchkeyword))));
                            showLoaderDialogwithName(context, "Searching..");
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
                SizedBox(
                  height: 20,
                ),

                Expanded(
                  child: GridView(
                      // shrinkWrap: true,
                      children: [
                        InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => personaldetailscreen(),
                              )),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 10,
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.solidUser,
                                    size: 35,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Personal",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                      ),
                                      Text(
                                        "Details",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Companydetailsscreen(),
                              )),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 10,
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.solidBuilding,
                                    size: 35,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Company",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                      ),
                                      Text(
                                        "Details",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => personaldocscreen(),
                              )),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 10,
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.solidFile,
                                    size: 35,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Personal",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                      ),
                                      Text(
                                        "Documents",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => companydocscreen(),
                              )),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 10,
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.solidFilePdf,
                                    size: 35,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Company",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                      ),
                                      Text(
                                        "Documents",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => jobportalscreen(),
                              )),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 10,
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.briefcase,
                                    size: 35,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Jobs",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                      ),
                                      Text(
                                        "Section",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => paymentdetailsscreen(),
                              )),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 10,
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.indianRupeeSign,
                                    size: 35,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Payment",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                      ),
                                      Text(
                                        "Details",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => productviewscreen(),
                              )),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 10,
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.productHunt,
                                    size: 35,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Product",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                      ),
                                      Text(
                                        "Details",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => feedbackscreen(),
                              )),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 10,
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.solidComments,
                                    size: 35,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Feedback",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                      ),
                                      Text(
                                        "",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ),
                      ],
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          crossAxisCount: 2)),
                ),
                // InkWell(
                //   onTap: () {
                //     launch("https://cobijhajjar.org/");
                //   },
                //   child: Card(
                //     color: Colors.transparent,
                //     shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(10)),
                //     elevation: 0,
                //     child: Column(
                //       children: [
                //         Container(
                //           decoration: BoxDecoration(
                //               border: Border.all(color: Colors.black),
                //               image: DecorationImage(
                //                   fit: BoxFit.fill,
                //                   image:
                //                       AssetImage("lib/assets/cobi_banner.jpg")),
                //               color: Colors.grey.shade300,
                //               borderRadius: BorderRadius.circular(10)),
                //           height: 150,
                //         ),
                //         Container(
                //           child: Center(
                //             child: Text(
                //               "Visit Website",
                //               style: TextStyle(
                //                   color: Colors.white,
                //                   fontSize: 15,
                //                   fontWeight: FontWeight.w500),
                //             ),
                //           ),
                //           decoration: BoxDecoration(
                //             border: Border.all(color: Colors.white),
                //             borderRadius: BorderRadius.only(
                //                 bottomLeft: Radius.circular(10),
                //                 bottomRight: Radius.circular(10)),
                //             color: Colors.black,
                //           ),
                //           width: 280,
                //           height: 30,
                //         )
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          )),
    );
  }
}
