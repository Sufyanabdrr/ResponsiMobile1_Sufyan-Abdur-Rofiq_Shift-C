import 'package:flutter/material.dart';
import 'package:manajemenbuku/helpers/api_helper.dart';
import 'package:manajemenbuku/models/book_model.dart';
import 'package:manajemenbuku/ui/book_detail_screen.dart';
import 'package:manajemenbuku/ui/add_edit_book_screen.dart';

class BookListScreen extends StatefulWidget {
  @override
  _BookListScreenState createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  List<Book> books = [];
  final ApiHelper apiHelper = ApiHelper();

  @override
  void initState() {
    super.initState();
    _fetchBooks();
  }

  void _fetchBooks() async {
    books = await apiHelper.getBooks();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Daftar Buku')),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(books[index].bookTitle),
            subtitle: Text(books[index].bookGenre),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BookDetailScreen(book: books[index])),
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
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
