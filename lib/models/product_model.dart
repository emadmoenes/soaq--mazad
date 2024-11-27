class Product {
  final String id;
  final String name;
  final double price;
  final String thumbnail;
  final String image;
  final String description;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.thumbnail,
    required this.image,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      thumbnail: json['thumbnail'],
      image: json['image'],
      description: json['description'],
    );
  }
}
