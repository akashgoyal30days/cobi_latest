import 'package:Cobi/screens/personaldocscreen.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfView extends StatefulWidget {
  final String url;
  const PdfView({Key? key, required this.url}) : super(key: key);

  @override
  _PdfViewState createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => personaldocscreen()));
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
