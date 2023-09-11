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

class BlockWidget extends StatelessWidget {
  final Block block;
  const BlockWidget({required this.block, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle;
    switch (block.type) {
      case 'h1':
        textStyle = Theme.of(context).textTheme.displayMedium;
      //pかcheckboxに一致するかどうか（&&で良い)
      case 'p' || 'checkbox':
        textStyle = Theme.of(context).textTheme.bodyMedium;
      //ワイルドカード（その他の全てに一致）
      case '_':
        textStyle = Theme.of(context).textTheme.bodySmall;
    }
    return Container(
      margin: const EdgeInsets.all(8),
      child: Text(
        block.text,
        style: textStyle,
      ),
    );
  }
}
