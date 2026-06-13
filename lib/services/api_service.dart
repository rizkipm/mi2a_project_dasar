import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mi2a_project_dasar/models/model_berita.dart';
import 'package:mi2a_project_dasar/models/model_photos.dart';

class ApiService {
   static const String urlPhotos = "https://jsonplaceholder.typicode.com/photos";
   static const String urlUsers = "https://jsonplaceholder.typicode.com/photos";

   static const String urlGambarBerita = "http://10.11.17.54/berita_api/gambar/";
   static const String urlGetBerita = "http://10.11.17.54/berita_api/getBerita.php";
   //register
   static const String urlRegister = "http://10.11.17.54/berita_api/register.php";
   static const String urlLogin = "http://10.11.17.54/berita_api/login.php";

   static Future<List<ModelPhotos>> fetchDataPhotos() async{
     final response = await http.get(Uri.parse(urlPhotos));

     if(response.statusCode == 200){
       List jsonData = json.decode(response.body);
       return jsonData.take(50)// dibatasi 50 data dulu
         .map((e) => ModelPhotos.fromJson(e))
         .toList();
     }else{
       throw Exception("Gagal mengambil data");
     }
   }

   static Future<List<Datum>> getDataBerita() async{
     final response = await http.get(Uri.parse(urlGetBerita));

     if(response.statusCode == 200){
       return modelBeritaFromJson(response.body).data;
     }else{
       throw Exception("Gagal mengambil data");
     }
   }

   static Future<List<ModelPhotos>> fecthDataUsers() async{
     final response = await http.get(Uri.parse(urlUsers));

     if(response.statusCode == 200){
       List jsonData = json.decode(response.body);
       return jsonData.take(50)// dibatasi 50 data dulu
           .map((e) => ModelPhotos.fromJson(e))
           .toList();
     }else{
       throw Exception("Gagal mengambil data");
     }
   }
}