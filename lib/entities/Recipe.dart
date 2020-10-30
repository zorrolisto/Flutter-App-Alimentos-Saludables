
class Recipe {
  final String title;
  final String creditsText;
  final num pricePerServing;
  final num readyInMinutes;
  final String image;
  final String summary;
  final String sourceName;

  Recipe({this.creditsText, this.title, this.pricePerServing, this.readyInMinutes, this.image, this.summary, this.sourceName});

  factory Recipe.fromJson(Map<String, dynamic> json)=> Recipe(
    creditsText: json['creditsText'],
    title: json['title'],
    pricePerServing: json['pricePerServing'],
    readyInMinutes: json['readyInMinutes'],
    image: json['image'],
    summary: json['summary'],
    sourceName: json['sourceName'],
  );
}