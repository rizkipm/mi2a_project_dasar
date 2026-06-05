import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {

  //Fungsi untuk menyimpan data setelah berhasil login
  static Future<void> saveUserSession(Map<String, dynamic> userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_success', true);
    await prefs.setString('username', userData['username']);
    await prefs.setString('email', userData['email']);
    await prefs.setString('id', userData['id']);
    await prefs.setString("tgl_daftar", userData['tgl_daftar']);
  }

  //fungsi untuk mengambil data user yang sedang login
  static Future<Map<String, String?>> getUserSession() async {
    final SharedPreferences  prefs = await SharedPreferences.getInstance();
    return{
      'is_success': prefs.getBool('is_success')?.toString(),
      'username': prefs.getString('username'),
      'email': prefs.getString('email'),
      'id': prefs.getString('id'),
      'tgl_daftar': prefs.getString('tgl_daftar'),
    };
  }

  //fungsi untuk mengecek apakah user sudah login atau belum
  static Future<bool> isLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('is_success') ?? false;
  }

  //fungsi untuk menghapus session saat logut
  static Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('is_success');
    await prefs.clear();
  }

}