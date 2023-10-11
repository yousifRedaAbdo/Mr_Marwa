
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../../../course_members/generate_pdf/save_file_mobile.dart';

class GenerateCertificate {
  Future<List<int>> _readFontData() async {
    final ByteData bytes = await rootBundle.load('assets/fonts/dinfont.ttf');
    return bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
  }

  Future<List<int>> _readCImageData() async {
    final ByteData bytes = await rootBundle.load('assets/images/certificate.png');
    return bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
  }

  Future<void> generateCertificateImage(String studentName) async {
    late File file;
    file = File(
        '/storage/emulated/0/Download/Certificate $studentName.pdf');

    //Create a PDF document.
    final PdfDocument document = PdfDocument();
    //Add page to the PDF
    final PdfPage page = document.pages.add();

    //Get page client size

    final Size pageSize = page.getClientSize();
    //Draw rectangle

    //Generate PDF grid.
    List<int> pdfFont = await _readFontData();
    List<int> image = await _readCImageData();

    page.graphics.drawImage(
      PdfBitmap(image),
      Rect.fromLTWH(0, 0, pageSize.width, pageSize.height * 9 / 16),
    );

    /// select place for name
    page.graphics.drawString(
      studentName,
      PdfTrueTypeFont(pdfFont, 16, style: PdfFontStyle.bold),
      brush: PdfBrushes.black,
      bounds: Rect.fromLTWH(
          0, 150, pageSize.width - 200, pageSize.height * 9 / 16 - 180),
      format: PdfStringFormat(
        lineAlignment: PdfVerticalAlignment.middle,
        textDirection: PdfTextDirection.rightToLeft,
        alignment: PdfTextAlignment.center,
      ),
    );

    final List<int> bytes =await document.save();

    //Dispose the document.
    document.dispose();

    OpenFile.open(file.path);
    await saveAndLaunchFile(bytes, 'Certificate.pdf');
  }

}