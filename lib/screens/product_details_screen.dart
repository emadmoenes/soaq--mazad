// import 'package:flutter/material.dart';

// class ProductDetailsScreen extends StatelessWidget {
//   final Map<String, dynamic> product;

//   const ProductDetailsScreen({Key? key, required this.product})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           product["name"],
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: Color.fromARGB(255, 69, 5, 1),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Image.network(
//                 product["thumbnail"],
//                 height: 200,
//                 fit: BoxFit.cover,
//                 width: double.infinity,
//               ),
//               SizedBox(height: 20),
//               Text(
//                 product["name"],
//                 style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Color.fromARGB(255, 69, 5, 1)),
//               ),
//               SizedBox(height: 10),
//               Text(
//                 "\$${product["price"]}",
//                 style: TextStyle(fontSize: 20, color: Colors.black54),
//               ),
//               SizedBox(height: 20),
//               Text(
//                 "This is a detailed description of ${product["name"]}.",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 16),
//               ),
//               SizedBox(height: 200),
//               ElevatedButton(
//                 onPressed: () {},
//                 style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color.fromARGB(255, 69, 5, 1),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                     )),
//                 child: Text("Buy Now", style: TextStyle(color: Colors.white)),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductDetailsScreen({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Safely access the product fields and provide fallback values in case they are null
    String name = product["name"] ?? "No Name";
    String description = product["description"] ?? "No Description Available";
    String imageUrl = product["image"] ?? ""; // Placeholder image if null
    double price =
        product["price"]?.toDouble() ?? 0.0; // Handle price as double

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
              // Product Image
              imageUrl.isNotEmpty
                  ? Image.network(
                      imageUrl, // Use image URL or placeholder
                      height: 200,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    )
                  : Container(
                      height: 200,
                      color: Colors.grey[
                          300], // Placeholder container if image URL is empty
                    ),
              SizedBox(height: 20),
              // Product Name
              Text(
                name,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 69, 5, 1)),
              ),
              SizedBox(height: 10),
              // Product Price
              Text(
                price > 0
                    ? "\$${price.toStringAsFixed(2)}"
                    : "Price not available",
                style: TextStyle(fontSize: 20, color: Colors.black54),
              ),
              SizedBox(height: 20),
              // Product Description
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 200),
              // Buy Now Button
              ElevatedButton(
                onPressed: () {
                  // Add the logic for the "Buy Now" button
                },
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
