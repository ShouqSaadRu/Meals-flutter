import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/category_grid_item.dart';
import 'package:meals/models/category.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController
      _animationController; //AnimationController type from flutter

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(microseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    //i think here cuz we are in statelesswidget we need to put parametrs

    final filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList(); //.contains to check wether a list contain a certain value which is here category.id

    Navigator.of(context).push(
      //to load a different screen للاتنقل بين الصفحات(to navigate between screens)
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
        ),
      ),
    );
    //important note; the return widget is the screen widget that should be displayed
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        child: GridView(
          //هنا تصميم وترتيب المربعات
          padding: const EdgeInsets.all(24),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //هذا يحط لي عمودين جنب بعض
            // gridDelegate CONTROLS the layout of gridview items
            crossAxisCount: 2, //to set number of columns
            childAspectRatio: 3 / 2, //impact the sizing of gridview items
            crossAxisSpacing: 20, //spacing between two columns
            mainAxisSpacing: 20,
          ),
          children: [
            for (final category in availableCategories)
              CategoryGridItem(
                category:
                    category, //the widget that should be output for every category
                onSelectCategory: () {
                  _selectCategory(context,
                      category); //so this function is excuted when the tap is clicked in category grid item class in line 14
                },
              )
            //alternative way : availableCategories.map((category) => CategoryGridItem(category: category)).toList()
          ],
        ),
        builder: (context, child) => SlideTransition(
              position: Tween(
                begin: const Offset(0, 0.3),
                end: const Offset(0, 0),
              ).animate(
                CurvedAnimation(
                    parent: _animationController, curve: Curves.easeInOut),
              ),
              child: child, //child is the GridView
            ));
  }
}
