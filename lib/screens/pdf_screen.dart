import 'dart:io';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfScreen extends StatefulWidget {
  final String courseCode;
  final String unitId;
  final String filePath;
  final int? initialPage;
  final bool isDownloaded;

  const PdfScreen({
    super.key,
    required this.courseCode,
    required this.unitId,
    required this.filePath,
    this.initialPage,
    this.isDownloaded = false,
  });

  @override
  State<PdfScreen> createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  final PdfViewerController _pdfViewerController = PdfViewerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.courseCode} - ${widget.unitId}'),
        centerTitle: true,
      ),
      body: widget.isDownloaded
          ? SfPdfViewer.file(
              File(widget.filePath),
              controller: _pdfViewerController,
              onDocumentLoaded: (details) {
                if (widget.initialPage != null) {
                  _pdfViewerController.jumpToPage(widget.initialPage!);
                }
              },
            )
          : SfPdfViewer.asset(
              widget.filePath,
              controller: _pdfViewerController,
              onDocumentLoaded: (details) {
                if (widget.initialPage != null) {
                  _pdfViewerController.jumpToPage(widget.initialPage!);
                }
              },
            ),
    );
  }
}
