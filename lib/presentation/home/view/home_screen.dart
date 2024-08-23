import 'package:auto_route/auto_route.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testerx2/presentation/home/home.dart';
import 'package:testerx2/repository/repository.dart';
import 'package:testerx2/router/router.dart';
import 'package:testerx2/ui/ui.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var homeBloc = HomeBloc()..add(OnHome());
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: homeBloc,
        ),
        BlocProvider(
          lazy: false,
          create: (context) => HomeLastTestBloc()..add(OnHomeLastTest()),
        ),
      ],
      child: Scaffold(
        body: GestureDetector(
          onPanEnd: (details) async {
            int direction = 3;
            if (details.velocity.pixelsPerSecond.dx < direction) {
              await context.router.push(const ProfileRoute());
              if (context.mounted) homeBloc.add(OnHome());
            }
          },
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: SizedBox(height: 30)),
              const HomeSliverAppBar(),
              const SliverToBoxAdapter(child: SizedBox(height: 30)),
              BlocBuilder<HomeLastTestBloc, HomeLastTestState>(
                builder: (context, state) {
                  if (state is HomeLastTestLoaded) {
                    return SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: DottedBorder(
                          color: Colors.black,
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(20),
                          dashPattern: const [10, 10],
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          child: Column(
                            children: [
                              const Text(
                                'Вы еще не завершили этот тест',
                                style: TextStyle(
                                  fontSize: 22,
                                ),
                              ),
                              const SizedBox(height: 10),
                              GestureDetector(
                                onTap: () => context.router
                                    .replace(const TestPageRoute()),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 6),
                                  child: PrimaryListWidget(
                                    text: state.testModel.name,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return const SliverToBoxAdapter();
                  }
                },
              ),
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
                        child:
                            Text(text, style: const TextStyle(fontSize: 18)));
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
