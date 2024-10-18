import 'package:flutter/material.dart';
import 'package:manajemenbuku/helpers/api_helper.dart';
import 'package:manajemenbuku/models/book_model.dart';

class AddEditBookScreen extends StatefulWidget {
  final Book? book;

  AddEditBookScreen({this.book});

  @override
  _AddEditBookScreenState createState() => _AddEditBookScreenState();
}

class _AddEditBookScreenState extends State<AddEditBookScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController genreController = TextEditingController();
  final TextEditingController coverTypeController = TextEditingController();
  final ApiHelper apiHelper = ApiHelper();

  @override
  void initState() {
    super.initState();
    if (widget.book != null) {
      titleController.text = widget.book!.bookTitle;
      genreController.text = widget.book!.bookGenre;
      coverTypeController.text = widget.book!.coverType;
    }
  }

  void _saveBook() async {
    try {
      if (widget.book == null) {
        // Add new book
        Book newBook = Book(
          id: 0, // Dummy ID
          bookTitle: titleController.text,
          bookGenre: genreController.text,
          coverType: coverTypeController.text,
        );
        await apiHelper.addBook(newBook);
      } else {
        // Update existing book
        Book updatedBook = Book(
          id: widget.book!.id,
          bookTitle: titleController.text,
          bookGenre: genreController.text,
          coverType: coverTypeController.text,
        );
        await apiHelper.updateBook(updatedBook);
      }
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Gagal menyimpan buku')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.book == null ? 'Tambah Buku' : 'Ubah Buku')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Judul Buku'),
            ),
            TextField(
              controller: genreController,
              decoration: InputDecoration(labelText: 'Genre Buku'),
            ),
            TextField(
              controller: coverTypeController,
              decoration: InputDecoration(labelText: 'Tipe Sampul'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveBook,
              child: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
