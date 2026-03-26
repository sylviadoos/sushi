import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfScreen extends StatelessWidget {
  final String pdfBase64;
  const PdfScreen({super.key, required this.pdfBase64});

  @override
  Widget build(BuildContext context) {
    Uint8List bytes = base64Decode(pdfBase64.split(',').last);
    return Scaffold(
      appBar: AppBar(title: const Text("PDF Preview")),
      body: SfPdfViewer.memory(bytes),
    );
  }
}