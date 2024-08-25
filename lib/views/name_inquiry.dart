import 'package:flutter/material.dart' hide Table;
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:wedding_table_finder/views/table_detail.dart';

import '../load_tables.dart';
import '../models/table.dart';

class TableSearchResult {
  final String name;
  final Table table;

  TableSearchResult(this.name, this.table);
}

class NameInquiry extends StatelessWidget {
  NameInquiry({super.key});

  final inputNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    inputNode.requestFocus();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Your Table'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: FutureBuilder(
            future: loadTables(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const CircularProgressIndicator();
              }

              if (snapshot.hasError) {
                return Column(
                  children: [
                    const Text('Failed to load table information.',
                        style: TextStyle(color: Colors.red)),
                    Text(snapshot.error.toString()),
                  ],
                );
              }

              if (!snapshot.hasData) {
                return const Text('Failed to load table information.',
                    style: TextStyle(color: Colors.red));
              }

              final tables = snapshot.data!;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Enter your name to find your table:',
                  ),
                  TypeAheadField<TableSearchResult>(
                    hideOnEmpty: true,
                    focusNode: inputNode,
                    suggestionsCallback: (query) {
                      if (query.length < 3) return const [];
                      return tables
                          .where((table) => table.guests.any((name) =>
                              name.toLowerCase().contains(query.toLowerCase())))
                          .map((table) => TableSearchResult(
                              table.guests.firstWhere((name) => name
                                  .toLowerCase()
                                  .contains(query.toLowerCase())),
                              table))
                          .toList();
                    },
                    itemBuilder: (context, value) {
                      return ListTile(
                        title: Text(value.name),
                      );
                    },
                    onSelected: (value) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) =>
                                TableDetail(table: value.table)),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
