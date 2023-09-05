import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:open_file/open_file.dart';

class PdfApi {
  static Future<File> generateTable(
      List<List<dynamic>> dataReport, var header, String date) async {
    final pdf = pw.Document();
    // Create the PDF content using the provided dataReport
    await createPdfContent(pdf, dataReport, header, date);

    // Save the PDF document
    return saveDocument(name: 'My_example.pdf', pdf: pdf);
  }

  static Future<File> saveDocument({
    required String name,
    required pw.Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }

  static Future<void> createPdfContent(pw.Document pdf,
      List<List<dynamic>> dataReport, List<String> header, String Date) async {
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Container(
            width: PdfPageFormat.a4.width,
            height: PdfPageFormat.a4.height,
            child: pw.Column(children: [
              pw.Center(
                  child: pw.Text(
                      "National Level Technical Symposium — Techquest @ 23",
                      style: pw.TextStyle(
                        color: const PdfColor.fromInt(0xff4F3D56),
                        fontSize: 18,
                        fontWeight: pw.FontWeight.bold,
                      ))),
              pw.Center(
                  child: pw.Text("Student Report",
                      style: pw.TextStyle(
                        color: const PdfColor.fromInt(0xff4F3D56),
                        fontSize: 18,
                        fontWeight: pw.FontWeight.bold,
                      ))),
              pw.SizedBox(height: 10),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
                pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text("Date: $Date",
                        style: pw.TextStyle(
                          color: const PdfColor.fromInt(0xff000000),
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                        )))
              ]),
              pw.SizedBox(height: 10),
              // ignore: deprecated_member_use
              pw.Table.fromTextArray(
                cellAlignment: pw.Alignment.centerLeft,
                headerDecoration: const pw.BoxDecoration(
                  color: PdfColor.fromInt(0xff4F3D56),
                ),
                headerStyle: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.white,
                  fontSize: 5,
                ),
                headers: header,
                data: dataReport,
                cellStyle: const pw.TextStyle(fontSize: 10),
                headerPadding: const pw.EdgeInsets.all(5),
                cellPadding: const pw.EdgeInsets.all(5),
                // columnWidths: {
                //   0: const pw.FixedColumnWidth(40),
                //   1: const pw.FixedColumnWidth(40),
                //   2: const pw.FixedColumnWidth(50),
                //   3: const pw.FixedColumnWidth(50),
                //   4: const pw.FixedColumnWidth(50),
                //   5: const pw.FixedColumnWidth(50),
                //   6: const pw.FixedColumnWidth(50),
                //   7: const pw.FixedColumnWidth(50),
                //   8: const pw.FixedColumnWidth(50),
                //   9: const pw.FixedColumnWidth(50),
                //   10: const pw.FixedColumnWidth(45),
                //   11: const pw.FixedColumnWidth(45),
                //   12: const pw.FixedColumnWidth(45),
                //   13: const pw.FixedColumnWidth(45),
                //   14: const pw.FixedColumnWidth(45),
                // },
              )
            ]),
            alignment: pw.Alignment.topLeft,
          );
        },
      ),
    );
  }
}
