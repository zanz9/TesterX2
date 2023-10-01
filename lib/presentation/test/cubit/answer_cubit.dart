import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testerx2/presentation/test/models/progress.dart';

class AnswerCubit extends Cubit<Map<int, Progress>> {
  AnswerCubit() : super({});

  void add(int indexPage, Progress progress) {
    state[indexPage] = progress;
    return emit(state);
  }
}
