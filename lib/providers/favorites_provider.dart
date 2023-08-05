import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals/models/meal.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]);

  bool toggleMealFavoriteStatus(Meal meal) {
    //we can't use .add or .remove cuz StateNotifier doesn't allow that
    final mealIsFavorite =
        state.contains(meal); //if meal is already in the favorite list

    if (mealIsFavorite) {
      //m.id != meal.id if true then keep it and if it false then drop it
      state = state
          .where((m) => m.id != meal.id)
          .toList(); //the letter m is the meal that i'm comparing with so that if meal is m it will be removed from list and if meal is not m then it will be added to the list
      // state = state.where making a new list cuz we can't use add or remove
      //note that m هي عنصر عنصر باللستة
      return false;
    } else {
      state = [
        ...state,
        meal
      ]; //...state pull out all the exciting meals then keep them and add them to a new list and also add the new meal ,meal]
      return true;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
  // StateNotifierProvider for changeable list
  return FavoriteMealsNotifier();
});
