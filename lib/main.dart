import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'repositories/product_repository.dart';
import 'blocs/product_bloc.dart';
import 'screens/product_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Product App',
      home: BlocProvider(
        create: (_) => ProductBloc(
          productRepository: ProductRepository(
              baseUrl:
                  'https://souq-mazad-task.vercel.app/e-commerce/app/products'),
        ),
        child: ProductListScreen(),
      ),
    );
  }
}
