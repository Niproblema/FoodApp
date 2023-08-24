import 'package:flutter/material.dart';
import 'package:food_app/models/meal.dart';
import 'package:food_app/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  final Meal _meal;
  final void Function(Meal) _onTapCallback;

  const MealItem(this._meal, this._onTapCallback, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () => _onTapCallback(_meal),
        child: Stack(
          children: [
            Hero(
              tag: _meal.id,
              child: FadeInImage(
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(_meal.imageUrl),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                child: Column(
                  children: [
                    Text(
                      _meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow:
                          TextOverflow.ellipsis, // Text cut off with 3 dots...
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(Icons.schedule, '${_meal.duration} min'),
                        const SizedBox(width: 12),
                        MealItemTrait(Icons.work, complexityText),
                        const SizedBox(width: 12),
                        MealItemTrait(Icons.money, affordabilityText),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  String get complexityText {
    return _meal.complexity.name[0].toUpperCase() +
        _meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    return _meal.affordability.name[0].toUpperCase() +
        _meal.affordability.name.substring(1);
  }
}
