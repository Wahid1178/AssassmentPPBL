import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'cubit/keranjang_cubit.dart';
import 'pages/beranda_page.dart';
import 'providers/favorit_provider.dart';

void main() {
  runApp(const GreenShopApp());
}

class GreenShopApp extends StatelessWidget {
  const GreenShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Provider (Latihan 4) dan Cubit (Latihan 5) dipasang di level paling atas
    // supaya bisa diakses dari semua halaman.
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoritProvider()),
        BlocProvider(create: (_) => KeranjangCubit()),
      ],
      child: MaterialApp(
        title: 'GreenShop',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          useMaterial3: true,
        ),
        home: const BerandaPage(),
      ),
    );
  }
}