import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../cubit/keranjang_cubit.dart';
import '../models/produk.dart';
import '../providers/favorit_provider.dart';
import 'keranjang_page.dart';

/// Katalog produk.
/// - Hati merah = favorit, hati putih = bukan favorit (Provider).
/// - Jumlah pesanan baru tampil kalau sudah > 0 (Cubit).
class KatalogPage extends StatelessWidget {
  const KatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Rebuild saat favorit berubah.
    final favorit = context.watch<FavoritProvider>();

    // Rebuild saat jumlah pesanan berubah.
    return BlocBuilder<KeranjangCubit, List<ItemKeranjang>>(
      builder: (context, keranjang) {
        final cubit = context.read<KeranjangCubit>();

        return Scaffold(
          appBar: AppBar(
            title: const Text('Katalog Produk'),
            actions: [
              IconButton(
                tooltip: 'Lihat Keranjang',
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const KeranjangPage()),
                ),
                icon: Badge(
                  label: Text('${cubit.totalBarang}'),
                  isLabelVisible: cubit.totalBarang > 0,
                  child: const Icon(Icons.shopping_cart),
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: daftarProduk.length,
                  itemBuilder: (context, index) {
                    final produk = daftarProduk[index];
                    // Cari jumlah pesanan produk ini di keranjang (0 jika belum ada).
                    final posisi = keranjang.indexWhere(
                      (item) => item.produk.nama == produk.nama,
                    );
                    final qty = posisi == -1 ? 0 : keranjang[posisi].jumlah;
                    final sukaFavorit = favorit.isFavorit(index);

                    return Card(
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    produk.nama,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                // Hati: merah = favorit, putih = tidak.
                                IconButton(
                                  tooltip: sukaFavorit
                                      ? 'Hapus dari favorit'
                                      : 'Tambah ke favorit',
                                  style: IconButton.styleFrom(
                                    backgroundColor: Colors.grey.shade400,
                                  ),
                                  onPressed: () => context
                                      .read<FavoritProvider>()
                                      .toggleFavorit(index),
                                  icon: Icon(
                                    Icons.favorite,
                                    color:
                                        sukaFavorit ? Colors.red : Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(formatRupiah(produk.harga)),
                                const Spacer(),
                                // Tombol (-): nonaktif jika belum ada pesanan.
                                IconButton(
                                  onPressed: qty > 0
                                      ? () => cubit.kurangiBarang(produk)
                                      : null,
                                  icon: const Icon(Icons.remove_circle_outline),
                                ),
                                // Angka hanya muncul jika sudah dipesan.
                                if (qty > 0)
                                  Text(
                                    '$qty',
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                IconButton(
                                  onPressed: () => cubit.tambahBarang(produk),
                                  icon: const Icon(Icons.add_circle_outline),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Kembali'),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}