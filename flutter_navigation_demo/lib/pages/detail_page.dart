import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final String name;
  const DetailPage({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    final displayName = (name.trim().isEmpty) ? 'Pengguna' : name.trim();
    return Scaffold(
      appBar: AppBar(title: const Text('Halaman Detail')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.person, size: 80, color: Colors.pink),
            const SizedBox(height: 16),
            Text(
              "Halo, $displayName 💕",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.arrow_back),
              label: const Text("Kembali"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
