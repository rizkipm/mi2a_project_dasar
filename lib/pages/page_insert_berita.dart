import 'dart:io';
import 'dart:convert'; // Untuk mendecode response JSON
import 'package:flutter/foundation.dart'; // WAJIB UNTUK kIsWeb
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:mi2a_project_dasar/pages/page_list_berita.dart'; // Import package HTTP

class PageInsertBerita extends StatefulWidget {
  const PageInsertBerita({super.key});

  @override
  State<PageInsertBerita> createState() => _PageInsertBeritaState();
}

class _PageInsertBeritaState extends State<PageInsertBerita> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController judulController = TextEditingController();
  TextEditingController isiController = TextEditingController();

  // Solusi Multiplatform:
  File? _fileGambarMobile; // Dipakai khusus Mobile (Android/iOS)
  Uint8List? _bytesGambarWeb; // Dipakai khusus Flutter Web
  String? _namaFileGambar;

  final _imgPicker = ImagePicker();
  bool _isLoading = false;

  // Fungsi mengambil gambar ImagePicker
  Future<void> _getImage(ImageSource source) async {
    try {
      final XFile? ambilGambar = await _imgPicker.pickImage(source: source);
      if (ambilGambar != null) {
        // Ambil bytes gambar (Berlaku untuk Web & Mobile)
        final Uint8List bytes = await ambilGambar.readAsBytes();

        setState(() {
          _bytesGambarWeb = bytes;
          _namaFileGambar = ambilGambar.name;

          // Jika BUKAN web, kita isi juga variabel File-nya biar aman
          if (!kIsWeb) {
            _fileGambarMobile = File(ambilGambar.path);
          }
        });
      }
      if (mounted) Navigator.pop(context); // Tutup dialog
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal mengambil gambar: $e")),
      );
    }
  }

  // Fungsi untuk pilihan gambar
  void _pilihGambar(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Pilih Gambar"),
          content: const Text("Pilih Sumber Gambar"),
          actions: [
            ElevatedButton(
              onPressed: () => _getImage(ImageSource.gallery),
              child: const Text("Galeri"),
            ),
            if (!kIsWeb) // Kamera disembunyikan di web jika tidak kompatibel
              ElevatedButton(
                onPressed: () => _getImage(ImageSource.camera),
                child: const Text("Camera"),
              ),
          ],
        );
      },
    );
  }

  // ================= FUNGSI SIMPAN DATA KE API =================
  Future<void> _simpanBerita() async {
    if (!_formKey.currentState!.validate()) return;

    // Validasi apakah gambar sudah dipilih (baik di web maupun mobile)
    if (kIsWeb && _bytesGambarWeb == null) {
      _showSnackBar("Silahkan pilih gambar terlebih dahulu!");
      return;
    } else if (!kIsWeb && _fileGambarMobile == null) {
      _showSnackBar("Silahkan pilih gambar terlebih dahulu!");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Ganti URL sesuai environment run Anda
      var url = Uri.parse("http://10.11.17.54/berita_api/insert_berita.php");
      var request = http.MultipartRequest("POST", url);

      // Menambahkan data teks
      request.fields['judul'] = judulController.text;
      request.fields['isi'] = isiController.text;

      // Menambahkan data file gambar secara dinamis berdasarkan Platform
      if (kIsWeb) {
        // Jika di WEB, kirim via Bytes langsung dari memori browser
        request.files.add(http.MultipartFile.fromBytes(
          'gambar',
          _bytesGambarWeb!,
          filename: _namaFileGambar ?? 'gambar.jpg',
        ));
      } else {
        // Jika di MOBILE, kirim via Stream File lokal device
        var streamGambar = http.ByteStream(_fileGambarMobile!.openRead());
        var lengthGambar = await _fileGambarMobile!.length();
        request.files.add(http.MultipartFile(
          'gambar',
          streamGambar,
          lengthGambar,
          filename: _fileGambarMobile!.path.split('/').last,
        ));
      }

      // Mengirim data ke server
      var response = await request.send();
      var responseData = await http.Response.fromStream(response);
      var data = jsonDecode(responseData.body);

      if (data['status'] == true) {
        _showSnackBar(data['message']);
        // Reset Form
        judulController.clear();
        isiController.clear();
        setState(() {
          _fileGambarMobile = null;
          _bytesGambarWeb = null;
          _namaFileGambar = null;
        });

        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const PageListBerita()),
          );
        }

      } else {
        _showSnackBar("Gagal: ${data['message']}");
      }
    } catch (e) {
      _showSnackBar("Terjadi Kesalahan: $e");
    } finally {
    setState(() {
    _isLoading = false;
  });
  }
  }

  void _showSnackBar(String pesan) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(pesan)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Insert Berita"),
        backgroundColor: Colors.lightBlue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: judulController,
                  decoration: const InputDecoration(labelText: "Judul Berita"),
                  validator: (value) => value!.isEmpty ? "Judul tidak boleh kosong" : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: isiController,
                  maxLines: 3,
                  decoration: const InputDecoration(labelText: "Isi Berita"),
                  validator: (value) => value!.isEmpty ? "Isi tidak boleh kosong" : null,
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () => _pilihGambar(context),
                  child: const Text("Pilih Gambar"),
                ),
                const SizedBox(height: 10),

                // PENG KONDISIAN DISPLAY WIDGET YANG AMAN UNTUK WEB DAN MOBILE
                _buildPreviewGambar(),

                const SizedBox(height: 30),

                // Tombol Submit
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue),
                    onPressed: _isLoading ? null : _simpanBerita,
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Simpan Berita", style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget Helper untuk memisahkan logika tampilan gambar render
  Widget _buildPreviewGambar() {
    if (kIsWeb) {
      // Tampilan Khusus Web menggunakan Image.memory
      return _bytesGambarWeb != null
          ? Image.memory(
        _bytesGambarWeb!,
        width: double.infinity,
        height: 200,
        fit: BoxFit.cover,
      )
          : const Text("Gambar Belum di pilih");
    } else {
      // Tampilan Khusus Android/iOS menggunakan Image.file
      return _fileGambarMobile != null
          ? Image.file(
        _fileGambarMobile!,
        width: double.infinity,
        height: 200,
        fit: BoxFit.cover,
      )
          : const Text("Gambar Belum di pilih");
    }
  }
}