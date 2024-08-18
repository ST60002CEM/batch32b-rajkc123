import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define the state for the pricing view, you can expand this as needed
class PricingState {
  // Add any state you want to manage
  final int selectedPlanDays;
  PricingState({this.selectedPlanDays = 0});
}

// Notifier to manage the state
class PricingNotifier extends StateNotifier<PricingState> {
  PricingNotifier() : super(PricingState());

  void selectPlan(int days) {
    // Update the state when a plan is selected
    state = PricingState(selectedPlanDays: days);
    // Handle additional logic such as navigation
  }
}

// Create a provider for the PricingNotifier
final pricingNotifierProvider =
    StateNotifierProvider<PricingNotifier, PricingState>(
        (ref) => PricingNotifier());
