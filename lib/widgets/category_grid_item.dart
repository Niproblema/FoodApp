import 'package:flutter/material.dart';
import 'package:food_app/models/category.dart';

class CategoryGridItem extends StatelessWidget {
  final Category _category;
  final void Function() _onClickCallback;

  const CategoryGridItem(this._category, this._onClickCallback, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onClickCallback,
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            colors: [
              _category.color.withOpacity(0.55),
              _category.color.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(
          _category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ),
    );
  }
}
