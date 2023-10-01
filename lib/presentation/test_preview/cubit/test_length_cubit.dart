import 'package:flutter_bloc/flutter_bloc.dart';

class TestLengthCubit extends Cubit<double> {
  TestLengthCubit() : super(25);
  void changeValue(double value) => emit(value);
}
