import 'package:astro_tak/data/repositories/ask_question/category.dart';
import 'package:astro_tak/presentation/bloc/astro/astro_bloc.dart';
import 'package:astro_tak/presentation/bloc/auth/auth_cubit.dart';
import 'package:astro_tak/presentation/bloc/user/user_bloc.dart';
import 'package:astro_tak/presentation/screens/main_tab_bar.dart';
import 'package:astro_tak/presentation/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MultiBlocProvider(
      providers: [
        BlocProvider<AstroBloc>(
          create: (BuildContext context) => AstroBloc(CategoryAPI()),
        ),
        BlocProvider<AuthCubit>(create: (BuildContext context) => AuthCubit()),
        BlocProvider<UserBloc>(
          create: (BuildContext context) => UserBloc(
            BlocProvider.of<AuthCubit>(context),
          ),
        ),
      ],
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Astro Tak',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              titleTextStyle: TextStyle(color: Colors.black87),
              elevation: 0,
              iconTheme: const IconThemeData(color: AppTheme.secondaryColor)),
          iconTheme: const IconThemeData(color: AppTheme.secondaryColor),
          primaryIconTheme: const IconThemeData(color: Colors.white),
          textTheme: GoogleFonts.montserratTextTheme(const TextTheme(
            headline6: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Colors.black87),
          )),
          primaryColor: AppTheme.secondaryColor,
          colorScheme: const ColorScheme.light(secondary: Color(0xffff944d)),
          indicatorColor: AppTheme.secondaryColor,
        ),
        home: const MainTabBar());
  }
}
