enum FoodCategoryType {
  FAST_FOOD("Fast Food"),
  DINE_IN("Dine-In"),
  CARRY_OUT("Carry-Out"),
  MEXICAN("Mexican"),
  JAPANESE("Japanese"),
  CHINESE("Chinese"),
  ITALIAN("Italian"),
  MEDITERRANEAN("Mediterranean"),
  SUBS_SANDWICHES("Subs/Sandwiches"),
  PIZZA("Pizza"),
  BURGERS("Burgers"),
  DESSERT("Dessert");

  final String name;

  const FoodCategoryType(this.name);

  static FoodCategoryType fromString(String foodCategory) {
    return FoodCategoryType.values
        .firstWhere((element) => element.name == foodCategory);
  }
}
