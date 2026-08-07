class Offer {
  final String title;
  final String description;
  final String newPrice;
  final String oldPrice;
  final String imagePath;
  final String category;

  Offer({
    required this.title,
    required this.description,
    required this.newPrice,
    this.oldPrice = '',
    required this.imagePath,
    required this.category,
  });
}