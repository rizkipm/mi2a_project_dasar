class Movie {

  final String title;
  final String image;
  final String desc;

  Movie({
    required this.title,
    required this.image,
    required this.desc
  });

  factory Movie.fromJson(Map<String, dynamic> json){
    return Movie(
        title: json["title"],
        image: json["image"],
        desc: json["desc"],
    );
  }
}