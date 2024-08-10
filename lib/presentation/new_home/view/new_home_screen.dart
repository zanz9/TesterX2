import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:testerx2/presentation/new_home/new_home.dart';

@RoutePage()
class NewHomeScreen extends StatelessWidget {
  const NewHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const HomeSliverAppBar(),
          const SliverToBoxAdapter(child: SizedBox(height: 30)),
          SliverList.builder(
            itemCount: 20,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 18),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.white),
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                ),
                height: 54,
                child: const Row(
                  children: [
                    Text(
                      'Название теста 54',
                      style: TextStyle(fontSize: 18),
                    ),
                    Spacer(),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: Colors.black,
                      size: 36,
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
