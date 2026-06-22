import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../utils/pdf_viewer_helper_stub.dart' if (dart.library.io) '../utils/pdf_viewer_helper_io.dart';

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

  void _onDocumentLoaded(PdfDocumentLoadedDetails details) {
    if (widget.initialPage != null) {
      _pdfViewerController.jumpToPage(widget.initialPage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.courseCode} - ${widget.unitId}'),
        centerTitle: true,
      ),
      body: buildPdfViewerFromPath(
        widget.filePath,
        _pdfViewerController,
        _onDocumentLoaded,
        widget.isDownloaded,
      ),
    );
  }
}
