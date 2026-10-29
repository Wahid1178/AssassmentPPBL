import 'package:flutter/material.dart';

/// Latihan 3 — Form pemesanan: TextField, RadioListTile, Checkbox, SnackBar.
class FormPemesananPage extends StatefulWidget {
  const FormPemesananPage({super.key});

  @override
  State<FormPemesananPage> createState() => _FormPemesananPageState();
}

class _FormPemesananPageState extends State<FormPemesananPage> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();

  String _metodePembayaran = 'Tunai';
  bool _setuju = false;

  @override
  void dispose() {
    _namaController.dispose();
    _alamatController.dispose();
    super.dispose();
  }

  void _kirimPesanan() {
    final pesan = _setuju
        ? 'Pesanan berhasil dibuat'
        : 'Centang persetujuan terlebih dahulu';

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(pesan)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Pemesanan')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _namaController,
            decoration: const InputDecoration(
              labelText: 'Nama Pembeli',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _alamatController,
            decoration: const InputDecoration(
              labelText: 'alamat Pengiriman',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.home),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Metode Pembayaran',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          // Catatan: di Flutter terbaru groupValue/onChanged pada RadioListTile
          // ditandai deprecated (hanya warning), tetapi tetap berjalan normal.
          RadioListTile<String>(
            title: const Text('Diantar'),
            value: 'Diantar',
            groupValue: _metodePembayaran,
            onChanged: (nilai) => setState(() => _metodePembayaran = nilai!),
          ),
          RadioListTile<String>(
            title: const Text('Ambil di Tempat'),
            value: 'Ambil di Tempat',
            groupValue: _metodePembayaran,
            onChanged: (nilai) => setState(() => _metodePembayaran = nilai!),
          ),
          Row(
            children: [
              Checkbox(
                value: _setuju,
                onChanged: (nilai) => setState(() => _setuju = nilai ?? false),
              ),
              const Expanded(child: Text('Saya menyetujui pemesanan ini')),
            ],
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: _kirimPesanan,
            child: const Text('Pesan'),
          ),
        ],
      ),
    );
  }
}