import 'package:Cobi/Constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class contactus_page extends StatelessWidget {
  const contactus_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: appbarbgcolor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.50,
                child: Image.asset("lib/assets/COBI.png"),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                child: Text(
                  "Email : contact@cobijhajjar.org",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 15),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                child: Text(
                  "Call : +91 9811225655",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 15),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                child: Text(
                  "Website : https://cobijhajjar.org",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 15),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.white,
                height: 1,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: IconButton(
                          onPressed: () {
                            launch("https://www.facebook.com/cobijhajjar");
                          },
                          icon: FaIcon(
                            FontAwesomeIcons.facebook,
                            color: Colors.blue,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "Facebook",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: IconButton(
                          onPressed: () {
                            launch("https://twitter.com/CobiJhajjar");
                          },
                          icon: FaIcon(
                            FontAwesomeIcons.twitter,
                            color: Colors.blue,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "Twitter",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: IconButton(
                          onPressed: () {
                            launch(
                                "https://www.linkedin.com/company/cobi-jhajjar/");
                          },
                          icon: FaIcon(
                            FontAwesomeIcons.linkedin,
                            color: Colors.blue,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "LinkedIn",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.white,
                height: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
