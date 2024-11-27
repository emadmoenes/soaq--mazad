abstract class ProductEvent {}

class FetchProducts extends ProductEvent {
  final int startIndex;
  final int limit;

  FetchProducts({required this.startIndex, required this.limit});
}
