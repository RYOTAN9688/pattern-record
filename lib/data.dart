import 'dart:convert';

class Document {
  final Map<String, Object?> _json;
  Document() : _json = jsonDecode(documentJson);

  (String, {DateTime modified}) getMetadata() {
    //caseパターンが_json内のデータと一致した場合のみcaseが実行される
    if (_json
        case {
          'metadata': {
            'title': String title,
            'modified': String localModified,
          }
        }) {
      return (title, modified: DateTime.parse(localModified));
    } else {
      throw const FormatException('Unexpected JSON');
    }
  }

  //JSONを解析してBlockクラスのインスタンスを作成し、UIでレンダリングするブロックリストを返す
  List<Block> getBlocks() {
    if (_json case {'blocks': List blocksJson}) {
      return <Block>[for (var blockJson in blocksJson) Block.fromJson(blockJson)];
    } else {
      throw const FormatException('Unexpected JSON format');
    }
  }
}

const documentJson = '''
{
  "metadata": {
    "title": "My Document",
    "modified": "2023-09-10"
  },
  "blocks": [
    {
      "type": "h1",
      "text": "Chapter 1"
    },
    {
      "type": "p",
      "text": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
    },
    {
      "type": "checkbox",
      "checked": false,
      "text": "Learn Dart 3"
    }
  ]
}
''';

sealed class Block {
  Block();
  //Jsonからインスタンスを作成する
  factory Block.fromJson(Map<String, Object?> json) {
    return switch (json) {
      {'type': 'h1', 'text': String text} => HeaderBlock(text),
      {'type': 'p', 'text': String text} => ParagraphBlock(text),
      {'type': 'checkbox', 'text': String text, 'checked': bool checked} => CheckboxBlock(text, checked),
      _ => throw const FormatException('unexpected JSON format'),
    };
  }
}

//JSONデータのh1
class HeaderBlock extends Block {
  final String text;
  HeaderBlock(this.text);
}

//JSONデータのp
class ParagraphBlock extends Block {
  final String text;
  ParagraphBlock(this.text);
}

//JSONデータのcheckbox
class CheckboxBlock extends Block {
  final String text;
  final bool isChecked;
  CheckboxBlock(this.text, this.isChecked);
}
