import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/keranjang_cubit.dart';
import '../models/produk.dart';

/// Keranjang: menampilkan produk yang sudah dipesan (jumlah > 0),
/// lengkap dengan harga, jumlah, subtotal, dan tombol kosongkan keranjang.
class KeranjangPage extends StatelessWidget {
  const KeranjangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Keranjang')),
      body: BlocBuilder<KeranjangCubit, List<ItemKeranjang>>(
        builder: (context, keranjang) {
          final cubit = context.read<KeranjangCubit>();

          if (keranjang.isEmpty) {
            return const Center(
              child: Text(
                'Keranjang masih kosong',
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: keranjang.length,
                  itemBuilder: (context, i) {
                    final item = keranjang[i];

                    return Card(
                      child: ListTile(
                        leading: const Icon(Icons.eco, color: Colors.green),
                        title: Text(item.produk.nama),
                        subtitle: Text(
                          '${formatRupiah(item.produk.harga)} x ${item.jumlah}',
                        ),
                        trailing: Text(
                          formatRupiah(item.subtotal),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total barang: ${cubit.totalBarang}'),
                        Text(
                          'Total: ${formatRupiah(cubit.totalHarga)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          cubit.kosongkanKeranjang();
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              const SnackBar(
                                content: Text('Keranjang dikosongkan'),
                              ),
                            );
                        },
                        icon: const Icon(Icons.delete_outline),
                        label: const Text('Kosongkan Keranjang'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}