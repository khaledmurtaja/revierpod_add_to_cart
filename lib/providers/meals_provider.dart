import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/meals_repository.dart';
import '../models/meal.dart';

final mealsRepositoryProvider = Provider<MealsRepository>((ref) {
  return MealsRepository();
});

final mealsProvider = FutureProvider<List<Meal>>((ref) async {
  final repository = ref.read(mealsRepositoryProvider);
  return repository.getMeals();
});

final searchQueryProvider = StateProvider<String>((ref) => '');

final filteredMealsProvider = FutureProvider<List<Meal>>((ref) async {
  final searchQuery = ref.watch(searchQueryProvider);
  final repository = ref.read(mealsRepositoryProvider);
  
  if (searchQuery.isEmpty) {
    return repository.getMeals();
  } else {
    return repository.searchMeals(searchQuery);
  }
});

final mealByIdProvider = FutureProvider.family<Meal?, String>((ref, mealId) async {
  final repository = ref.read(mealsRepositoryProvider);
  return repository.getMealById(mealId);
});
