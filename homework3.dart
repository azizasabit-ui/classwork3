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
