import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:astro_tak/data/models/models.dart';
import 'package:astro_tak/data/repositories/ask_question/category.dart';

part 'astro_event.dart';
part 'astro_state.dart';

class AstroBloc extends Bloc<AstroEvent, AstroState> {
  final CategoryAPI categoryAPI;

  AstroBloc(
    this.categoryAPI,
  ) : super(AstroInitial()) {
    on<AstroEvent>((event, emit) async {
      if (event is GetAskQuestionCategory) {
        try{
          emit(AskQueCategoriesLoadinng());
          final categories = await categoryAPI. getCategories();
          emit(AskQueCategoriesLoaded(categories: categories));
        }catch(e){
          //todo: check error message
          emit(AskQueCategoriesError(error: e.toString()));
        }
      }
    });
  }
}
