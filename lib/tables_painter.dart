import 'package:flutter/material.dart' hide Table;
import 'package:wedding_table_finder/models/table.dart';

class TablesPainter extends CustomPainter {
  const TablesPainter({required this.tables, required this.selectedTableIndex});

  final int selectedTableIndex;
  final List<Table> tables;

  static const tableRadius = 25.0;
  static const dancefloorRadius = 70.0;
  static const calibratedSize = 400;

  @override
  void paint(Canvas canvas, Size size) {
    final scalingFactor = size.shortestSide / calibratedSize;
    final center = Offset(size.width / 2, size.height / 2);

    double scaleRadius(double value) => value * scalingFactor;
    Offset scaleOffset(Offset value) =>
        value.scale(scalingFactor, scalingFactor) + center;

    TextPainter paintIcon(IconData icon, Offset position) => TextPainter(
          text: TextSpan(
            text: String.fromCharCode(icon.codePoint),
            style: TextStyle(
              fontSize: 16.0 * scalingFactor,
              fontFamily: icon.fontFamily,
            ),
          ),
          textDirection: TextDirection.rtl,
        )
          ..layout()
          ..paint(canvas, scaleOffset(position));

    paintIcon(Icons.wc, const Offset(150, -150));

    final dancefloorPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.amber.withOpacity(0.5);
    canvas.drawCircle(
      size.center(Offset.zero),
      scaleRadius(dancefloorRadius),
      dancefloorPaint,
    );

    final normalTablePaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.black;

    final selectedTablePaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.green;

    final scaledTableRadius = scaleRadius(tableRadius);

    for (final (i, t) in tables.indexed) {
      final paint =
          i == selectedTableIndex ? selectedTablePaint : normalTablePaint;

      final tablePosition = scaleOffset(offsetFor(t));

      canvas.drawCircle(
        tablePosition,
        scaledTableRadius,
        paint,
      );

      final labelPainter = TextPainter(
        text: TextSpan(
          text: t.name,
          style: TextStyle(
            color: Colors.black,
            fontSize: 12.0 * scalingFactor,
          ),
        ),
        textDirection: TextDirection.rtl,
      );
      labelPainter.layout(minWidth: 0.0, maxWidth: double.infinity);
      labelPainter.paint(
        canvas,
        tablePosition - labelPainter.size.center(Offset.zero),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  static Offset offsetFor(Table t) => Offset(t.x, t.y);
}
