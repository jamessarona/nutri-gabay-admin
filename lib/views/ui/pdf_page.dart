import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerPage extends StatefulWidget {
  final String doctorId;
  const PdfViewerPage({super.key, required this.doctorId});

  @override
  State<PdfViewerPage> createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
            height: 500,
            width: 500,
            child: SfPdfViewer.network(widget.doctorId)));
  }
}
