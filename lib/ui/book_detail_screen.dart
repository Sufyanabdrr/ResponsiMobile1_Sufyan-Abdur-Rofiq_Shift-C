import 'package:flutter/material.dart';
import 'package:manajemenbuku/helpers/api_helper.dart';
import 'package:manajemenbuku/models/book_model.dart';
import 'package:manajemenbuku/ui/add_edit_book_screen.dart';

class BookDetailScreen extends StatelessWidget {
  final Book book;

  BookDetailScreen({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(book.bookTitle)),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Judul: ${book.bookTitle}', style: TextStyle(fontSize: 20)),
            Text('Genre: ${book.bookGenre}', style: TextStyle(fontSize: 20)),
            Text('Tipe Sampul: ${book.coverType}',
                style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddEditBookScreen(book: book)),
                );
              },
              child: Text('Ubah Buku'),
            ),
            ElevatedButton(
              onPressed: () async {
                final apiHelper = ApiHelper();
                await apiHelper.deleteBook(book.id);
                Navigator.pop(context);
              },
              child: Text('Hapus Buku'),
            ),
          ],
        ),
      ),
    );
  }
}
