import 'package:flutter/material.dart' hide Table;
import 'package:flutter_svg/svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';
import 'package:wedding_table_finder/views/table_detail.dart';

import '../load_tables.dart';
import '../models/table.dart';

class TableSearchResult {
  final String guestName;
  final Table table;

  TableSearchResult(this.guestName, this.table);
}

class NameInquiry extends StatelessWidget {
  NameInquiry({super.key});

  final inputNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    inputNode.requestFocus();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Find Your Table',
              style: TextStyle(
                fontFamily: "Biancha",
                fontSize: 72.0,
              ),
            ),
            FutureBuilder(
              future: loadTables(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const CircularProgressIndicator();
                }

                if (snapshot.hasError) {
                  return Column(
                    children: [
                      const Text(
                        'Failed to load table information.',
                        style: TextStyle(color: Colors.red),
                      ),
                      Text(snapshot.error.toString()),
                    ],
                  );
                }

                if (!snapshot.hasData) {
                  return const Text(
                    'Failed to load table information.',
                    style: TextStyle(color: Colors.red),
                  );
                }

                final tables = snapshot.data!;
                final allGuestNames = tables
                    .expand((table) => table.guests)
                    .toList(growable: false);

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
                        if (query.isEmpty) return const [];
                        final results = extractTop(
                          query: query,
                          choices: allGuestNames,
                          limit: 5,
                          cutoff: 60,
                        );
                        return results
                            .map((r) => r.choice)
                            .map((name) => TableSearchResult(
                                  name,
                                  tables.firstWhere(
                                      (t) => t.guests.contains(name)),
                                ))
                            .toList();
                      },
                      itemBuilder: (context, value) {
                        return ListTile(
                          title: Text(value.guestName),
                        );
                      },
                      onSelected: (value) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => TableDetail(
                              guestName: value.guestName,
                              selectedTableIndex: tables.indexOf(value.table),
                              tables: tables,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 200.0),
              child: SvgPicture.asset("assets/amastuola.svg"),
            ),
          ],
        ),
      ),
    );
  }
}
