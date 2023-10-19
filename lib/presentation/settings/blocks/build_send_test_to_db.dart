import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:testerx2/models/index.dart';
import 'package:testerx2/ui/ui.dart';

class BuildSendTestToDB extends StatelessWidget {
  const BuildSendTestToDB({super.key});
  Future<void> pickFilesAndSendToDatabase() async {
    FilePickerResult? selectedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['tx', 'TX', 'bin'],
    );
    final pickedFile = selectedFile!.files.first;
    final path = pickedFile.path!;
    File file = File(path);
    final fileString = await file.readAsString();
    final fileToMap = jsonDecode(fileString);
    TX.fromJson(fileToMap);
    FirebaseFirestore db = FirebaseFirestore.instance;
    final test = <String, dynamic>{
      "name": pickedFile.name,
      "tx": fileString,
    };
    db.collection("tests").add(test);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverToBoxAdapter(
      child: ListContainer(
        bodyText: 'Добавить тест в базу',
        rightSide: Icon(
          Icons.arrow_forward_ios_rounded,
          color: theme.hintColor,
        ),
        onTap: () {
          pickFilesAndSendToDatabase();
        },
      ),
    );
  }
}
