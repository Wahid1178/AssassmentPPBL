import 'package:flutter/foundation.dart';

/// Latihan 4 — Provider untuk mengelola produk favorit.
/// Yang disimpan adalah indeks produk (sesuai urutan di daftarProduk).
class FavoritProvider extends ChangeNotifier {
  final Set<int> _favorit = {};

  /// Jumlah produk yang ditandai favorit (nilai awal 0).
  int get jumlahFavorit => _favorit.length;

  /// Daftar indeks produk favorit (terurut).
  List<int> get daftarFavorit => _favorit.toList()..sort();

  /// true = hati merah, false = hati putih.
  bool isFavorit(int index) => _favorit.contains(index);

  /// Ditekan sekali -> favorit, ditekan lagi -> batal favorit.
  void toggleFavorit(int index) {
    if (!_favorit.remove(index)) {
      _favorit.add(index);
    }
    notifyListeners();
  }

  void resetFavorit() {
    _favorit.clear();
    notifyListeners();
  }
}