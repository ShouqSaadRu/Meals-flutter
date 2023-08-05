import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meals/models/category.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem(
      {super.key, required this.category, required this.onSelectCategory});

  final Category category;
  final void Function() onSelectCategory;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:
          onSelectCategory, //set up a function that will be triggord whenever this item will be tapped
      splashColor:
          Theme.of(context).primaryColor, //لما أضغط على مربع راح يشع لون منه
      borderRadius: BorderRadius.circular(
          16), //to make the item when i click on it have rounded corners
      child: Container(
        //to make this widget tapable we should wrap it with InkWell or with GestureDetector
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
                16), //to make the item have rounded corners
            gradient: LinearGradient(colors: [
              category.color.withOpacity(0.55),
              category.color.withOpacity(0.9),
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ),
    );
  }
}
