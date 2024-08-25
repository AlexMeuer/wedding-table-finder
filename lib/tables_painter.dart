import 'package:flutter/material.dart' hide Table;
import 'package:wedding_table_finder/models/table.dart';

class TablesPainter extends CustomPainter {
  const TablesPainter({required this.tables, required this.selectedTableIndex});

  final int selectedTableIndex;
  final List<Table> tables;

  static const tableRadius = 25.0;

  @override
  void paint(Canvas canvas, Size size) {
    final normalTablePaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.black;

    final selectedTablePaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.green;

    for (final (i, t) in tables.indexed) {
      final paint =
          i == selectedTableIndex ? selectedTablePaint : normalTablePaint;

      final position = scaleToSize(t, size);

      canvas.drawCircle(
        position,
        tableRadius,
        paint,
      );

      final labelPainter = TextPainter(
        text: TextSpan(
          text: t.name,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 12.0,
          ),
        ),
        textDirection: TextDirection.rtl,
      );
      labelPainter.layout(minWidth: 0.0, maxWidth: double.infinity);
      labelPainter.paint(
          canvas, position - labelPainter.size.center(Offset.zero));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  static Offset scaleToSize(Table table, Size size) {
    final x = table.x / size.width;
    final y = table.y / size.height;
    final scaledX = x * 1000;
    final scaledY = y * 1000;
    return Offset(scaledX + (size.width / 4), scaledY + (size.height / 4));
  }
}
