import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testerx2/presentation/test_preview/cubit/test_length_cubit.dart';

class TestLengthSlider extends StatelessWidget {
  const TestLengthSlider({super.key, required this.sliderLength});
  final double sliderLength;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (sliderLength < 25) {
      context.read<TestLengthCubit>().changeValue(1);
    }
    return BlocBuilder<TestLengthCubit, double>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          height: 100,
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: theme.shadowColor,
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Длина теста ${state.toInt()}',
                style: theme.textTheme.bodyLarge,
              ),
              SizedBox(
                width: double.infinity,
                child: CupertinoSlider(
                  value: state,
                  max: sliderLength,
                  min: 1,
                  activeColor: theme.primaryColor,
                  onChanged: (v) {
                    context.read<TestLengthCubit>().changeValue(v);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
