import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/produk.dart';

/// Latihan 5 — Cubit untuk keranjang belanja.
/// State = daftar ItemKeranjang (hanya produk yang sudah dipesan).
class KeranjangCubit extends Cubit<List<ItemKeranjang>> {
  KeranjangCubit() : super([]);

  /// Tambah 1 produk. Jika belum ada di keranjang, dimasukkan dengan jumlah 1.
  void tambahBarang(Produk produk) {
    final daftar = List<ItemKeranjang>.from(state);
    final indeks = daftar.indexWhere((item) => item.produk.nama == produk.nama);
    if (indeks == -1) {
      daftar.add(ItemKeranjang(produk: produk));
    } else {
      daftar[indeks] = ItemKeranjang(
        produk: produk,
        jumlah: daftar[indeks].jumlah + 1,
      );
    }
    emit(daftar);
  }

  /// Kurangi 1 produk. Jika jumlahnya tinggal 1, produk dihapus dari keranjang.
  void kurangiBarang(Produk produk) {
    final daftar = List<ItemKeranjang>.from(state);
    final indeks = daftar.indexWhere((item) => item.produk.nama == produk.nama);
    if (indeks == -1) return;
    if (daftar[indeks].jumlah == 1) {
      daftar.removeAt(indeks);
    } else {
      daftar[indeks] = ItemKeranjang(
        produk: produk,
        jumlah: daftar[indeks].jumlah - 1,
      );
    }
    emit(daftar);
  }

  /// Mengosongkan seluruh keranjang.
  void kosongkanKeranjang() {
    emit([]);
  }

  /// Total seluruh barang di keranjang.
  int get totalBarang => state.fold(0, (total, item) => total + item.jumlah);

  /// Total harga seluruh barang di keranjang.
  int get totalHarga => state.fold(0, (total, item) => total + item.subtotal);
}