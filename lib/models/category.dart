class Category {
  final String id;
  final String title;
  final String firebase_key;
  final String description;
  final String imageUrl;

  const Category(
      {required this.id,
      required this.description,
      required this.title,
      required this.firebase_key,
      required this.imageUrl});
}
