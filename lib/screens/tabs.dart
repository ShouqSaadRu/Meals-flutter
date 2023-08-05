import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';
import 'package:meals/providers/favorites_provider.dart';
import 'package:meals/providers/filters_provider.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  //for provider
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0; //0 for first page and 1 for second page

  /* void _toggleMealFavoriteStatus(Meal meal) {
    //this function should add a meal to the list or remove a meal
    final isExisting = _favoriteMeals.contains(
        meal); //to check wether this meal in in the  _favoriteMeals list if it is true then we will remove it and if its not then we will add it to the favorite list

    if (isExisting) {
      setState(() {
        //عشان لما احذف طبق ينحذف على طول من الصفحة
        _favoriteMeals.remove(meal);
      });
      _showInfoMessage('Meal is no longer a favorite');
    } else {
      setState(() {
        _favoriteMeals.add(meal);
      });
      _showInfoMessage('Marked as a favorite');
    }
  }*/ //we don't need it anymore cuz we made it in a seperate class

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    if (identifier == 'filters') {
      Navigator.of(context).pop();
      Navigator.of(context).push<Map<Filter, bool>>(
          //check filters class for example  Filter.glutenFree: _glutenFreeFilterSet, here the key is of type Filter and the value of type boolean
          MaterialPageRoute(builder: (ctx) => const FiltersScreen()));
      /*setState(() {
        _selectedFilters = result ??
            kInitialFilters; //if result is null then use kInitialFilters instead
      });*/
    } else {
      //if we select meals we just want to close the drawer cuz we are already on the meals screen or on that meals area on the app
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealsProvider);

    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(
          favoriteMealsProvider); //ref.watch() yields List<Meal> not the Notifier class !!!

      activePage = MealsScreen(
        //cuz in favorite screen i wanna reuse the meals screen cuz favorite screen displays meals ! wowww
        meals: favoriteMeals,
      ); //so .. this function will go to Meals screen then meal_details screen to the star bottoun
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          activePageTitle,
        ),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        //to make the bottom bar to navigate between screens
        onTap: _selectPage,
        currentIndex:
            _selectedPageIndex, //to tell the navigation bar which page is selected
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal),
              label: 'Categories'), //for the category screen
          BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: 'Favorites'), //for the favorite screen
          //whenever we tap one of these taps we triggor _selectPage
        ],
      ),
    );
  }
}
