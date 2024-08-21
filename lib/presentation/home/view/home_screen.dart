import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testerx2/presentation/home/home.dart';
import 'package:testerx2/repository/repository.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => HomeBloc()..add(OnHome()),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: SizedBox(height: 30)),
            const HomeSliverAppBar(),
            const SliverToBoxAdapter(child: SizedBox(height: 30)),
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeTestsLoaded) {
                  List<TestModel> tests = state.tests;
                  return SliverList.builder(
                    itemCount: tests.length,
                    itemBuilder: (context, index) {
                      TestModel test = tests[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 6),
                        child: TestListWidget(test: test),
                      );
                    },
                  );
                } else {
                  String text = '';
                  if (state is HomeUserNotHaveGroup) {
                    text = 'Пользователь не состоит в группе';
                  } else if (state is HomeUserGroupNotHaveTests) {
                    text = 'В этой группе нет ни одного теста';
                  }
                  return SliverToBoxAdapter(
                      child: Text(text, style: const TextStyle(fontSize: 18)));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
