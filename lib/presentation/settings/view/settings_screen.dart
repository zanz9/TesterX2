// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testerx2/models/index.dart';
import 'package:testerx2/presentation/settings/settings.dart';
import 'package:testerx2/ui/theme/provider.dart';
import 'package:testerx2/ui/widgets/index.dart';
import 'package:testerx2/utils/shared_preferences/index.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  Future<void> pickFolder() async {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
    if (selectedDirectory == null) {
      return;
    }
    //! shared_preferense save folder
  }

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

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(title: Text('Настройки')),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          ToggleContainer(
            bodyText: 'Темная тема',
            initialValue: Provider.of<ThemeSettings>(context).currentTheme ==
                ThemeMode.dark,
            onTap: () => Provider.of<ThemeSettings>(context, listen: false)
                .toggleTheme(),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          const BuildUseFIlesFromFolder(),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          // SliverToBoxAdapter(
          //   child: ListContainer(
          //     bodyText: 'Редактор',
          //     rightSide: const Icon(Icons.arrow_forward_ios_rounded),
          //     onTap: () {
          //       context.router.push(const TestEditorRoute());
          //     },
          //   ),
          // ),
          // const SliverToBoxAdapter(child: SizedBox(height: 8)),
          SliverToBoxAdapter(
            child: ListContainer(
              bodyText: 'Изменить папку',
              secondaryText: 'Папка в которой хранятся файлы для теста',
              rightSide: Icon(
                Icons.arrow_forward_ios_rounded,
                color: theme.hintColor,
              ),
              onTap: () {
                pickFolder();
              },
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverToBoxAdapter(
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
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverToBoxAdapter(
            child: ListContainer(
              bodyText: 'Выйти из аккаунта',
              rightSide: Icon(
                Icons.exit_to_app,
                color: theme.hintColor,
              ),
              onTap: () {
                signOut();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BuildUseFIlesFromFolder extends StatefulWidget {
  const BuildUseFIlesFromFolder({
    super.key,
  });

  @override
  State<BuildUseFIlesFromFolder> createState() =>
      _BuildUseFIlesFromFolderState();
}

class _BuildUseFIlesFromFolderState extends State<BuildUseFIlesFromFolder> {
  @override
  Widget build(BuildContext context) {
    bool value = false;

    @override
    void initState() {
      super.initState();
      getLocalTxFiles().then((v) => value = v);
    }

    return ToggleContainer(
      bodyText: 'Использовать файлы из папки',
      initialValue: value,
      onTap: () {
        getLocalTxFiles().then((v) {
          setLocalTxFiles(!v);
        });
      },
    );
  }
}
