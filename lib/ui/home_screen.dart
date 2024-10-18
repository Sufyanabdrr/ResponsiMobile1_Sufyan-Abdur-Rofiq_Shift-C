import 'package:flutter/material.dart';
import 'package:manajemenbuku/ui/add_edit_book_screen.dart';
import 'package:manajemenbuku/ui/book_detail_screen.dart';
import 'package:manajemenbuku/models/user_model.dart';
import 'package:manajemenbuku/helpers/api_helper.dart';
import 'package:manajemenbuku/models/book_model.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  HomeScreen({required this.user});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiHelper apiHelper = ApiHelper();
  late Future<List<Book>> futureBooks;

  @override
  void initState() {
    super.initState();
    futureBooks = apiHelper.getBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Daftar Buku')),
      body: FutureBuilder<List<Book>>(
        future: futureBooks,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Gagal mengambil data buku'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Tidak ada buku'));
          }

          final books = snapshot.data!;
          return ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];
              return ListTile(
                title: Text(book.bookTitle),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BookDetailScreen(book: book)),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddEditBookScreen()),
          ).then((_) {
            setState(() {
              futureBooks = apiHelper.getBooks(); // Refresh data
            });
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
