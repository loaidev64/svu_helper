import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

Widget buildPdfViewerFromPath(
  String filePath,
  PdfViewerController controller,
  PdfDocumentLoadedCallback onDocumentLoaded,
  bool isDownloaded,
) {
  return SfPdfViewer.asset(
    filePath,
    controller: controller,
    onDocumentLoaded: onDocumentLoaded,
  );
}
