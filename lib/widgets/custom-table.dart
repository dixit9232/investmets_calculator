import 'package:flutter/material.dart';

class CustomTable extends StatelessWidget {
  final List<List<String>> rows;

  const CustomTable({super.key, required this.rows});

  @override
  Widget build(BuildContext context) {
    List<String> header = ["Year", "Amount Invested", "Return", "FV"];
    return DataTable(
        headingRowHeight: 40,
        headingTextStyle: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
        headingRowColor: WidgetStatePropertyAll(Colors.purpleAccent),
        border: TableBorder.all(
          width: 1,
          color: Colors.black54,
        ),
        decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.black54)),
        columns: List.generate(
          header.length,
          (index) => DataColumn(headingRowAlignment: MainAxisAlignment.center, label: Text(header[index])),
        ),
        rows: List.generate(
          rows.length,
          (rowIndex) {
            final rowData = rows[rowIndex];
            return DataRow(
                cells: List.generate(
              rowData.length,
              (cellIndex) {
                final cellData = rowData[cellIndex];
                return DataCell(Center(child: Text(cellData)));
              },
            ));
          },
        ));
  }
}
