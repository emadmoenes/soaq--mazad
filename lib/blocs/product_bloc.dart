import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/product_repository.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  ProductBloc({required this.productRepository}) : super(ProductInitial()) {
    on<FetchProducts>(_onFetchProducts);
  }

  Future<void> _onFetchProducts(
      FetchProducts event, Emitter<ProductState> emit) async {
    if (state is ProductLoaded && (state as ProductLoaded).hasReachedMax)
      return;

    try {
      if (state is ProductInitial || state is ProductLoading) {
        final products = await productRepository.fetchProducts(
          startIndex: event.startIndex,
          limit: event.limit,
        );
        emit(ProductLoaded(
            products: products, hasReachedMax: products.length < event.limit));
      } else if (state is ProductLoaded) {
        final currentState = state as ProductLoaded;
        final products = await productRepository.fetchProducts(
          startIndex: event.startIndex,
          limit: event.limit,
        );
        emit(ProductLoaded(
          products: currentState.products + products,
          hasReachedMax: products.isEmpty,
        ));
      }
    } catch (e) {
      emit(ProductError(error: e.toString()));
    }
  }
}
