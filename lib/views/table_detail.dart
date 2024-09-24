import 'package:flutter/material.dart' hide Table;
import 'package:wedding_table_finder/tables_painter.dart';

import '../models/table.dart';

class TableDetail extends StatelessWidget {
  const TableDetail({
    super.key,
    required this.guestName,
    required this.selectedTableIndex,
    required this.tables,
  });

  final String guestName;
  final int selectedTableIndex;
  final List<Table> tables;

  @override
  Widget build(BuildContext context) {
    final table = tables[selectedTableIndex];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Found your table!'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(children: [
                Text('$guestName, your table is:'),
                Text(
                  table.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(table.directions),
              ]),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: InteractiveViewer(
                maxScale: 5.0,
                child: CustomPaint(
                  painter: TablesPainter(
                    tables: tables,
                    selectedTableIndex: selectedTableIndex,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
