class Book {
  final int id;
  final String bookTitle;
  final String bookGenre;
  final String coverType;

  Book(
      {required this.id,
      required this.bookTitle,
      required this.bookGenre,
      required this.coverType});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      bookTitle: json['book_title'],
      bookGenre: json['book_genre'],
      coverType: json['cover_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'book_title': bookTitle,
      'book_genre': bookGenre,
      'cover_type': coverType,
    };
  }
}
