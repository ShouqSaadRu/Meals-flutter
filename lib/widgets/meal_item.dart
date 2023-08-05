import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal, required this.onSelectMeal});

  final Meal meal;
  final void Function(Meal meal) onSelectMeal;

  String get comlexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(
            1); //[0] to accsess first character in a string to make it upper case
  } //meal.complexity.name[0].toUpperCase() it returns only the first chart so we have to combin it to the rest

  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(
            1); //[0] to accsess first character in a string to make it upper case
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        //cuz also we want to make the meals tapable so that when clicking on oi we show the details
        onTap: () {
          onSelectMeal(meal);
        },
        child: Stack(
          //Stack يعني مثلا نحط كلام على صورة
          children: [
            Hero(
              //for the image to slide in a nice look
              tag: meal.id,
              child: FadeInImage(
                //اول شي نحط الاخير او الاساس لاننا هنا نشتغل على اساس الستاك
                placeholder: MemoryImage(
                    kTransparentImage), //check "flutter transparent image" in google these image will be the placeholder
                image: NetworkImage(meal.imageUrl),
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            Positioned(
                // positioning a widget on top another widget in stack
                bottom: 0, //
                left: 0, //
                right:
                    0, //these to ensure that the child which is the Container will be added on top   of the bottom fadeInImage and spins from the very left to the very right
                child: Container(
                  color: Colors.black54,
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                  child: Column(
                    children: [
                      Text(
                        meal.title,
                        maxLines:
                            2, //only two lines and if there is more it will cut of
                        textAlign: TextAlign.center,
                        softWrap: true,
                        overflow: TextOverflow
                            .ellipsis, //to determine how the text will cut of if it have to
                        //very long text ....
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MealItemTrait(
                              icon: Icons.schedule,
                              label: '${meal.duration}min'),
                          const SizedBox(
                            width: 12,
                          ),
                          MealItemTrait(icon: Icons.work, label: comlexityText),
                          MealItemTrait(
                              icon: Icons.attach_money,
                              label: affordabilityText)
                        ],
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
