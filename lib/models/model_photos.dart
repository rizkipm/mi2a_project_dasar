import 'dart:convert';

List<ModelPhotos> modelPhotosFromJson(String str) => List<ModelPhotos>.from(json.decode(str).map((x) => ModelPhotos.fromJson(x)));

String modelPhotosToJson(List<ModelPhotos> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelPhotos {
  int albumId;
  int id;
  String title;
  String url;
  String thumbnailUrl;

  ModelPhotos({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory ModelPhotos.fromJson(Map<String, dynamic> json) {
    int photoId = json["id"];
    return ModelPhotos(
      albumId: json["albumId"],
      id: photoId,
      title: json["title"],
      // Menggunakan Picsum dengan ID unik agar gambar tidak sama semua
      // Format: https://picsum.photos/id/[id]/[width]/[height]
      url: "https://picsum.photos/id/${photoId + 10}/600/600",
      thumbnailUrl: "https://picsum.photos/id/${photoId + 10}/300/300",
    );
  }

  Map<String, dynamic> toJson() => {
    "albumId": albumId,
    "id": id,
    "title": title,
    "url": url,
    "thumbnailUrl": thumbnailUrl,
  };
}