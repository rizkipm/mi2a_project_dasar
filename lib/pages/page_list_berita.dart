import 'package:flutter/material.dart';
import 'package:mi2a_project_dasar/models/model_berita.dart';
import 'package:mi2a_project_dasar/pages/page_login.dart';
import 'package:mi2a_project_dasar/services/api_service.dart';

import '../helper/session_manager.dart';

class PageListBerita extends StatefulWidget {
  const PageListBerita({super.key});

  @override
  State<PageListBerita> createState() => _PageListBeritaState();
}

class _PageListBeritaState extends State<PageListBerita> {

  late Future<List<Datum>> futureBerita;

  List<Datum> _allBerita = [];
  List<Datum> _filteredBerita = [];

  final TextEditingController _searchCtrl = TextEditingController();

  //variable penampung data login dari shared preferences
  String? username;
  String? email;
  String? id;
  String? tglDaftar;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureBerita = ApiService.getDataBerita();
    _loadUserData();
  }

  void _loadUserData() async {
    final userData = await SessionManager.getUserSession();
    setState(() {
      username = userData['username'];
      email = userData['email'];
      id = userData['id'];
      tglDaftar = userData['tgl_daftar'];
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchCtrl.dispose();
  }

  void _onSearchBar(String query){
    setState(() {
      if(query.isEmpty){
        _filteredBerita = List.from(_allBerita);
      } else {
        _filteredBerita = _allBerita.where((berita) {
          return berita.judulBerita.toLowerCase().contains(query.toLowerCase()) || berita.isiBerita.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //tampilkan usert anem jika berhasil login
        title: Text(username != null ? "Selamat Datang $username" : "List Berita"),
        backgroundColor: Colors.lightBlue,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              setState(() {
                //logout
                SessionManager.logout();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => PageLogin()),
                );
              });
            },
          ),
        ],
      ),
      body: FutureBuilder(
          future: futureBerita,
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator(),);
            }
            if(snapshot.hasError){
              return Center(child: Text(snapshot.error.toString()));
            }
            if(_allBerita.isEmpty){
              _allBerita = snapshot.data!;
              _filteredBerita = List.from(_allBerita);
            }

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextField(
                    controller: _searchCtrl,
                    onChanged: _onSearchBar,
                    decoration: InputDecoration(
                      hintText: "Cari berita...",
                      prefixIcon:
                      const Icon(Icons.search, color: Colors.green),
                      suffixIcon: _searchCtrl.text.isNotEmpty
                          ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchCtrl.clear();
                          _onSearchBar('');
                        },
                      )
                          : null,
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                        const BorderSide(color: Colors.green, width: 2),
                      ),
                    ),
                  ),
                ),

                if(_searchCtrl.text.isNotEmpty)
                  Padding(padding: EdgeInsets.only(left: 16, bottom: 8),
                    child: Text("${_filteredBerita.length} berita ditemukan"),
                  ),
                Expanded(
                  child: _filteredBerita.isEmpty
                      ? const Center(child: Text("Berita tidak ditemukan"))
                      : RefreshIndicator(
                    color: Colors.green,
                    onRefresh: () async {
                      setState(() {
                        _allBerita.clear();
                        futureBerita = ApiService.getDataBerita();
                      });
                    },
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      itemCount: _filteredBerita.length,
                      itemBuilder: (context, index) {
                        return _buildBeritaCard(
                            _filteredBerita[index]);
                      },
                    ),
                  ),
                ),

              ],
            );
          }),
    );
  }

  Widget _buildBeritaCard(Datum berita) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
      margin: EdgeInsetsDirectional.only(bottom: 12),
      child: InkWell(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => DetailBerita(berita: berita),
          //   ),
          // );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Image.network(

                "http://10.20.27.87/BERITA_API/berita_api/gambar/${berita.gbrBerita}",
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(padding: EdgeInsets.all(10),
              child: Text(berita.judulBerita, maxLines: 2,),
            )
          ],
        ),
      ),
    );
  }
}