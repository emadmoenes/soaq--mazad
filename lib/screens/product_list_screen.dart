// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:http/http.dart' as http;
// import 'package:souq_mazad/screens/product_details_screen.dart';

// class ProductListScreen extends StatefulWidget {
//   @override
//   _ProductListScreenState createState() => _ProductListScreenState();
// }

// class _ProductListScreenState extends State<ProductListScreen> {
//   final List<Map<String, dynamic>> products = [];
//   int startIndex = 0;
//   final int limit = 10;
//   bool isLoading = false;
//   bool hasMore = true;

//   final String baseUrl =
//       'https://souq-mazad-task.vercel.app/e-commerce/app/products';

//   @override
//   void initState() {
//     super.initState();
//     _fetchProducts();
//   }

//   Future<void> _fetchProducts() async {
//     if (isLoading || !hasMore) return;

//     setState(() {
//       isLoading = true;
//     });

//     try {
//       final response = await http
//           .get(Uri.parse('$baseUrl?_start=$startIndex&_limit=$limit'));

//       if (response.statusCode == 200) {
//         final List<dynamic> data = json.decode(response.body);

//         setState(() {
//           if (data.isNotEmpty) {
//             // Add the new products to the list
//             products.addAll(data
//                 .map((product) => product as Map<String, dynamic>)
//                 .toList());
//             startIndex += data.length;

//             if (data.length < limit) {
//               hasMore = false;
//             }
//           } else {
//             hasMore = false;
//           }
//         });
//       } else {
//         throw Exception('Failed to load products');
//       }
//     } catch (e) {
//       print('Error: $e');
//     } finally {
//       Future.delayed(Duration(seconds: 2), () {
//         setState(() {
//           isLoading = false;
//         });
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Product List", style: TextStyle(color: Colors.white)),
//         backgroundColor: Color.fromARGB(255, 69, 5, 1),
//       ),
//       body: NotificationListener<ScrollNotification>(
//         onNotification: (scrollNotification) {
//           if (scrollNotification.metrics.pixels ==
//                   scrollNotification.metrics.maxScrollExtent &&
//               !isLoading) {
//             _fetchProducts();
//           }
//           return false;
//         },
//         child: AnimationLimiter(
//           child: Column(
//             children: [
//               Expanded(
//                 child: GridView.builder(
//                   padding: const EdgeInsets.all(10.0),
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 10.0,
//                     mainAxisSpacing: 10.0,
//                     childAspectRatio: 0.8,
//                   ),
//                   itemCount: products.length + (isLoading ? 1 : 0),
//                   itemBuilder: (context, index) {
//                     if (index == products.length) {
//                       return const Center(
//                           child: CircularProgressIndicator(
//                         color: Color.fromARGB(255, 69, 5, 1),
//                       ));
//                     }

//                     final product = products[index];
//                     return AnimationConfiguration.staggeredGrid(
//                       position: index,
//                       duration: const Duration(milliseconds: 1000),
//                       columnCount: 2,
//                       child: ScaleAnimation(
//                         child: FadeInAnimation(
//                           child: ProductCard(
//                             product: product,
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) =>
//                                       ProductDetailsScreen(product: product),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               if (isLoading)
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 10),
//                   child: Center(
//                     child: CircularProgressIndicator(
//                       color: Color.fromARGB(255, 69, 5, 1),
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ProductCard extends StatefulWidget {
//   final Map<String, dynamic> product;
//   final VoidCallback onTap;

//   const ProductCard({Key? key, required this.product, required this.onTap})
//       : super(key: key);

//   @override
//   _ProductCardState createState() => _ProductCardState();
// }

// class _ProductCardState extends State<ProductCard> {
//   bool isFavorite = false;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: widget.onTap,
//       child: Card(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15.0),
//         ),
//         color: Colors.white,
//         elevation: 5,
//         child: Column(
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
//               child: Image.network(
//                 widget.product["thumbnail"],
//                 height: 100,
//                 width: double.infinity,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 children: [
//                   Text(
//                     widget.product["name"],
//                     style: TextStyle(
//                       fontSize: 16.0,
//                       fontWeight: FontWeight.bold,
//                       color: Color.fromARGB(255, 69, 5, 1),
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: 5.0),
//                   Text(
//                     "\$${widget.product["price"]}",
//                     style: TextStyle(
//                       fontSize: 14.0,
//                       color: Colors.black54,
//                     ),
//                   ),
//                   SizedBox(height: 10.0),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       ElevatedButton(
//                         onPressed: () {},
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Color.fromARGB(255, 69, 5, 1),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                         ),
//                         child: Text(
//                           "Buy Now",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                       IconButton(
//                         onPressed: () {
//                           setState(() {
//                             isFavorite = !isFavorite;
//                           });
//                         },
//                         icon: Icon(
//                           isFavorite ? Icons.favorite : Icons.favorite_border,
//                           color: isFavorite ? Colors.red : Colors.grey,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:http/http.dart' as http;
import 'package:souq_mazad/screens/product_details_screen.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final List<Map<String, dynamic>> products = [];
  int startIndex = 0;
  final int limit = 10;
  bool isLoading = false;
  bool hasMore = true;

  final String baseUrl =
      'https://souq-mazad-task.vercel.app/e-commerce/app/products';

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    if (isLoading || !hasMore) return;

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http
          .get(Uri.parse('$baseUrl?_start=$startIndex&_limit=$limit'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)["data"];

        setState(() {
          if (data.isNotEmpty) {
            // Add the new products to the list
            products.addAll(data
                .map((product) => product as Map<String, dynamic>)
                .toList());
            startIndex += data.length;

            if (data.length < limit) {
              hasMore = false;
            }
          } else {
            hasMore = false;
          }
        });
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product List", style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 69, 5, 1),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification.metrics.pixels ==
                  scrollNotification.metrics.maxScrollExtent &&
              !isLoading) {
            _fetchProducts();
          }
          return false;
        },
        child: AnimationLimiter(
          child: Column(
            children: [
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(10.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: products.length + (isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == products.length) {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 69, 5, 1),
                      ));
                    }

                    final product = products[index];
                    return AnimationConfiguration.staggeredGrid(
                      position: index,
                      duration: const Duration(milliseconds: 1000),
                      columnCount: 2,
                      child: ScaleAnimation(
                        child: FadeInAnimation(
                          child: ProductCard(
                            product: product,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProductDetailsScreen(product: product),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              if (isLoading)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 69, 5, 1),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductCard extends StatefulWidget {
  final Map<String, dynamic> product;
  final VoidCallback onTap;

  const ProductCard({Key? key, required this.product, required this.onTap})
      : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.white,
        elevation: 5,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
              child: Image.network(
                widget.product["image"],
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    widget.product["name"],
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 69, 5, 1),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "\$${widget.product["price"]}",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 69, 5, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Text(
                          "Buy Now",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
