import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testerx2/presentation/profile/admin/admin.dart';

class AdminWidgets extends StatelessWidget {
  const AdminWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = AdminBloc();
    bloc.add(OnAdmin());
    return BlocProvider.value(
      value: bloc,
      child: BlocBuilder<AdminBloc, AdminState>(
        builder: (context, state) {
          if (state is AdminLoaded) {
            return const Column(
              children: [
                Text(
                  'Админка',
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 20),
                AddGroup(),
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
