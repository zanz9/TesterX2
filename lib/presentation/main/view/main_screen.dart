import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:testerx2/router/router.dart';
import 'package:testerx2/ui/widgets/index.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  Future<void> pickFile() async {
    await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['bin', 'TX'],
    );
  }

  Future<void> pickFolder() async {
    await FilePicker.platform.getDirectoryPath();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text('TesterX'),
            actions: [
              IconButton(
                onPressed: () {
                  pickFile();
                },
                icon: const Icon(Icons.file_open),
              ),
              IconButton(
                onPressed: () {
                  pickFolder();
                },
                icon: const Icon(Icons.folder),
              ),
            ],
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          const TestsList()
        ],
      ),
    );
  }
}

class TestsList extends StatefulWidget {
  const TestsList({
    super.key,
  });

  @override
  State<TestsList> createState() => _TestsListState();
}

class _TestsListState extends State<TestsList> {
  List files = [];

  void listofFiles() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    var status2 = await Permission.manageExternalStorage.status;
    if (!status2.isGranted) {
      await Permission.manageExternalStorage.request();
    }

    const directory = '/storage/emulated/0/Download';
    setState(() {
      for (FileSystemEntity f
          in Directory("$directory/").listSync(recursive: true)) {
        String extension = f.path.split('.').last.toLowerCase();
        if (extension == 'tx') {
          files.add(f);
        }
      }
    });
  }

  @override
  void initState() {
    listofFiles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: files.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (BuildContext context, int index) {
        final file = files[index] as File;
        final fileName = file.path.split('/').last.replaceFirst('.TX', '');
        return ListContainer(
          bodyText: fileName,
          rightSide: const Icon(Icons.arrow_forward_ios_rounded),
          onTap: () {
            context.router.push(TestPreviewRoute(
              testName: fileName,
              file: file,
              qBackup: null,
            ));
          },
        );
      },
    );
  }
}
