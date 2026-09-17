class Book {
  String title;
  String author;
  double price;
  bool isBorrowed;

  Book({
    required this.title,
    required this.author,
    required this.price,
    this.isBorrowed = false,
  });
}
class Library {
  final List<Book> _books = [];

  void addBook(Book book) {
    _books.add(book);
  }

  List<Book> getAvailableBooks() {
    return _books.where((book) => !book.isBorrowed).toList();
  }
  double getTotalValue() {
    return _books.fold(
      0.0,
      (total, book) => total + book.price,
    );
  }
}
void main() {
  final library = Library();

  library.addBook(
    Book(
      title: 'Harry Potter',
      author: 'J.K. Rowling',
      price: 5000.0,
    ),
  );

  library.addBook(
    Book(
      title: 'The Hobbit',
      author: 'J.R.R. Tolkien',
      price: 4500.0,
      isBorrowed: true,
    ),
  );

  library.addBook(
    Book(
      title: '1984',
      author: 'George Orwell',
      price: 3500.0,
    ),
  );

  library.addBook(
    Book(
      title: 'Clean Code',
      author: 'Robert C. Martin',
      price: 7000.0,
      isBorrowed: true,
    ),
  );
}