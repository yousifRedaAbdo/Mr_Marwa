import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../../../course_members/generate_pdf/save_file_mobile.dart';

class GenerateQuizReportPDF {
  Future<List<int>> _readFontData() async {
    final ByteData bytes = await rootBundle.load('assets/fonts/dinfont.ttf');
    return bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
  }

  Future<void> generateReport(
    activityName,
    submittedList,
    inProgressList,
    notSubmittedList,
  ) async {
    late File file;
    file = File('/storage/emulated/0/Download/ report $activityName.pdf');

    //Create a PDF document.
    final PdfDocument document = PdfDocument();
    //Add page to the PDF
    final PdfPage page = document.pages.add();

    //Get page client size

    final Size pageSize = page.getClientSize();
    //Draw rectangle
    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
        pen: PdfPen(PdfColor(142, 170, 219, 255)));
    //Generate PDF grid.
    final PdfGrid grid;

    grid = getGrid(
      submittedList,
      inProgressList,
      notSubmittedList,
    );

    PdfFont font = PdfTrueTypeFont(
      await _readFontData(),
      14,
    );
    grid.style.font = font;

    //Draw the header section by creating text element
    final PdfLayoutResult result =
        drawHeader(page, pageSize, grid, activityName, font);
    //Draw grid

    drawGrid(page, grid, result);

    //Save the PDF document
    final List<int> bytes = await document.save();

    //Dispose the document.
    document.dispose();
    //Save and launch the file.
    //TODO check again
    // final file = File('/storage/emulated/0/Download/$filename');
    // await file.writeAsBytes(bytes, flush: true);
    // OpenFile.open(file.path);

    await saveAndLaunchFile(bytes, 'Attendants.pdf');
  }

//Draws the invoice header
  PdfLayoutResult drawHeader(PdfPage page, Size pageSize, PdfGrid grid,
      String activityName, PdfFont pdfFont) {
    //Draw rectangle
    page.graphics.drawRectangle(
        brush: PdfSolidBrush(PdfColor(91, 126, 215, 255)),
        bounds: Rect.fromLTWH(0, 0, pageSize.width, 90));
    //Draw string
    page.graphics.drawString(
      activityName,
      pdfFont,
      brush: PdfBrushes.white,
      format: PdfStringFormat(
        lineAlignment: PdfVerticalAlignment.middle,
        textDirection: PdfTextDirection.rightToLeft,
      ),
      bounds: Rect.fromLTWH(25, 8, pageSize.width - 115, 90),
    );

    return PdfTextElement(
      text: '',
    ).draw(page: page, bounds: Rect.fromLTWH(0, 100, pageSize.width - (0), 0))!;
  }

//Draws the grid
  void drawGrid(PdfPage page, PdfGrid grid, PdfLayoutResult result) {
    Rect? totalPriceCellBounds;
    Rect? quantityCellBounds;
    //Invoke the beginCellLayout event.
    grid.beginCellLayout = (Object sender, PdfGridBeginCellLayoutArgs args) {
      final PdfGrid grid = sender as PdfGrid;

      if (args.cellIndex == grid.columns.count - 1) {
        totalPriceCellBounds = args.bounds;
      } else if (args.cellIndex == grid.columns.count - 2) {
        quantityCellBounds = args.bounds;
      }
    };
    //Draw the PDF grid and get the result.
    result = grid.draw(
      page: page,
      bounds: Rect.fromLTWH(0, result.bounds.bottom + 40, 0, 0),
    )!;
  }

//Create PDF grid and return
  PdfGrid getGrid(
    submittedList,
    inProgressList,
    notSubmittedList,
  ) {
    //Create a PDF grid
    final PdfGrid grid = PdfGrid();
    //Secify the columns count to the grid.
    grid.columns.add(count: 6);
    //Create the header row of the grid.
    final PdfGridRow headerRow = grid.headers.add(1)[0];
    //Set style
    headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(68, 114, 196));
    headerRow.style.textBrush = PdfBrushes.white;
    headerRow.style.font = grid.style.font;

    headerRow.cells[0].value = 'Student ID';
    headerRow.cells[0].stringFormat.alignment = PdfTextAlignment.center;
    headerRow.cells[0].stringFormat.textDirection =
        PdfTextDirection.rightToLeft;
    headerRow.cells[1].value = 'Student Name';
    headerRow.cells[1].stringFormat.alignment = PdfTextAlignment.center;
    headerRow.cells[1].stringFormat.textDirection =
        PdfTextDirection.rightToLeft;
    headerRow.cells[2].value = 'Center Name';
    headerRow.cells[2].stringFormat.alignment = PdfTextAlignment.center;
    headerRow.cells[2].stringFormat.textDirection =
        PdfTextDirection.rightToLeft;
    headerRow.cells[3].value = 'Grad';
    headerRow.cells[3].stringFormat.alignment = PdfTextAlignment.center;
    headerRow.cells[3].stringFormat.textDirection =
        PdfTextDirection.rightToLeft;
    headerRow.cells[4].value = 'Status';
    headerRow.cells[4].stringFormat.alignment = PdfTextAlignment.center;
    headerRow.cells[4].stringFormat.textDirection =
        PdfTextDirection.rightToLeft;
    headerRow.cells[5].value = 'Date';
    headerRow.cells[5].stringFormat.alignment = PdfTextAlignment.center;
    headerRow.cells[5].stringFormat.textDirection =
        PdfTextDirection.rightToLeft;

    void addStudent(String studentId, String studentIdName, String centerName,
        String grade, String status, String joinDate, PdfGrid grid) {
      final PdfGridRow row = grid.rows.add();
      row.cells[0].value = studentId;
      row.cells[1].value = studentIdName;
      row.cells[2].value = centerName;
      row.cells[3].value = grade;
      row.cells[4].value = status;
      row.cells[5].value = joinDate;
    }

    //Add rows
    for (var i in submittedList) {
      addStudent(i.userid, i.fullname, i.centername, i.grade, i.state,
          i.timefinished, grid);
    }

    for (var i in inProgressList) {
      addStudent(i.userid, i.fullname, i.centername, '-', i.state, '', grid);
    }

    for (var i in notSubmittedList) {
      addStudent(
          i.userid, i.fullname, i.centername, '-', 'Not Submitted', '-', grid);
    }

    //Apply the table built-in style
    grid.applyBuiltInStyle(PdfGridBuiltInStyle.listTable4Accent5);
    //Set gird columns width
    for (int i = 0; i < headerRow.cells.count; i++) {
      headerRow.cells[i].style.cellPadding =
          PdfPaddings(bottom: 1, left: 1, right: 1, top: 1);
    }
    for (int i = 0; i < grid.rows.count; i++) {
      final PdfGridRow row = grid.rows[i];

      for (int j = 0; j < row.cells.count; j++) {
        final PdfGridCell cell = row.cells[j];
        cell.stringFormat.alignment = PdfTextAlignment.center;
        cell.stringFormat.textDirection = PdfTextDirection.rightToLeft;

        cell.style.cellPadding =
            PdfPaddings(bottom: 1, left: 1, right: 1, top: 1);
      }
    }
    return grid;
  }
}
