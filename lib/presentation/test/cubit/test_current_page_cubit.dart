import 'package:flutter_bloc/flutter_bloc.dart';

class TestCurrentPageCubit extends Cubit<int> {
  TestCurrentPageCubit() : super(0);

  void changePage(int page) => emit(page);

  void next() => emit(state + 1);

  void prev() => emit(state - 1);
}
