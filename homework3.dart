abstract class MediaItem {
  String id;
  String title;
  double price;

  MediaItem({
    required this.id,
    required this.title,
    required this.price,
  });

  String getDetails();

  void download(String title) {}
}


mixin Downloadable {
  void download(String title) {
    print('Downloading "$title"...');
  }
}


class Audiobook extends MediaItem with Downloadable {
  double durationHours;
  String narrator;

  Audiobook({
    required super.id,
    required super.title,
    required super.price,
    required this.durationHours,
    required this.narrator,
  });

  @override
  String getDetails() {
    return 'Audiobook: $title | '
        'Narrator: $narrator | '
        'Duration: $durationHours hours | '
        'Price: $price ₸';
  }
}


class EBook extends MediaItem with Downloadable {
  double fileSizeMB;
  String author;

  EBook({
    required super.id,
    required super.title,
    required super.price,
    required this.fileSizeMB,
    required this.author,
  });

  @override
  String getDetails() {
    return 'EBook: $title | '
        'Author: $author | '
        'File size: $fileSizeMB MB | '
        'Price: $price ₸';
  }
}


class ShoppingCart {
  final List<MediaItem> _items = [];

  void addItem(MediaItem item) {
    _items.add(item);
  }

  double calculateTotalWithTax({
    double taxRate = 0.12,
  }) {
    final double subtotal = _items.fold(
      0.0,
      (total, item) => total + item.price,
    );

    final double tax = subtotal * taxRate;

    return subtotal + tax;
  }

  List<MediaItem> filterByMaxPrice(double maxPrice) {
    return _items
        .where((item) => item.price <= maxPrice)
        .toList();
  }

  void printReceipt() {
    print('========== RECEIPT ==========');

    for (final item in _items) {
      print(item.getDetails());

      if (item is Downloadable) {
        item.download(item.title);
      }

      print('');
    }

    final double subtotal = _items.fold(
      0.0,
      (total, item) => total + item.price,
    );

    final double tax = subtotal * 0.12;
    final double total = calculateTotalWithTax();

    print('Subtotal: $subtotal ₸');
    print('Tax (12%): $tax ₸');
    print('Total: $total ₸');

    print('=============================');
  }
}


void main() {

  final audiobook = Audiobook(
    id: 'A001',
    title: 'Atomic Habits',
    price: 6000.0,
    durationHours: 5.5,
    narrator: 'James Clear',
  );

  final audiobook2 = Audiobook(
    id: 'A002',
    title: 'The Alchemist',
    price: 4500.0,
    durationHours: 4.2,
    narrator: 'John Smith',
  );

  final ebook = EBook(
    id: 'E001',
    title: 'Clean Code',
    price: 7000.0,
    fileSizeMB: 8.5,
    author: 'Robert C. Martin',
  );

  final ebook2 = EBook(
    id: 'E002',
    title: '1984',
    price: 3000.0,
    fileSizeMB: 2.8,
    author: 'George Orwell',
  );


  final cart = ShoppingCart();


  cart.addItem(audiobook);
  cart.addItem(audiobook2);
  cart.addItem(ebook);
  cart.addItem(ebook2);



  cart.printReceipt();



  print('');
  print('=== Items up to 5000 ₸ ===');

  final affordableItems = cart.filterByMaxPrice(5000.0);

  for (final item in affordableItems) {
    print(item.getDetails());
  }



  print('');
  print(
    'Total with tax: '
    '${cart.calculateTotalWithTax().toStringAsFixed(2)} ₸',
  );
}