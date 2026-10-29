import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Latihan 6 — Lokasi komunitas GreenLife Bandung dengan Google Maps.
class LokasiPage extends StatelessWidget {
  const LokasiPage({super.key});

  static const LatLng _lokasiGreenLife = LatLng(-6.914744, 107.609810);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lokasi Bank Sampah Hijau')),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: _lokasiGreenLife,
          zoom: 15,
        ),
        markers: {
          const Marker(
            markerId: MarkerId('greenlife-bandung'),
            position: _lokasiGreenLife,
            infoWindow: InfoWindow(title: 'Bank Sampah Hijau'),
          ),
        },
      ),
    );
  }
}