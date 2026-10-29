/// Model data produk. Data disimpan lokal (tanpa database).
class Produk {
  final String nama;
  final int harga;

  const Produk({required this.nama, required this.harga});
}

/// Satu baris isi keranjang: produk + jumlah yang dipesan.
class ItemKeranjang {
  final Produk produk;
  final int jumlah;

  const ItemKeranjang({required this.produk, this.jumlah = 1});

  int get subtotal => produk.harga * jumlah;
}

/// Daftar produk disimpan menggunakan List (Latihan 2).
const List<Produk> daftarProduk = [
  Produk(nama: 'Pupuk Kompos Organik', harga: 15000),
  Produk(nama: 'Pot Tanaman Daur Ulang', harga: 25000),
  Produk(nama: 'Tas Kemasan Daur Ulang', harga: 35000),
];

/// Mengubah 30000 menjadi "Rp30.000".
String formatRupiah(int angka) {
  final teks = angka.toString().replaceAllMapped(
        RegExp(r'\B(?=(\d{3})+(?!\d))'),
        (match) => '.',
      );
  return 'Rp$teks';
}