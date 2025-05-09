part of 'category_screen_bloc.dart';

abstract class CategoryScreenEvent  extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchCategoryProductsEvent extends CategoryScreenEvent {
  final int offset;
  final int limit;
  final int categoryId;

  FetchCategoryProductsEvent({required this.offset, required this.limit, required this.categoryId});

  @override 
  List<Object?> get props => [offset, limit, categoryId];
}