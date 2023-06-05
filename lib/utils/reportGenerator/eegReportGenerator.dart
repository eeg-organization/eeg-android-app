import 'package:adv_eeg/utils/reportGenerator/save_file_mobile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../../models/brainScoreModel.dart';

Future<void> generatEEGReport(RxList<BrainScoreModel> scores) async {
  // print(scores.value.score);
  //Create a PDF document.
  final PdfDocument document = PdfDocument();
  //Add page to the PDF
  final PdfPage page = document.pages.add();
  //Get page client size
  final Size pageSize = page.getClientSize();
  //Draw rectangle
  page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
      pen: PdfPen(PdfColor(142, 170, 219)));
  //Generate PDF grid.
  final PdfGrid grid = getGrid(scores);
  //Draw the header section by creating text element
  final PdfLayoutResult result = drawHeader(page, pageSize, grid);
  //Draw grid
  drawGrid(page, grid, result);
  //Add invoice footer
  drawFooter(page, pageSize);
  //Save the PDF document
  final List<int> bytes = document.saveSync();
  //Dispose the document.
  document.dispose();
  //Save and launch the file.
  await saveAndLaunchFile(bytes,
      '${GetStorage().read('loginDetails')['user']['name']}_${DateTime.now().microsecondsSinceEpoch}.pdf');
}

//Draws the invoice header
PdfLayoutResult drawHeader(PdfPage page, Size pageSize, PdfGrid grid) {
  //Draw rectangle
  page.graphics.drawRectangle(
      brush: PdfSolidBrush(PdfColor(91, 126, 215)),
      bounds: Rect.fromLTWH(0, 0, pageSize.width - 0, 90));
  //Draw string
  page.graphics.drawString(
      'EEG Report for ${GetStorage().read('loginDetails')['user']['name']}',
      PdfStandardFont(PdfFontFamily.helvetica, 30),
      brush: PdfBrushes.white,
      bounds: Rect.fromLTWH(25, 0, pageSize.width - 115, 90),
      format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));

  final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 9);
  final Size contentSize = contentFont.measureString('');
  const String address = '';
  return PdfTextElement(text: address, font: contentFont).draw(
      page: page,
      bounds: Rect.fromLTWH(30, 120, pageSize.width - (contentSize.width + 30),
          pageSize.height))!;
}

//Draws the grid
void drawGrid(PdfPage page, PdfGrid grid, PdfLayoutResult result) {
  Rect? totalPriceCellBounds;
  Rect? quantityCellBounds;
  grid.beginCellLayout = (Object sender, PdfGridBeginCellLayoutArgs args) {
    final PdfGrid grid = sender as PdfGrid;
    if (args.cellIndex == grid.columns.count - 1) {
      totalPriceCellBounds = args.bounds;
    } else if (args.cellIndex == grid.columns.count - 2) {
      quantityCellBounds = args.bounds;
    }
  };
  result = grid.draw(
      page: page, bounds: Rect.fromLTWH(0, result.bounds.bottom + 40, 0, 0))!;
}

void drawFooter(PdfPage page, Size pageSize) {
  final PdfPen linePen =
      PdfPen(PdfColor(142, 170, 219), dashStyle: PdfDashStyle.custom);
  linePen.dashPattern = <double>[3, 3];
}

//Create PDF grid and return
PdfGrid getGrid(RxList<BrainScoreModel> brainScores) {
  print('GetGrid Called');
  final PdfGrid grid = PdfGrid();
  grid.columns.add(count: 4);

  final PdfGridRow headerRow = grid.headers.add(1)[0];

  headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(68, 114, 196));
  headerRow.style.textBrush = PdfBrushes.white;
  headerRow.cells[0].value = 'Serial Number';
  headerRow.cells[0].stringFormat.alignment = PdfTextAlignment.center;
  headerRow.cells[1].value = 'Date & Time';
  headerRow.cells[2].value = 'Device Id';
  headerRow.cells[3].value = 'Score';
  // quiz.value.score
  //     .map((e) => addQuizItem(e.data.questionare.type.toString(), e.createdAt,
  //         e.data.questions.length, e.score, grid))
  //     .toList();
  for (int i = 0; i < brainScores.length; i++) {
    addBrainScores(i + 1, brainScores[i].createdAt!, brainScores[i].deviceId!,
        brainScores[i].score!, grid);
  }
  grid.applyBuiltInStyle(PdfGridBuiltInStyle.listTable4Accent5);

  grid.columns[1].width = 200;
  for (int i = 0; i < headerRow.cells.count; i++) {
    headerRow.cells[i].style.cellPadding =
        PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
  }
  for (int i = 0; i < grid.rows.count; i++) {
    final PdfGridRow row = grid.rows[i];
    for (int j = 0; j < row.cells.count; j++) {
      final PdfGridCell cell = row.cells[j];
      if (j == 0) {
        cell.stringFormat.alignment = PdfTextAlignment.center;
      }
      cell.style.cellPadding =
          PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
    }
  }
  return grid;
}

//Create and row for the grid.
void addBrainScores(int SerialNo, DateTime dateTime, String deviceId,
    String score, PdfGrid grid) {
  print('addQuizItem Called');
  final PdfGridRow row = grid.rows.add();
  row.cells[0].value = SerialNo;
  final DateFormat format = DateFormat.yMMMMd('en_US').add_Hm();
  row.cells[1].value = format.format(dateTime);
  row.cells[2].value = deviceId.toString();
  row.cells[3].value = score.toString();
}
