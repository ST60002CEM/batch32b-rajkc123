import 'dart:async';
import 'package:finalproject/features/practice/domain/entity/practice_task_entity.dart';
import 'package:finalproject/features/practice/domain/usecases/get_all_practice_tasks_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:string_similarity/string_similarity.dart';

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
  final double overallScore;
  final double grammarScore;
  final double spellingScore;

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
    required this.overallScore,
    required this.grammarScore,
    required this.spellingScore,
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
        wordCount = 0,
        overallScore = 0.0,
        grammarScore = 0.0,
        spellingScore = 0.0;

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
    double? overallScore,
    double? grammarScore,
    double? spellingScore,
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
      overallScore: overallScore ?? this.overallScore,
      grammarScore: grammarScore ?? this.grammarScore,
      spellingScore: spellingScore ?? this.spellingScore,
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
        overallScore: 0.0,
        grammarScore: 0.0,
        spellingScore: 0.0,
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
        overallScore: 0.0,
        grammarScore: 0.0,
        spellingScore: 0.0,
      );
      startTimer();
    }
  }

  void submitAnswer(String answer) {
    if (state.tasks.isNotEmpty) {
      final currentTask = state.tasks[state.currentIndex];

      // Calculate scores separately using appropriate methods
      final overallScore = _calculateOverallScore(answer, currentTask.explanation);
      final grammarScore = _calculateGrammarScore(answer, currentTask.explanation);
      final spellingScore = _calculateSpellingScore(answer, currentTask.explanation);

      state = state.copyWith(
        submitted: true,
        currentExplanation: currentTask.explanation,
        userAnswer: answer,
        overallScore: overallScore,
        grammarScore: grammarScore,
        spellingScore: spellingScore,
      );
    }
  }

  double _calculateOverallScore(String userAnswer, String explanation) {
    // Combine different criteria for an overall score
    double grammarScore = _calculateGrammarScore(userAnswer, explanation);
    double spellingScore = _calculateSpellingScore(userAnswer, explanation);
    return (grammarScore + spellingScore) / 2;
  }

  double _calculateGrammarScore(String userAnswer, String explanation) {
    // Example grammar check logic
    // Placeholder: Compare based on similarity
    return userAnswer.similarityTo(explanation) * 100;
  }

  double _calculateSpellingScore(String userAnswer, String explanation) {
    // Example spelling check logic
    // Placeholder: Compare based on similarity, but could be replaced with a more complex spell checker
    List<String> answerWords = userAnswer.split(' ');
    List<String> explanationWords = explanation.split(' ');

    int correctWords = 0;

    for (String word in answerWords) {
      if (explanationWords.contains(word)) {
        correctWords++;
      }
    }

    return (correctWords / explanationWords.length) * 100;
  }

  void resetCurrentQuestion() {
    state = state.copyWith(
      submitted: false,
      currentExplanation: null,
      userAnswer: null,
      timer: 60,
      overallScore: 0.0,
      grammarScore: 0.0,
      spellingScore: 0.0,
    );
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
