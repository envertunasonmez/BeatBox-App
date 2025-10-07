import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/music_cubit.dart';
import 'screens/main_screen.dart';

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
        theme: ThemeData(primarySwatch: Colors.deepPurple, brightness: Brightness.light),
        darkTheme: ThemeData(primarySwatch: Colors.deepPurple, brightness: Brightness.dark),
        home: const MainScreen(),
      ),
    );
  }
}
