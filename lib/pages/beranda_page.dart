import 'package:flutter/material.dart';
import 'favorit_page.dart';
import 'form_pemesanan_page.dart';
import 'katalog_page.dart';
import 'keranjang_page.dart';
import 'lokasi_page.dart';

/// Latihan 1 — Halaman Beranda + navigasi dengan Navigator.push().
class BerandaPage extends StatelessWidget {
  const BerandaPage({super.key});

  void _buka(BuildContext context, Widget halaman) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => halaman));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ecomart-Produk Daur Ulang'), centerTitle: true),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.eco, size: 90, color: Colors.green),
              const SizedBox(height: 16),
              const Text(
                'Selamat Datang di Ecomart',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                'Ecomart adalah komunitas Bank Sampah Hijau di Kota Bandung '
                'untuk menghasilkan berbagai produk dari pengolahan sampah seperti '
                'Pupuk Kompos, Tas Daur Ulang, dan Kerajinan Tangan.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: 260,
                child: ElevatedButton.icon(
                  onPressed: () => _buka(context, const KatalogPage()),
                  icon: const Icon(Icons.store),
                  label: const Text('Lihat Produk'),
                ),
              ),
              const SizedBox(height: 24),
              const Divider(),
              const Text('Menu Lainnya'),
              const SizedBox(height: 8),
              SizedBox(
                width: 260,
                child: OutlinedButton.icon(
                  onPressed: () => _buka(context, const FormPemesananPage()),
                  icon: const Icon(Icons.edit_note),
                  label: const Text('Form Pemesanan'),
                ),
              ),
              SizedBox(
                width: 260,
                child: OutlinedButton.icon(
                  onPressed: () => _buka(context, const FavoritPage()),
                  icon: const Icon(Icons.favorite),
                  label: const Text('Favorit (Provider)'),
                ),
              ),
              SizedBox(
                width: 260,
                child: OutlinedButton.icon(
                  onPressed: () => _buka(context, const KeranjangPage()),
                  icon: const Icon(Icons.shopping_cart),
                  label: const Text('Keranjang (Cubit)'),
                ),
              ),
              SizedBox(
                width: 260,
                child: OutlinedButton.icon(
                  onPressed: () => _buka(context, const LokasiPage()),
                  icon: const Icon(Icons.map),
                  label: const Text('Lokasi EcoMart'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}