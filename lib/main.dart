import 'package:flutter/material.dart';
import 'package:wedding_table_finder/views/name_inquiry.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Alex & Beibhinn's Wedding Table Finder",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: NameInquiry(),
    );
  }
}
