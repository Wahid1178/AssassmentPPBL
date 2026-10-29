import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/produk.dart';
import '../providers/favorit_provider.dart';

/// Latihan 4 — Menampilkan jumlah & daftar produk favorit dengan Consumer.
/// Favorit ditandai lewat ikon hati di halaman Katalog.
class FavoritPage extends StatelessWidget {
  const FavoritPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorit (Provider)')),
      body: Consumer<FavoritProvider>(
        builder: (context, favorit, child) {
          return Column(
            children: [
              const SizedBox(height: 24),
              const Text('Jumlah Produk Favorit',
                  style: TextStyle(fontSize: 18)),
              Text(
                '${favorit.jumlahFavorit}',
                style:
                    const TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: favorit.jumlahFavorit == 0
                    ? const Center(
                        child: Text(
                          'Belum ada favorit.\nTekan ikon hati di Katalog.',
                          textAlign: TextAlign.center,
                        ),
                      )
                    : ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        children: [
                          for (final index in favorit.daftarFavorit)
                            Card(
                              child: ListTile(
                                leading: const Icon(Icons.favorite,
                                    color: Colors.red),
                                title: Text(daftarProduk[index].nama),
                                subtitle: Text(
                                    formatRupiah(daftarProduk[index].harga)),
                              ),
                            ),
                        ],
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextButton(
                  onPressed: favorit.jumlahFavorit == 0
                      ? null
                      : () => context.read<FavoritProvider>().resetFavorit(),
                  child: const Text('Reset Favorit'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}