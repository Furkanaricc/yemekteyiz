import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemekteyiz/ui/cubit/anasayfa_cubit.dart';
import 'package:yemekteyiz/ui/cubit/detay_sayfa_cubit.dart';
import 'package:yemekteyiz/ui/cubit/favori_sayfa_cubit.dart';
import 'package:yemekteyiz/ui/cubit/sepet_sayfa_cubit.dart';
import 'package:yemekteyiz/ui/utils/bottom_nav_bar.dart';
import 'package:yemekteyiz/ui/views/anasayfa.dart';


void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>AnasayfaCubit()),
        BlocProvider(create: (context)=>SepetSayfaCubit()),
        BlocProvider(create: (context)=>DetaySayfaCubit()),
        BlocProvider(create: (context)=>FavoriSayfaCubit()),

      ],
      child:MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent),
          useMaterial3: true,
      ),
      home: const RootPage(),
    ),
    );
  }
}


