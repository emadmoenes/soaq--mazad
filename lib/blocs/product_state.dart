import '../models/product_model.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;
  final bool hasReachedMax;

  ProductLoaded({required this.products, required this.hasReachedMax});
}

class ProductError extends ProductState {
  final String error;

  ProductError({required this.error});
}
