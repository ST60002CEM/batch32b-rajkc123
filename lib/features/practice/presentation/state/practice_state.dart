// practice_state.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dartz/dartz.dart';
import 'package:finalproject/core/failure/failure.dart';
import 'package:finalproject/features/practice/domain/entity/practice_task_entity.dart';
import 'package:finalproject/features/practice/domain/usecases/get_all_practice_tasks_usecase.dart';
import 'dart:async';

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
  final int timer;
  final int wordCount;

  PracticeState({
    required this.tasks,
    required this.isLoading,
    required this.errorMessage,
    required this.submitted,
    required this.currentExplanation,
    required this.userAnswer,
    required this.currentIndex,
    required this.timer,
    required this.wordCount,
  });

  PracticeState.initial()
      : tasks = [],
        isLoading = false,
        errorMessage = '',
        submitted = false,
        currentExplanation = null,
        userAnswer = null,
        currentIndex = 0,
        timer = 60,
        wordCount = 0;

  PracticeState copyWith({
    List<PracticeTaskEntity>? tasks,
    bool? isLoading,
    String? errorMessage,
    bool? submitted,
    String? currentExplanation,
    String? userAnswer,
    int? currentIndex,
    int? timer,
    int? wordCount,
  }) {
    return PracticeState(
      tasks: tasks ?? this.tasks,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      submitted: submitted ?? this.submitted,
      currentExplanation: currentExplanation ?? this.currentExplanation,
      userAnswer: userAnswer ?? this.userAnswer,
      currentIndex: currentIndex ?? this.currentIndex,
      timer: timer ?? this.timer,
      wordCount: wordCount ?? this.wordCount,
    );
  }

  String get formattedTimer {
    final minutes = timer ~/ 60;
    final seconds = timer % 60;
    final secondsFormatted = seconds.toString().padLeft(2, '0');
    return '$minutes:$secondsFormatted';
  }
}

class PracticeStateNotifier extends StateNotifier<PracticeState> {
  final GetAllPracticeTasks _getAllPracticeTasks;
  Timer? _timer;

  PracticeStateNotifier(this._getAllPracticeTasks) : super(PracticeState.initial()) {
    fetchPracticeTasks();
    startTimer();
  }

  Future<void> fetchPracticeTasks() async {
    state = state.copyWith(isLoading: true);
    final result = await _getAllPracticeTasks();
    result.fold(
      (failure) => state = state.copyWith(isLoading: false, errorMessage: failure.message),
      (tasks) => state = state.copyWith(isLoading: false, tasks: tasks),
    );
  }

  void startTimer() {
    _timer?.cancel();
    state = state.copyWith(timer: 60);
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (state.timer == 0) {
        timer.cancel();
      } else {
        state = state.copyWith(timer: state.timer - 1);
      }
    });
  }

  void updateWordCount(String text) {
    final wordCount = text.split(' ').where((word) => word.isNotEmpty).length;
    state = state.copyWith(wordCount: wordCount);
  }

  void nextQuestion() {
    if (state.tasks.isNotEmpty) {
      final newIndex = (state.currentIndex + 1) % state.tasks.length;
      state = state.copyWith(
        currentIndex: newIndex,
        submitted: false,
        currentExplanation: null,
        userAnswer: null,
        timer: 60,
      );
      startTimer();
    }
  }

  void goToQuestion(int index) {
    if (state.tasks.isNotEmpty && index >= 0 && index < state.tasks.length) {
      state = state.copyWith(
        currentIndex: index,
        submitted: false,
        currentExplanation: null,
        userAnswer: null,
        timer: 60,
      );
      startTimer();
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

  void resetCurrentQuestion() {
    state = state.copyWith(
      submitted: false,
      currentExplanation: null,
      userAnswer: null,
      timer: 60,
    );
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
