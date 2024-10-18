import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:manajemenbuku/models/book_model.dart';
import 'package:manajemenbuku/models/user_model.dart';

class ApiHelper {
  static const String baseUrl = 'http://103.196.155.42/api/buku/genre';

  Future<User?> register(String nama, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/registrasi'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'nama': nama, 'email': email, 'password': password}),
    );

    if (response.statusCode == 201) {
      return User(id: 0, email: email); // Dummy ID
    } else {
      throw Exception('Gagal registrasi');
    }
  }

  Future<User?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal login');
    }
  }

  Future<List<Book>> getBooks() async {
    final response = await http.get(Uri.parse('$baseUrl/buku/genre'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['data'];
      return data.map((book) => Book.fromJson(book)).toList();
    } else {
      throw Exception('Gagal mengambil data buku');
    }
  }

  Future<Book?> addBook(Book book) async {
    final response = await http.post(
      Uri.parse('$baseUrl/buku/genre'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(book.toJson()),
    );

    if (response.statusCode == 200) {
      return Book.fromJson(json.decode(response.body)['data']);
    } else {
      throw Exception('Gagal menambah buku');
    }
  }

  Future<Book?> updateBook(Book book) async {
    final response = await http.put(
      Uri.parse('$baseUrl/buku/genre/${book.id}/update'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(book.toJson()),
    );

    if (response.statusCode == 200) {
      return Book.fromJson(json.decode(response.body)['data']);
    } else {
      throw Exception('Gagal mengubah buku');
    }
  }

  Future<void> deleteBook(int id) async {
    final response =
        await http.delete(Uri.parse('$baseUrl/buku/genre/$id/delete'));

    if (response.statusCode != 200) {
      throw Exception('Gagal menghapus buku');
    }
  }
}
