import 'package:flutter/material.dart';

void main() {
  runApp(const ProfilDosenApp());
}

class ProfilDosenApp extends StatelessWidget {
  const ProfilDosenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profil Dosen',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const DosenListScreen(),
    );
  }
}

// Model Data Dosen
class Dosen {
  final String id;
  final String nama;
  final String nip;
  final String jabatan;
  final String email;
  final String bidang;

  Dosen({
    required this.id,
    required this.nama,
    required this.nip,
    required this.jabatan,
    required this.email,
    required this.bidang,
  });
}

// Data Dummy Dosen
final List<Dosen> dosenList = [
  Dosen(
    id: '1',
    nama: 'M. Riduan Saputra, S.kom.,M.Kom',
    nip: '198012342345678901',
    jabatan: 'Dosen Tetap',
    email: 'riduan@UIN.ac.id',
    bidang: 'Management Information System',
  ),
  Dosen(
    id: '2',
    nama: ' Putri Yani Anjali ,S.Kom, M.S.I',
    nip: '197512345678901234',
    jabatan: 'Dosen Tetap',
    email: 'putri@UIN.ac.id',
    bidang: 'Management Information System',
  ),
  Dosen(
    id: '3',
    nama: 'Berlian, M.Kom.',
    nip: '198512345678901235',
    jabatan: 'Dosen Tetap',
    email: 'berlian@UIN.ac.id',
    bidang: 'Management Information System ',
  ),
];

// Halaman 1: Daftar Dosen
class DosenListScreen extends StatelessWidget {
  const DosenListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Dosen'),
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: dosenList.length,
        itemBuilder: (context, index) {
          final dosen = dosenList[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.pink,
                child: Icon(Icons.person, color: Colors.white),
              ),
              title: Text(
                dosen.nama,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(dosen.jabatan),
              trailing: const Icon(Icons.arrow_forward, color: Colors.pink),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DosenDetailScreen(dosen: dosen),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// Halaman 2: Detail Dosen
class DosenDetailScreen extends StatelessWidget {
  final Dosen dosen;

  const DosenDetailScreen({super.key, required this.dosen});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Dosen'),
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.dark_mode),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DosenDetailDarkScreen(dosen: dosen),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.pink,
                child: Icon(Icons.person, size: 40, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            _buildInfoItem('M. Riduan Saputra, S.kom.,M.Kom', dosen.nama),
            _buildInfoItem('198012342345678901', dosen.nip),
            _buildInfoItem('Dosen Tetap', dosen.jabatan),
            _buildInfoItem('riduan@UIN.ac.id', dosen.email),
            _buildInfoItem('Management Information System', dosen.bidang),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.pink,
            ),
          ),
          const SizedBox(height: 8),
          const Divider(),
        ],
      ),
    );
  }
}

// Halaman Detail Dark Mode Pink
class DosenDetailDarkScreen extends StatelessWidget {
  final Dosen dosen;

  const DosenDetailDarkScreen({super.key, required this.dosen});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text('Detail Dosen - Dark Mode'),
        backgroundColor: Colors.pink[800],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.light_mode),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.pink[700],
                child: const Icon(Icons.person, size: 40, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            _buildInfoItem('Putri Yani Anjali ,S.Kom, M.S.I', dosen.nama),
            _buildInfoItem('197512345678901234', dosen.nip),
            _buildInfoItem('Dosen Tetap', dosen.jabatan),
            _buildInfoItem('putri@UIN.ac.id', dosen.email),
            _buildInfoItem('Management Information System', dosen.bidang),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.pink[200],
            ),
          ),
          const SizedBox(height: 8),
          const Divider(color: Colors.grey),
        ],
      ),
    );
  }
}