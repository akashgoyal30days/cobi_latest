import 'package:Cobi/screens/companydocumentsscreen.dart';
import 'package:Cobi/screens/personaldocscreen.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class pdfview2 extends StatefulWidget {
  final String url;
  const pdfview2({Key? key, required this.url}) : super(key: key);

  @override
  _pdfview2State createState() => _pdfview2State();
}

class _pdfview2State extends State<pdfview2> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => companydocscreen()));
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          body: Container(child: SfPdfViewer.network(widget.url)),
        ),
      ),
    );
  }
}
