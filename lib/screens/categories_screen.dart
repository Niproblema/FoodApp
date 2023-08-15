import 'package:flutter/material.dart';
import 'package:food_app/data/dummy_data.dart';
import 'package:food_app/models/category.dart';
import 'package:food_app/models/meal.dart';
import 'package:food_app/screens/meals_screen.dart';
import 'package:food_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  final void Function(Meal meal) onToggleFavouriteCallback;
  final List<Meal> _availableMeals;

  const CategoriesScreen(this.onToggleFavouriteCallback, this._availableMeals,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        for (final Category cat in availableCategories)
          CategoryGridItem(
            cat,
            () => selectCategory(context, cat),
          )
      ],
    );
  }

  void selectCategory(BuildContext context, Category category) {
    List<Meal> meals = _availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MealsScreen(
              title: category.title,
              meals: meals,
              onToggleFavouriteCallback: onToggleFavouriteCallback),
        ));
  }
}
