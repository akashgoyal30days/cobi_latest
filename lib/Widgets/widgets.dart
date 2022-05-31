import 'dart:ui';

import 'package:Cobi/Constants/constants.dart';
import 'package:Cobi/screens/Companydetailsscreen.dart';
import 'package:Cobi/screens/companydocumentsscreen.dart';
import 'package:Cobi/screens/contactus.dart';
import 'package:Cobi/screens/dashboardscreen.dart';
import 'package:Cobi/screens/grievancesscreen.dart';
import 'package:Cobi/screens/jobscreen.dart';
import 'package:Cobi/screens/paymentdetailsscreen.dart';
import 'package:Cobi/screens/personaldetailsscree.dart';
import 'package:Cobi/screens/personaldocscreen.dart';
import 'package:Cobi/screens/productviewscreen.dart';
import 'package:Cobi/screens/receivedenquiryviewscreen.dart';
import 'package:Cobi/screens/registrationscreen/registrationscreen.dart';
import 'package:Cobi/screens/searchproductscreen.dart';
import 'package:Cobi/screens/sentenquiryviewscreen.dart';
import 'package:Cobi/screens/welcomescreen/welcomescreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Navigationdrawer extends StatefulWidget {
  Navigationdrawer({Key? key}) : super(key: key);

  @override
  State<Navigationdrawer> createState() => _NavigationdrawerState();
}

class _NavigationdrawerState extends State<Navigationdrawer> {
  String person_name = "";
  String desig = "";

  @override
  void initState() {
    super.initState();
    getuserdetails();
  }

  getuserdetails() async {
    SharedPreferences getuserdetails = await SharedPreferences.getInstance();
    setState(() {
      person_name = getuserdetails.getString('pername')!;
      desig = getuserdetails.getString('desig')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              person_name.toString(),
              style: TextStyle(fontSize: 15.sp),
            ),
            accountEmail: Text(
              desig.toString(),
              style: TextStyle(fontSize: 15.sp),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: ClipOval(
                child: Image.asset(
                  "lib/assets/COBI.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: BoxDecoration(color: Colors.black),
          ),
          SizedBox(height: 10.h),
          ListTile(
            leading: Icon(
              Icons.dashboard,
              color: primaryiconcolor,
              size: 25.sp,
            ),
            title: Text(
              "Dashboard",
              style: TextStyle(fontSize: 15.sp, color: primarytextcolor),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => dashboard_screen()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.business,
              color: primaryiconcolor,
              size: 25.sp,
            ),
            title: Text("Company Details",
                style: TextStyle(fontSize: 15.sp, color: primarytextcolor)),
            onTap: () {
              Navigator.pop(context);

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Companydetailsscreen()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.description,
              color: primaryiconcolor,
              size: 25.sp,
            ),
            title: Text("Company Documents",
                style: TextStyle(fontSize: 15.sp, color: primarytextcolor)),
            onTap: () {
              Navigator.pop(context);

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => companydocscreen()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.person,
              color: primaryiconcolor,
              size: 25.sp,
            ),
            title: Text("Personal Details",
                style: TextStyle(fontSize: 15.sp, color: primarytextcolor)),
            onTap: () {
              Navigator.pop(context);

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => personaldetailscreen()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.description_outlined,
              color: primaryiconcolor,
              size: 25.sp,
            ),
            title: Text("Personal Documents",
                style: TextStyle(fontSize: 15.sp, color: primarytextcolor)),
            onTap: () {
              Navigator.pop(context);

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => personaldocscreen()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.search,
              color: primaryiconcolor,
              size: 25.sp,
            ),
            title: Text("Search Products",
                style: TextStyle(fontSize: 15.sp, color: primarytextcolor)),
            onTap: () {
              Navigator.pop(context);

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => searchproductscreen(
                            searchviadashboard: false,
                          )));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.feedback_sharp,
              color: primaryiconcolor,
              size: 25.sp,
            ),
            title: Text("Grievances",
                style: TextStyle(fontSize: 15.sp, color: primarytextcolor)),
            onTap: () {
              Navigator.pop(context);

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => grievancesviewscreen()));
              showLoaderDialog(context);
            },
          ),
          ExpansionTile(
            leading: Icon(
              Icons.campaign_outlined,
              color: primaryiconcolor,
              size: 25.sp,
            ),
            title: Text("Vocal 4 Local",
                style: TextStyle(fontSize: 15.sp, color: primarytextcolor)),
            children: <Widget>[
              ListTile(
                onTap: () {
                  Navigator.pop(context);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => productviewscreen()));
                },
                leading: Icon(
                  Icons.inventory_2_outlined,
                  color: primaryiconcolor,
                  size: 25.sp,
                ),
                title: Text("Products",
                    style: TextStyle(fontSize: 15.sp, color: primarytextcolor)),
              ),
              ExpansionTile(
                leading: Icon(
                  Icons.manage_search_outlined,
                  color: primaryiconcolor,
                  size: 25.sp,
                ),
                title: Text("Enquiries",
                    style: TextStyle(fontSize: 15.sp, color: primarytextcolor)),
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  receivedenquiryviewscreen()));
                      showLoaderDialog(context);
                    },
                    leading: Icon(
                      Icons.call_received_outlined,
                      color: primaryiconcolor,
                      size: 25.sp,
                    ),
                    title: Text("Received Enquiries",
                        style: TextStyle(
                            fontSize: 15.sp, color: primarytextcolor)),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => sentenquiryviewscreen()));
                      showLoaderDialog(context);
                    },
                    leading: Icon(
                      Icons.send,
                      color: primaryiconcolor,
                      size: 25.sp,
                    ),
                    title: Text("Sent Enquiries",
                        style: TextStyle(
                            fontSize: 15.sp, color: primarytextcolor)),
                  ),
                ],
              )
            ],
          ),
          ListTile(
            leading: Icon(
              Icons.work,
              color: primaryiconcolor,
              size: 25.sp,
            ),
            title: Text("Job Section",
                style: TextStyle(fontSize: 15.sp, color: primarytextcolor)),
            onTap: () {
              Navigator.pop(context);

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => jobportalscreen()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.currency_rupee,
              color: primaryiconcolor,
              size: 25.sp,
            ),
            title: Text("Payment Details",
                style: TextStyle(fontSize: 15.sp, color: primarytextcolor)),
            onTap: () {
              Navigator.pop(context);

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => paymentdetailsscreen()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.call,
              color: primaryiconcolor,
              size: 25.sp,
            ),
            title: Text("Contact Us",
                style: TextStyle(fontSize: 15.sp, color: primarytextcolor)),
            onTap: () {
              Navigator.pop(context);

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => contactus_page()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: primaryiconcolor,
              size: 25.sp,
            ),
            title: Text("Logout",
                style: TextStyle(fontSize: 15.sp, color: primarytextcolor)),
            onTap: () async {
              SharedPreferences logoutuser =
                  await SharedPreferences.getInstance();
              logoutuser.remove('pername');
              logoutuser.remove('desig');
              logoutuser.remove('industry_type');
              logoutuser.remove('company_name');
              logoutuser.remove('uname');

              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => welcome_screen()));
            },
          ),
        ],
      ),
    );
  }
}

class RectangleInputField extends StatelessWidget {
  final String? hintText;
  final String? errortext;
  final TextInputType? keyboardtype;

  final IconData? icon;
  final ValueChanged<String>? onchanged;
  final TextEditingController? textEditingController;
  final Color? cursorColor;
  final Color? iconColor;
  final Color? editTextBackgroundColor;
  final bool? hidedetails;

  RectangleInputField(
      {Key? key,
      this.hintText,
      this.keyboardtype,
      this.errortext,
      this.icon = Icons.person,
      this.onchanged,
      this.textEditingController,
      this.cursorColor,
      this.iconColor,
      this.hidedetails,
      this.editTextBackgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 50,
            margin: EdgeInsets.symmetric(vertical: 10.h),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
            width: size.width * 0.80,
            decoration: BoxDecoration(
              border: Border.all(width: 1.0, color: Colors.white),
              color: editTextBackgroundColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextField(
              onChanged: onchanged,
              obscureText: hidedetails!,
              style: TextStyle(color: cursorColor),
              controller: textEditingController,
              cursorColor: cursorColor,
              decoration: InputDecoration(
                isDense: true,
                icon: Icon(
                  icon,
                  color: iconColor,
                ),
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.white60),
                border: InputBorder.none,
              ),
              keyboardType: keyboardtype,
            ),
          ),
        ],
      ),
    );
  }
}

class rectangleraisedbutton extends StatelessWidget {
  Color? buttonbgcolor;
  Color? textcolor;
  Color? bordercolor;
  String? btntext;

  rectangleraisedbutton(
      {Key? key,
      this.bordercolor,
      this.btntext,
      this.buttonbgcolor,
      this.textcolor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width * 0.80,
      child: RaisedButton(
          textColor: textcolor,
          color: buttonbgcolor,
          shape: RoundedRectangleBorder(
              side: BorderSide(width: 1.0, color: bordercolor!),
              borderRadius: BorderRadius.circular(5)),
          onPressed: () {},
          child: Text(btntext!)),
    );
  }
}
