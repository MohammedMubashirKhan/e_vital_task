class User {
  final String name;
  final String phoneNumber;
  final String city;
  final String imageUrl;
  int stock;

  User({
    required this.name,
    required this.phoneNumber,
    required this.city,
    required this.imageUrl,
    required this.stock,
  });

  void updateStock(int newStock) {
    stock = newStock;
  }
}
