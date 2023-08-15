import 'package:flutter/material.dart';
import 'package:food_app/data/dummy_data.dart';
import 'package:food_app/models/meal.dart';
import 'package:food_app/screens/categories_screen.dart';
import 'package:food_app/screens/filters_screen.dart';
import 'package:food_app/screens/meals_screen.dart';
import 'package:food_app/widgets/main_drawer.dart';

const Map<Filter, bool> kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favouriteMeals = [];
  Map<Filter, bool> _selectedFilters = kInitialFilters;

  @override
  Widget build(BuildContext context) {
    final List<Meal> availableMeals = dummyMeals.where((meal) {
      if (!meal.isGlutenFree && _selectedFilters[Filter.glutenFree]!) {
        return false;
      }
      if (!meal.isLactoseFree && _selectedFilters[Filter.lactoseFree]!) {
        return false;
      }
      if (!meal.isVegetarian && _selectedFilters[Filter.vegetarian]!) {
        return false;
      }
      if (!meal.isVegan && _selectedFilters[Filter.vegan]!) {
        return false;
      }
      return true;
    }).toList();

    Widget activePage;
    final String activePageTitle;
    if (_selectedPageIndex == 0) {
      activePage = CategoriesScreen(_toggleMealFavouriteStatus, availableMeals);
      activePageTitle = 'Categories';
    } else {
      activePageTitle = 'Favourites';
      activePage = MealsScreen(
        meals: _favouriteMeals,
        onToggleFavouriteCallback: _toggleMealFavouriteStatus,
      );
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

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    ));
  }

  void _toggleMealFavouriteStatus(Meal meal) {
    setState(() {
      if (!_favouriteMeals.remove(meal)) {
        _favouriteMeals.add(meal);
        _showInfoMessage('Meal added to favourites.');
      } else {
        _showInfoMessage('Meal removed from favourites.');
      }
    });
  }

  void _setScreen(String screenName) {
    if (screenName == 'meals') {
      Navigator.of(context).pop();
    } else if (screenName == 'filters') {
      Navigator.of(context).pop();
      Navigator.of(context)
          .push<Map<Filter, bool>>(
              MaterialPageRoute(builder: (ctx) => FiltersScreen(_selectedFilters)))
          .then(
        (value) {
          setState(() {
            _selectedFilters = value ?? kInitialFilters;
          });
        },
      );
    }
  }
}
