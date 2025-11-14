import 'package:flutter/material.dart';

void main() {
  runApp(const FeedbackApp());
}

class FeedbackApp extends StatelessWidget {
  const FeedbackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feedback App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.pink,
          foregroundColor: Colors.white,
        ),
      ),
      home: const FeedbackFormScreen(),
    );
  }
}

class FeedbackFormScreen extends StatefulWidget {
  const FeedbackFormScreen({super.key});

  @override
  State<FeedbackFormScreen> createState() => _FeedbackFormScreenState();
}

class _FeedbackFormScreenState extends State<FeedbackFormScreen> {
  final _namaController = TextEditingController();
  final _komentarController = TextEditingController();
  int _rating = 3;
  
  // Key untuk form validation
  final _formKey = GlobalKey<FormState>();

  void _submitFeedback() {
    // Cek validasi form
    if (_formKey.currentState!.validate()) {
      // Jika valid, lanjutkan ke halaman hasil
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FeedbackResultScreen(
            nama: _namaController.text,
            komentar: _komentarController.text,
            rating: _rating,
          ),
        ),
      );
    }
  }

  // Validator untuk nama
  String? _validateNama(String? value) {
    if (value == null || value.isEmpty) {
      return 'Putri Yani Anjali';
    }
    return null;
  }

  // Validator untuk komentar
  String? _validateKomentar(String? value) {
    if (value == null || value.isEmpty) {
      return 'Sangat menarik';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Feedback'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Tambahkan form key
          child: Column(
            children: [
              // Input Nama dengan validasi
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person, color: Colors.pink),
                ),
                validator: _validateNama,
              ),
              const SizedBox(height: 20),
              
              // Input Komentar dengan validasi
              TextFormField(
                controller: _komentarController,
                decoration: const InputDecoration(
                  labelText: 'Komentar',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.comment, color: Colors.pink),
                ),
                maxLines: 3,
                validator: _validateKomentar,
              ),
              const SizedBox(height: 20),
              
              // Rating
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Rating (1-5):',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(5, (index) {
                      final rating = index + 1;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _rating = rating;
                          });
                        },
                        child: Icon(
                          Icons.star,
                          size: 40,
                          color: rating <= _rating ? Colors.pink : Colors.grey,
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Rating: $_rating/5',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              
              const SizedBox(height: 30),
              
              // Tombol Submit
              ElevatedButton(
                onPressed: _submitFeedback,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  'Submit Feedback',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _namaController.dispose();
    _komentarController.dispose();
    super.dispose();
  }
}

class FeedbackResultScreen extends StatelessWidget {
  final String nama;
  final String komentar;
  final int rating;

  const FeedbackResultScreen({
    super.key,
    required this.nama,
    required this.komentar,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil Feedback'),
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Terima kasih atas feedback Anda!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            
            Card(
              color: Colors.pink[50],
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nama
                    const Text(
                      'Nama:',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.pink),
                    ),
                    Text(nama),
                    const SizedBox(height: 15),
                    
                    // Komentar
                    const Text(
                      'Komentar:',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.pink),
                    ),
                    Text(komentar),
                    const SizedBox(height: 15),
                    
                    // Rating
                    const Text(
                      'Rating:',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.pink),
                    ),
                    Row(
                      children: [
                        Row(
                          children: List.generate(5, (index) {
                            return Icon(
                              Icons.star,
                              color: (index + 1) <= rating ? Colors.pink : Colors.grey,
                            );
                          }),
                        ),
                        const SizedBox(width: 10),
                        Text('$rating/5', style: const TextStyle(color: Colors.pink)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Tombol Kembali
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Kembali ke Form'),
            ),
          ],
        ),
      ),
    );
  }
}