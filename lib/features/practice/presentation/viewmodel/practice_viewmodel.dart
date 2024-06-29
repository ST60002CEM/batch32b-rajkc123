import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:finalproject/features/practice/presentation/state/practice_state.dart';

final practiceViewModelProvider = Provider<PracticeViewModel>((ref) {
  return PracticeViewModel(ref.read(practiceStateProvider.notifier));
});

class PracticeViewModel {
  final PracticeStateNotifier _stateNotifier;

  PracticeViewModel(this._stateNotifier);

  void fetchPracticeTasks() {
    _stateNotifier.fetchPracticeTasks();
  }

  void nextQuestion() {
    _stateNotifier.nextQuestion();
  }

  PracticeState get state => _stateNotifier.state;
}
