import 'package:flutter/material.dart';

import 'data.dart';

void main() {
  runApp(const DocumentApp());
}

//UIテーマを設定
class DocumentApp extends StatelessWidget {
  const DocumentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: DocumentScreen(
        document: Document(),
      ),
    );
  }
}

//ページを視覚的にレイアウト
class DocumentScreen extends StatelessWidget {
  final Document document;
  const DocumentScreen({
    required this.document,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final (title, :modified) = document.getMetadata();
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Column(
        children: [Center(child: Text('Last modified $modified'))],
      ),
    );
  }
}