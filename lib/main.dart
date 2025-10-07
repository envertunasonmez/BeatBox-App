import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:beatbox_app/bloc/music_cubit.dart';
import 'package:beatbox_app/screens/main_screen.dart';

void main() {
  runApp(const BeatBoxApp());
}

class BeatBoxApp extends StatelessWidget {
  const BeatBoxApp({super.key});

  @override
  Widget build(final BuildContext context) {
    return BlocProvider(
      create: (_) => MusicCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BeatBox',
        theme: ThemeData.dark().copyWith(
          primaryColor: Colors.greenAccent,
          scaffoldBackgroundColor: const Color(0xFF121212),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF121212),
            elevation: 0,
          ),
        ),
        home: const MainScreen(),
      ),
    );
  }
}
