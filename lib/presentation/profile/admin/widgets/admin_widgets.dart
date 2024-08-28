import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testerx2/presentation/profile/admin/admin.dart';

class AdminWidgets extends StatelessWidget {
  const AdminWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => AdminBloc()..add(OnAdmin()),
      child: BlocBuilder<AdminBloc, AdminState>(
        builder: (context, state) {
          if (state is AdminLoaded) {
            return const Column(
              children: [
                SizedBox(height: 30),
                Text(
                  'Админка',
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 20),
                AddGroup(),
                SizedBox(height: 10),
                AddTest(),
              ],
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
