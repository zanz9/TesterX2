import 'package:animations/animations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testerx2/presentation/new_home/new_home.dart';
import 'package:testerx2/repository/repository.dart';
import 'package:testerx2/ui/ui.dart';

@RoutePage()
class NewHomeScreen extends StatelessWidget {
  const NewHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
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
                        child: OpenContainer(
                          openBuilder: (context, _) => NewTestPreview(
                            test: test,
                          ),
                          closedBuilder: (context, openContainer) =>
                              GestureDetector(
                            onTap: openContainer,
                            child: PrimaryListWidget(
                              text: test.name,
                            ),
                          ),
                          transitionType: ContainerTransitionType.fadeThrough,
                          transitionDuration: const Duration(milliseconds: 350),
                          openColor: theme.scaffoldBackgroundColor,
                          middleColor: theme.scaffoldBackgroundColor,
                          closedColor: theme.scaffoldBackgroundColor,
                          openShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          closedShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          tappable: true,
                          closedElevation: 0,
                        ),
                      );
                    },
                  );
                } else if (state is HomeUserNotHaveGroup) {
                  return const SliverToBoxAdapter(
                      child: Text('Пользователь не состоит в группе'));
                } else if (state is HomeUserGroupNotHaveTests) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        'В этой группе нет ни одного теста',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  );
                } else {
                  return const SliverToBoxAdapter(child: SizedBox());
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
