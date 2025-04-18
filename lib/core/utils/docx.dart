import 'dart:convert';
import 'package:archive/archive.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:xml/xml.dart';

class Docx {
  late String fileName;
  Map<String, String> list = {};
  Map<String, String> imageBase64Map = <String, String>{};

  Future<List> convertToJson(dynamic testFile) async {
    String text = await _convertDocxToText(testFile);
    List<String> questions = text.split('<question>');
    questions.removeAt(0);

    List<dynamic> data = [];

    for (var question in questions) {
      var variants = question.split('<variant>');
      var title = variants.removeAt(0).trim();
      var body = [];
      int maxScore = 0;
      bool hasScore = false;
      for (var variant in variants) {
        variant = variant.trim();
        var variantWithScore = variant.split('<SCORE>');
        int score = 0;
        if (variantWithScore.length > 1) {
          hasScore = true;
          variant = variantWithScore[1].trim();
          maxScore += 1;
        }
        body.add({
          "text": variant,
          "score": score,
        });
      }
      if (!hasScore) {
        body[0]["score"] = 1;
        maxScore += 1;
      }
      data.add({
        "title": title,
        "body": body,
        "maxScore": maxScore,
      });
    }
    return data;
  }

  Future<String> _convertDocxToText(dynamic testFile) async {
    final Uint8List bytes;

    if (kIsWeb) {
      bytes = testFile;
    } else {
      bytes = await testFile.readAsBytes();
    }

    fileName = kIsWeb ? 'uploaded_file.docx' : basename(testFile.path);
    final archive = ZipDecoder().decodeBytes(bytes);

    String text = '';

    for (final file in archive) {
      if (file.isFile) {
        final fileName = file.name;
        if (fileName.endsWith('.xml.rels')) {
          // Process .xml.rels files
          final content = XmlDocument.parse(utf8.decode(file.content));
          var elements = content.findAllElements('Relationship');
          for (var element in elements) {
            var target = element.getAttribute('Target') ?? '';
            target = target.replaceAll('media/', '').split('.')[0];
            var id = element.getAttribute('Id') ?? '';
            list[id] = target;
          }
        }
      }
    }

    for (final file in archive) {
      if (file.isFile) {
        final fileName = file.name;
        if (fileName.startsWith('word/media/')) {
          // Process image files
          final imageBytes = file.content;
          final base64Image = base64Encode(imageBytes);
          final imageName = basenameWithoutExtension(fileName);
          var key = list.keys.firstWhere(
            (el) => list[el] == imageName,
            orElse: () => '',
          );
          imageBase64Map[key] = base64Image;
        }
      }
    }

    for (final file in archive) {
      if (file.isFile) {
        final fileName = file.name;
        if (fileName.endsWith('.xml') && fileName.contains('document')) {
          final content = utf8.decode(file.content);
          text += processXmlContent(content);
        }
      }
    }
    return text;
  }

  String processXmlContent(String xmlContent) {
    final document = XmlDocument.parse(xmlContent);
    final buffer = StringBuffer();

    for (final element in document.findAllElements('w:p')) {
      buffer.writeln(_processParagraph(element));
    }

    return buffer.toString();
  }

  String _processParagraph(XmlElement paragraph) {
    final buffer = StringBuffer();

    for (final child in paragraph.children) {
      if (child is XmlElement) {
        if (child.name.toString() == 'w:r') {
          buffer.write(_processRun(child));
        }
        // Handle other cases as needed
      }
    }

    return buffer.toString();
  }

  String _processRun(XmlElement run) {
    final buffer = StringBuffer();

    for (final child in run.children) {
      if (child is XmlElement) {
        if (child.name.toString() == 'w:t') {
          // ignore: deprecated_member_use
          buffer.write(child.text);
        } else if (child.name.toString() == 'w:object') {
          // Process image placeholder in <w:object>
          var imageId =
              child.findAllElements('v:imagedata').first.getAttribute('r:id');
          final base64Image = imageBase64Map[imageId];
          if (base64Image != null) {
            buffer.write('<testerx_img>TESTERX$base64Image<testerx_img>');
          }
        } else if (child.name.toString() == 'w:drawing') {
          var imageId =
              child.findAllElements('a:blip').first.getAttribute('r:embed');
          final base64Image = imageBase64Map[imageId];
          if (base64Image != null) {
            buffer.write('<testerx_img>TESTERX$base64Image<testerx_img>');
          }
        }
      }
    }

    return buffer.toString();
  }
}
