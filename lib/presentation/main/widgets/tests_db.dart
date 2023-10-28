import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:testerx2/router/router.dart';
import 'package:testerx2/ui/widgets/index.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class TestsDb extends StatefulWidget {
  const TestsDb({
    super.key,
  });

  @override
  State<TestsDb> createState() => _TestsDbState();
}

class _TestsDbState extends State<TestsDb> {
  List files = [];

  void listofFiles() async {
    if (!kIsWeb) {
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
      var status2 = await Permission.manageExternalStorage.status;
      if (!status2.isGranted) {
        await Permission.manageExternalStorage.request();
      }
    }

    FirebaseFirestore db = FirebaseFirestore.instance;

    db.collection("tests").get().then(
      (querySnapshot) {
        setState(() {
          for (var docSnapshot in querySnapshot.docs) {
            final testName = docSnapshot.data()['name'];
            final qBackup = docSnapshot.data()['tx'];
            final testId = docSnapshot.id;
            files.add([testName, qBackup, testId]);
          }
        });
      },
    );
  }

  @override
  void initState() {
    listofFiles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverList.separated(
      itemCount: files.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (BuildContext context, int index) {
        final file = files[index];
        final fileName = file[0].replaceFirst('.TX', '');
        final testId = file[2];
        return ListContainer(
          bodyText: fileName,
          rightSide:
              Icon(Icons.arrow_forward_ios_rounded, color: theme.hintColor),
          onTap: () {
            context.router.push(TestPreviewRoute(
              testName: fileName,
              file: null,
              qBackup: file[1],
              testId: testId,
            ));
          },
        );
      },
    );
  }
}
