import 'package:flutter/material.dart';
import 'package:food_app/data/dummy_data.dart';
import 'package:food_app/models/category.dart';
import 'package:food_app/models/meal.dart';
import 'package:food_app/screens/meals_screen.dart';
import 'package:food_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatefulWidget {
  final List<Meal> _availableMeals;

  const CategoriesScreen(this._availableMeals, {super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0, // These are defaults anyway.
      upperBound: 1, // These are defaults anyway.
    );
    super.initState();

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
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
      ),
      builder: (context, child) => SlideTransition(
        position: Tween(
          begin: const Offset(0, 1),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.decelerate),
        ),
        child: child,
      ),
    );
  }

  void selectCategory(BuildContext context, Category category) {
    List<Meal> meals = widget._availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              MealsScreen(title: category.title, meals: meals),
        ));
  }
}
