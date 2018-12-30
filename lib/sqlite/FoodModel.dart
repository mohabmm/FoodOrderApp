import 'dart:convert';

Food foodFromJson(String str) {
  final jsonData = json.decode(str);
  return Food.fromMap(jsonData);
}

String foodToJson(Food data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Food {
  int id;
  String foodName;
  int price;
  int total;

  Food({
    this.id,
    this.foodName,
    this.price,
    this.total,
  });

  factory Food.fromMap(Map<String, dynamic> json) => new Food(
      id: json["id"],
      foodName: json["food_name"],
      price: json["price"],
      total: json["total"]
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "food_name": foodName,
        "price": price,
        "total": total,
      };
}
