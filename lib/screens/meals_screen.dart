import 'package:flutter/material.dart';
import 'package:food_app/models/meal.dart';
import 'package:food_app/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  final String _title;
  final List<Meal> _meals;

  const MealsScreen(this._title, this._meals, {super.key});

  @override
  Widget build(BuildContext context) {
    // Pupulate content
    Widget content;
    if (_meals.isEmpty) {
      content = Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'No meals available.',
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
          const SizedBox(height: 16),
          Text(
            'Select another category.',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          )
        ],
      ));
    } else {
      content = ListView.builder(
          itemCount: _meals.length,
          itemBuilder: (ctx, index) => MealItem(_meals[index]));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: content,
    );
  }
}
