part of 'astro_bloc.dart';

@immutable
abstract class AstroState extends Equatable {}

class AstroInitial extends AstroState {
  @override
  List<Object?> get props => [];
}

class AskQueCategoriesLoadinng extends AstroState {
  @override
  List<Object?> get props => [];
}

class AskQueCategoriesError extends AstroState {
  final String error;
  AskQueCategoriesError({required this.error});
  @override
  List<Object?> get props => [error];
}

class AskQueCategoriesLoaded extends AstroState {
  final Categories categories;
  AskQueCategoriesLoaded({required this.categories});
  @override
  List<Object?> get props => [categories];
}
