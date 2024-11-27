import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductDetailsScreen({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String name = product["name"] ?? "No Name";
    String description = product["description"] ?? "No Description Available";
    String imageUrl = product["image"] ?? "";
    double price = product["price"]?.toDouble() ?? 0.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          name,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 69, 5, 1),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              imageUrl.isNotEmpty
                  ? Image.network(
                      imageUrl,
                      height: 200,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    )
                  : Container(
                      height: 200,
                      color: Colors.grey[300],
                    ),
              SizedBox(height: 20),
              Text(
                name,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 69, 5, 1)),
              ),
              SizedBox(height: 10),
              Text(
                price > 0
                    ? "\$${price.toStringAsFixed(2)}"
                    : "Price not available",
                style: TextStyle(fontSize: 20, color: Colors.black54),
              ),
              SizedBox(height: 20),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 200),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 69, 5, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    )),
                child: Text("Buy Now", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
