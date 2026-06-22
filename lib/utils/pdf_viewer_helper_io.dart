import 'dart:io';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

Widget buildPdfViewerFromPath(
  String filePath,
  PdfViewerController controller,
  PdfDocumentLoadedCallback onDocumentLoaded,
  bool isDownloaded,
) {
  return isDownloaded
      ? SfPdfViewer.file(
          File(filePath),
          controller: controller,
          onDocumentLoaded: onDocumentLoaded,
        )
      : SfPdfViewer.asset(
          filePath,
          controller: controller,
          onDocumentLoaded: onDocumentLoaded,
        );
}
