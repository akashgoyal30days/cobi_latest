import 'package:Cobi/Constants/constants.dart';
import 'package:Cobi/Widgets/widgets.dart';
import 'package:Cobi/screens/registrationscreen/registrationscreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class tweetscreen extends StatefulWidget {
  const tweetscreen({Key? key}) : super(key: key);

  @override
  State<tweetscreen> createState() => _tweetscreenState();
}

class _tweetscreenState extends State<tweetscreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 0), () {
      showLoaderDialog(context);

      Future.delayed(
          Duration(
            seconds: 4,
          ), () {
        Navigator.pop(context);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Navigationdrawer(),
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: appbarbgcolor,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(FontAwesomeIcons.twitter),
                SizedBox(
                  width: 10,
                ),
                Text("Latest Tweets"),
                SizedBox(
                  width: 50,
                ),
              ],
            )),
        body: WebViewPlus(
          zoomEnabled: true,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (webcontroller) {
            webcontroller.loadUrl("lib/assets/twitter.html");
          },
        ),
      ),
    );
  }
}
