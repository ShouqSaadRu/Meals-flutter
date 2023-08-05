import 'package:riverpod/riverpod.dart';

//in terminal install both flutter pub add riverpod and flutter pub add flutter_riverpod

import 'package:meals/data/dummy_data.dart';

final mealsProvider = Provider((ref) {
  return dummyMeals;
});
