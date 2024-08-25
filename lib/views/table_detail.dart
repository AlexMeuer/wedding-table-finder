import 'package:flutter/material.dart' hide Table;

import '../models/table.dart';

class TableDetail extends StatelessWidget {
  const TableDetail({super.key, required this.table});

  final Table table;

  @override
  Widget build(BuildContext context) {
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
                const Text('Your table is:'),
                Text(
                  table.name,
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 16),
                Text(table.directions),
              ]),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: InteractiveViewer(
                child: const FlutterLogo(size: 128),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
