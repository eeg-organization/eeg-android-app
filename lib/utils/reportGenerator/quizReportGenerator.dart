import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:adv_eeg/utils/reportGenerator/save_file_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:image/image.dart' as img;
import '../../models/patients/quiz_model.dart';
import '../../screens/doctorScreens/patientDetailedView(DocEnd).dart';

final chartData = <ChartData>[];
Future<void> generateQuizReport(Rx<Quiz> quiz) async {
  chartData.addAll(quiz.value.quizs.map((e) => ChartData(
      DateTime(e.createdAt.year, e.createdAt.month, e.createdAt.day,
          e.createdAt.hour, e.createdAt.minute, e.createdAt.second),
      e.score,
      e.data.questionare.type)));
  print(quiz.value.quizs.map((e) => e.score));
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
  final PdfGrid grid = getGrid(quiz);
  //Draw the header section by creating text element
  final PdfLayoutResult result = drawHeader(page, pageSize, grid);
  //Draw grid
  drawGrid(page, grid, result);
  //Add invoice footer
  drawFooter(page, pageSize);
  //Save the PDF document

  final List<int> bytes = document.saveSync();
  //Dispose the document.
  // await createGraph(quiz, page, document);
  document.dispose();
  //Save and launch the file.
  await saveAndLaunchFile(bytes,
      '${GetStorage().read('loginDetails')['user']['name']}_${DateTime.now()}.pdf');
}

//Draws the invoice header
PdfLayoutResult drawHeader(PdfPage page, Size pageSize, PdfGrid grid) {
  //Draw rectangle
  page.graphics.drawRectangle(
      brush: PdfSolidBrush(PdfColor(91, 126, 215)),
      bounds: Rect.fromLTWH(0, 0, pageSize.width - 0, 90));
  //Draw string
  page.graphics.drawString(
      'Quiz Report for ${GetStorage().read('loginDetails')['user']['name']}',
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
PdfGrid getGrid(Rx<Quiz> quiz) {
  print('GetGrid Called');
  final PdfGrid grid = PdfGrid();
  grid.columns.add(count: 4);

  final PdfGridRow headerRow = grid.headers.add(1)[0];

  headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(68, 114, 196));
  headerRow.style.textBrush = PdfBrushes.white;
  headerRow.cells[0].value = 'Quiz Type';
  headerRow.cells[0].stringFormat.alignment = PdfTextAlignment.center;
  headerRow.cells[1].value = 'Date & Time';
  headerRow.cells[2].value = 'Total Questions';
  headerRow.cells[3].value = 'Score';
  quiz.value.quizs
      .map((e) => addQuizItem(e.data.questionare.type.toString(), e.createdAt,
          e.data.questions.length, e.score, grid))
      .toList();
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

GlobalKey chartContainerKey = GlobalKey();
createGraph(Rx<Quiz> quiz, PdfPage page, PdfDocument pdf) async {
  // Add a separate page with the graph
  final graphPage = pdf.pages.add();
  final graphBounds = Rect.fromLTWH(
      0, 0, graphPage.getClientSize().width, graphPage.getClientSize().height);
  final chart = RepaintBoundary(
    key: chartContainerKey,
    child: SfCartesianChart(
      key: chartContainerKey,
      primaryXAxis: DateTimeAxis(
          // intervalType: DateTimeIntervalType.hours,
          ),
      series: <ChartSeries<ChartData, DateTime>>[
        LineSeries<ChartData, DateTime>(
          dataSource: chartData,
          pointColorMapper: (ChartData data, _) =>
              data.y! > 15 ? Colors.red : Colors.green,
          name: 'Score',
          onPointTap: (pointInteractionDetails) =>
              print('${pointInteractionDetails.pointIndex}'),
          xValueMapper: (ChartData data, _) =>
              DateTime(data.x.year, data.x.month, data.x.day, data.x.hour),
          yValueMapper: (ChartData data, _) => data.y,
          dataLabelSettings: DataLabelSettings(isVisible: true),
          markerSettings: MarkerSettings(isVisible: true),
          dataLabelMapper: (datum, index) =>
              '${datum.type.toString()} , Score: ${datum.y.toString()}',
        )
      ],
    ),
  );
  // Capture a screenshot of the chart widget
  RenderRepaintBoundary boundary = await chartContainerKey.currentContext!
      .findRenderObject() as RenderRepaintBoundary;
  ui.Image chartImage = await boundary.toImage(pixelRatio: 3.0);
  ByteData? byteData =
      await chartImage.toByteData(format: ui.ImageByteFormat.png);
  Uint8List screenshotBytes = byteData!.buffer.asUint8List();

  // Create an Image object from the screenshot
  final chartImageWidget = Image.memory(screenshotBytes);

  // Add the chart image to the PDF document
  final pdfImage = PdfBitmap(chartImageWidget as List<int>);
  page.graphics.drawImage(
    pdfImage,
    Rect.fromLTWH(
        0, 0, page.getClientSize().width, page.getClientSize().height),
  );
}

//Create and row for the grid.
void addQuizItem(String QuizType, DateTime dateTime, int TotalQuestions,
    int score, PdfGrid grid) {
  print('addQuizItem Called');
  final PdfGridRow row = grid.rows.add();
  row.cells[0].value = QuizType;
  final DateFormat format = DateFormat.yMMMMd('en_US').add_Hms();
  row.cells[1].value = format.format(dateTime);
  row.cells[2].value = TotalQuestions.toString();
  row.cells[3].value = score.toString();
}
