import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testerx2/presentation/test/models/progress.dart';

part 'answer_event.dart';
part 'answer_state.dart';

class AnswerBloc extends Bloc<AnswerEvent, AnswerState> {
  int currentIndex = 0;
  AnswerBloc() : super(AnswerInitial()) {
    late Map<int, Progress> progressMap = {};

    on<AddIndex>((event, emit) {
      currentIndex = event.index;
    });

    on<OnPressed>((event, emit) {
      final progress = Progress(
        index: currentIndex,
        selected: event.indexAnswer,
        isRight: event.isRight,
      );
      progressMap[currentIndex] = progress;
      emit(AnswerPressed(progressMap: progressMap));
    });
  }
}
