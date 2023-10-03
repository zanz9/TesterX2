import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:testerx2/ui/widgets/index.dart';

@RoutePage()
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('История'),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverList.separated(
            itemCount: 20,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              return ListContainer(
                bodyText: 'Тест $index',
                secondaryText: 'Пройдено на 100%',
                rightSide: Icon(Icons.replay, color: theme.hintColor),
                onTap: () {},
              );
            },
          ),
        ],
      ),
    );
  }
}
