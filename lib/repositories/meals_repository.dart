import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/meal.dart';

class MealsRepository {
  static const String _mealsJsonPath = 'assets/meals.json';

  Future<List<Meal>> getMeals() async {
    try {
      final String jsonString = await rootBundle.loadString(_mealsJsonPath);
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      final List<dynamic> mealsJson = jsonData['meals'] as List<dynamic>;
      
      return mealsJson.map((json) => Meal.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load meals: $e');
    }
  }

  Future<List<Meal>> searchMeals(String query) async {
    final allMeals = await getMeals();
    if (query.isEmpty) return allMeals;
    
    final lowercaseQuery = query.toLowerCase();
    return allMeals.where((meal) {
      return meal.name.toLowerCase().contains(lowercaseQuery) ||
             meal.description.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }

  Future<Meal?> getMealById(String id) async {
    final meals = await getMeals();
    try {
      return meals.firstWhere((meal) => meal.id == id);
    } catch (e) {
      return null;
    }
  }
}
