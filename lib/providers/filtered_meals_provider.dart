import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/models/meal.dart';
import 'package:food_app/providers/filters_provider.dart';
import 'package:food_app/providers/meals_provider.dart';

final filteredMealsProvider = Provider<List<Meal>>((ref) {
  final meals = ref.watch(mealsProvider);
  final filters = ref.watch(filtersProvider);

  return meals.where((meal) {
    if (!meal.isGlutenFree && filters[Filter.glutenFree]!) {
      return false;
    }
    if (!meal.isLactoseFree && filters[Filter.lactoseFree]!) {
      return false;
    }
    if (!meal.isVegetarian && filters[Filter.vegetarian]!) {
      return false;
    }
    if (!meal.isVegan && filters[Filter.vegan]!) {
      return false;
    }
    return true;
  }).toList();
});
