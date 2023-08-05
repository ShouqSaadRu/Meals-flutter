//the goal of this class is to display the page of the meals for a selected category not categories !!!

import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meal_details.dart';
import 'package:meals/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
  });

  final String? title; //also we didn't put required cuz we might make it null
  final List<Meal> meals;

  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => MealDetailsScreen(
              meal: meal,
            )));
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min, //so that the column is centerd
        children: [
          Text(
            'Uh oh ... nothing here !!',
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Try selecting a different category!',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          )
        ],
      ),
    );
    if (meals.isNotEmpty) {
      //in case if the list is empty
      content = ListView.builder(
        //to a widget that outputs this list of meals
        itemCount: meals
            .length, //i have to tell flutter how many meals will be in the list
        itemBuilder: (ctx, index) => MealItem(
          meal: meals[index],
          onSelectMeal: (meal) {
            selectMeal(context, meal);
          },
        ),
      );
    }

    if (title == null) {
      return content;
    } //to differentiate between neals screen and favorites screen so that favorite screen don't have two AppBars

    return Scaffold(
      //cuz it is a screen widget
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
