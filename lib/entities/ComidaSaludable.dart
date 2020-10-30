
import 'package:flutter_app3/entities/Recipe.dart';

class ComidaSaludable{
  List<Recipe> recipes;

  ComidaSaludable({this.recipes});

  factory ComidaSaludable.fromJson(Map<String, dynamic> json) {
    //return ComidaSaludable(
    //recipes: json['recipes']
    // );
    return ComidaSaludable(
        recipes: List<Recipe>.from(json["recipes"].map((x) => Recipe.fromJson(x)))
    );
  }
}
