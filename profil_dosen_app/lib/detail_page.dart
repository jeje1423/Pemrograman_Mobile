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
  final String deskripsi;

  Dosen({
    required this.id,
    required this.nama,
    required this.nip,
    required this.jabatan,
    required this.email,
    required this.bidang,
    required this.deskripsi,
  });
}

// Data Dummy Dosen
final List<Dosen> dosenList = [
  Dosen(
    id: '1',
    nama: 'Dr. Ahmad Wijaya, M.T.',
    nip: '198012342345678901',
    jabatan: 'Dosen Tetap',
    email: 'ahmad@university.ac.id',
    bidang: 'Artificial Intelligence',
    deskripsi: 'Spesialis dalam machine learning dan deep learning. Pengalaman penelitian lebih dari 10 tahun.',
  ),
  Dosen(
    id: '2',
    nama: 'Prof. Dr. Siti Rahayu, M.Si.',
    nip: '197512345678901234',
    jabatan: 'Guru Besar',
    email: 'siti@university.ac.id',
    bidang: 'Matematika Komputasi',
    deskripsi: 'Ahli dalam pemodelan matematika dan analisis numerik. Memiliki berbagai publikasi internasional.',
  ),
  Dosen(
    id: '3',
    nama: 'Dian Pratama, M.Kom.',
    nip: '198512345678901235',
    jabatan: 'Dosen Tetap',
    email: 'dian@university.ac.id',
    bidang: 'Mobile Development',
    deskripsi: 'Fokus pada pengembangan aplikasi mobile cross-platform dan UI/UX design.',
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
            color: Colors.pink[50],
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.pink[100],
                child: Icon(Icons.person, color: Colors.pink[800]),
              ),
              title: Text(
                dosen.nama,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.pink,
                ),
              ),
              subtitle: Text(
                dosen.jabatan,
                style: TextStyle(color: Colors.pink[700]),
              ),
              trailing: Icon(Icons.arrow_forward, color: Colors.pink[800]),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DosenDetailPinkScreen(dosen: dosen),
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

// Halaman 2: Detail Dosen dengan Tema Pink
class DosenDetailPinkScreen extends StatelessWidget {
  final Dosen dosen;

  const DosenDetailPinkScreen({super.key, required this.dosen});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        title: const Text(
          'Detail Dosen',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header dengan gradient pink
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.pink[400]!,
                    Colors.pink[300]!,
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.pink[400],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    dosen.nama,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    dosen.jabatan,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.pink[100],
                    ),
                  ),
                ],
              ),
            ),
            
            // Card Informasi
            Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                color: Colors.white,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // NIP
                      _buildInfoRow(
                        Icons.badge,
                        'NIP',
                        dosen.nip,
                        Colors.pink,
                      ),
                      const SizedBox(height: 16),
                      
                      // Email
                      _buildInfoRow(
                        Icons.email,
                        'Email',
                        dosen.email,
                        Colors.pink,
                      ),
                      const SizedBox(height: 16),
                      
                      // Bidang Keahlian
                      _buildInfoRow(
                        Icons.school,
                        'Bidang Keahlian',
                        dosen.bidang,
                        Colors.pink,
                      ),
                      const SizedBox(height: 16),
                      
                      // Deskripsi
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.description,
                            color: Colors.pink,
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Deskripsi',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.pink[600],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  dosen.deskripsi,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            // Tombol Aksi
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.email, color: Colors.white),
                      label: const Text(
                        'Kirim Email',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.phone, color: Colors.pink[700]),
                      label: Text(
                        'Hubungi',
                        style: TextStyle(color: Colors.pink[700]),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        side: BorderSide(color: Colors.pink[700]!),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: color,
          size: 24,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.pink[600],
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}