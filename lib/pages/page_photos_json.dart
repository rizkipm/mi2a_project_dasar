import 'package:flutter/material.dart';
import 'package:mi2a_project_dasar/models/model_photos.dart';
import 'package:mi2a_project_dasar/services/api_service.dart';

class PagePhotosJson extends StatefulWidget {
  const PagePhotosJson({super.key});

  @override
  State<PagePhotosJson> createState() => _PagePhotosJsonState();
}

class _PagePhotosJsonState extends State<PagePhotosJson> {
  late Future<List<ModelPhotos>> futurePhotos;

  @override
  void initState() {
    super.initState();
    futurePhotos = ApiService.fetchDataPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Photos Json (Random Picsum)"),
        backgroundColor: Colors.redAccent,
      ),
      body: FutureBuilder<List<ModelPhotos>>(
        future: futurePhotos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Terjadi Kesalahan Load Data"));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Data Kosong"));
          }

          final photos = snapshot.data!;

          return GridView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: photos.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 3 / 4,
            ),
            itemBuilder: (context, index) {
              final photo = photos[index];

              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(10),
                        ),
                        child: Image.network(
                          photo.thumbnailUrl,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          // Loading indicator per gambar
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                          // Error handling jika Picsum gagal
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[200],
                              child: const Icon(Icons.broken_image, color: Colors.grey),
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        photo.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),


                    //TASK :
                    //1. Buat Page baru untuk detail, ketika item gambar di klik ke detail
                    //Bisa searching data

                    // Task 2 :
                    // Buat page baru untuk list data users pakai link ini https://jsonplaceholder.typicode.com/users
                    // bisa search data
                    // bisa detail data
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}