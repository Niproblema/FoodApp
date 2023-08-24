import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/models/meal.dart';
import 'package:food_app/providers/favourites_provider.dart';

class MealDetailsScreen extends ConsumerWidget {
  final Meal _meal;

  const MealDetailsScreen(this._meal, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Meal> favMeals = ref.watch(favouriteMealsProvider);
    bool isFavourited = favMeals.contains(_meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(_meal.title),
        actions: [
          IconButton(
            onPressed: () {
              bool added = ref
                  .read(favouriteMealsProvider.notifier)
                  .toggleMealFavouriteStatus(_meal);

              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(added
                    ? 'Meal added as a favorite.'
                    : 'Meal removed from favourites.'),
                duration: const Duration(seconds: 2),
              ));
            },
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: Tween<double>(begin: 0.9, end: 1).animate(animation),
                  child: child,
                );
              },
              child: Icon(
                isFavourited ? Icons.star : Icons.star_border_outlined,
                key: ValueKey(isFavourited),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: _meal.id,
              child: Image.network(
                _meal.imageUrl,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 6),
            for (final String ingredient in _meal.ingredients)
              Text(
                ingredient,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            const SizedBox(height: 24),
            Text(
              'Steps',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 6),
            for (final String step in _meal.steps)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 16,
                ),
                child: Text(
                  step,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
