class Category {
  final String emoji, name;

  Category({required this.emoji, required this.name});
}

List<Category> categories = [
  Category(emoji: "assets/smiling-face.png", name: 'Romance'),
  Category(emoji: "assets/grinning-face.png", name: 'Comedy'),
  Category(emoji: "assets/horror.png", name: 'Horror'),
  Category(emoji: "assets/face.png", name: "Drama"),
];
