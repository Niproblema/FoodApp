import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/models/meal.dart';
import 'package:food_app/providers/favourites_provider.dart';
import 'package:food_app/providers/filtered_meals_provider.dart';
import 'package:food_app/providers/filters_provider.dart';
import 'package:food_app/screens/categories_screen.dart';
import 'package:food_app/screens/filters_screen.dart';
import 'package:food_app/screens/meals_screen.dart';
import 'package:food_app/widgets/main_drawer.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Meal> availableMeals = ref.watch(filteredMealsProvider);

    Widget activePage;
    final String activePageTitle;
    if (_selectedPageIndex == 0) {
      activePage = CategoriesScreen(availableMeals);
      activePageTitle = 'Categories';
    } else {
      final favoriteMeals = ref.watch(favouriteMealsProvider);
      activePageTitle = 'Favourites';
      activePage = MealsScreen(meals: favoriteMeals);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(_setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: _selectNavPage,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favourites',
          ),
        ],
      ),
    );
  }

  void _selectNavPage(int tabIndex) {
    setState(() {
      _selectedPageIndex = tabIndex;
    });
  }

  void _setScreen(String screenName) {
    if (screenName == 'meals') {
      Navigator.of(context).pop();
    } else if (screenName == 'filters') {
      Navigator.of(context).pop();
      Navigator.of(context).push<Map<Filter, bool>>(
          MaterialPageRoute(builder: (ctx) => const FiltersScreen()));
    }
  }
}
