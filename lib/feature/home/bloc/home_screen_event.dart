part of 'home_screen_bloc.dart';

abstract class HomeScreenEvent  extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchProductsEvent extends HomeScreenEvent {
  final int offset;
  final int limit;

  FetchProductsEvent({required this.offset, required this.limit});

  @override 
  List<Object?> get props => [offset, limit];
}