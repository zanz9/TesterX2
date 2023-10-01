import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testerx2/models/question.dart';
import 'package:testerx2/presentation/test/bloc/answer_bloc.dart';
import 'package:testerx2/presentation/test/cubit/test_current_page_cubit.dart';
import 'package:testerx2/presentation/test/test.dart';

@RoutePage()
class TestPageScreen extends StatelessWidget {
  const TestPageScreen({
    super.key,
    required this.questions,
  });
  final List<Question> questions;
  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController(initialPage: 0);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TestCurrentPageCubit(),
        ),
        BlocProvider(
          create: (context) => AnswerBloc(),
        ),
      ],
      child: BlocBuilder<TestCurrentPageCubit, int>(
        builder: (context, state) {
          context.read<AnswerBloc>().add(AddIndex(index: state));
          return Scaffold(
            key: key,
            appBar: AppBar(
              title: Text('${state + 1}/${questions.length}'),
              centerTitle: true,
              automaticallyImplyLeading: false,
            ),
            endDrawer: Drawer(
              width: 100,
              child: ListView.separated(
                itemCount: questions.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) => ListTile(
                  title: Text((index + 1).toString()),
                  onTap: () {
                    // context.read<TestCurrentPageCubit>().changePage(index);
                    pageController.animateToPage(
                      index,
                      duration: const Duration(seconds: 1),
                      curve: Curves.ease,
                    );
                  },
                ),
              ),
            ),
            body: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              onPageChanged: (page) {
                context.read<TestCurrentPageCubit>().changePage(page);
              },
              itemCount: questions.length,
              itemBuilder: (context, index) => TestBody(
                question: questions[index],
                pageController: pageController,
              ),
            ),
          );
        },
      ),
    );
  }
}
