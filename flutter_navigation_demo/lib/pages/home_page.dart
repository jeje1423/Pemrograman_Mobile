import 'package:flutter/material.dart';
import 'detail_page.dart';
import 'bottom_nav_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Halaman Utama')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Icon(Icons.favorite, color: Colors.pink, size: 80),
            const SizedBox(height: 12),
            const Text(
              "Flutter Navigation Demo",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 18),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Masukkan Nama Anda",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.send),
              label: const Text("Kirim ke Halaman Detail"),
              onPressed: () {
                // kirim data (nama) ke halaman detail
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(name: nameController.text),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              icon: const Icon(Icons.navigation),
              label: const Text("Buka Bottom Navigation"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BottomNavPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
