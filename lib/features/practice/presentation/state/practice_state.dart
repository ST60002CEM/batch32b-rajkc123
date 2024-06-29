import 'package:finalproject/features/practice/domain/entity/practice_task_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dartz/dartz.dart';
import 'package:finalproject/core/failure/failure.dart';
import 'package:finalproject/features/practice/domain/usecases/get_all_practice_tasks_usecase.dart';

final practiceStateProvider = StateNotifierProvider<PracticeStateNotifier, PracticeState>(
  (ref) => PracticeStateNotifier(ref.watch(getAllPracticeTasksProvider)),
);

class PracticeState {
  final List<PracticeTaskEntity> tasks;
  final bool isLoading;
  final String errorMessage;
  final bool submitted;
  final String? currentExplanation;
  final String? userAnswer;
  final int currentIndex;

  PracticeState({
    required this.tasks,
    required this.isLoading,
    required this.errorMessage,
    required this.submitted,
    required this.currentExplanation,
    required this.userAnswer,
    required this.currentIndex,
  });

  PracticeState.initial()
      : tasks = [],
        isLoading = false,
        errorMessage = '',
        submitted = false,
        currentExplanation = null,
        userAnswer = null,
        currentIndex = 0;

  PracticeState copyWith({
    List<PracticeTaskEntity>? tasks,
    bool? isLoading,
    String? errorMessage,
    bool? submitted,
    String? currentExplanation,
    String? userAnswer,
    int? currentIndex,
  }) {
    return PracticeState(
      tasks: tasks ?? this.tasks,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      submitted: submitted ?? this.submitted,
      currentExplanation: currentExplanation ?? this.currentExplanation,
      userAnswer: userAnswer ?? this.userAnswer,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}

class PracticeStateNotifier extends StateNotifier<PracticeState> {
  final GetAllPracticeTasks _getAllPracticeTasks;

  PracticeStateNotifier(this._getAllPracticeTasks) : super(PracticeState.initial()) {
    fetchPracticeTasks();
  }

  Future<void> fetchPracticeTasks() async {
    state = state.copyWith(isLoading: true);
    final result = await _getAllPracticeTasks();
    result.fold(
      (failure) => state = state.copyWith(isLoading: false, errorMessage: failure.error),
      (tasks) => state = state.copyWith(isLoading: false, tasks: tasks),
    );
  }

  void nextQuestion() {
    if (state.tasks.isNotEmpty) {
      final newIndex = (state.currentIndex + 1) % state.tasks.length;
      state = state.copyWith(
        currentIndex: newIndex,
        submitted: false,
        currentExplanation: null,
        userAnswer: null,
      );
    }
  }

  void goToQuestion(int index) {
    if (state.tasks.isNotEmpty && index >= 0 && index < state.tasks.length) {
      state = state.copyWith(
        currentIndex: index,
        submitted: false,
        currentExplanation: null,
        userAnswer: null,
      );
    }
  }

  void submitAnswer(String answer) {
    if (state.tasks.isNotEmpty) {
      final currentTask = state.tasks[state.currentIndex];
      state = state.copyWith(
        submitted: true,
        currentExplanation: currentTask.explanation,
        userAnswer: answer,
      );
    }
  }
}
