import 'package:flutter/material.dart';
import 'models/feedback_data.dart'; // IMPORT MODEL
import 'feedback_form.dart';

class FeedbackResultsPage extends StatelessWidget {
  final FeedbackData? feedbackData;

  const FeedbackResultsPage({super.key, this.feedbackData});

  @override
  Widget build(BuildContext context) {
    final FeedbackData data = feedbackData ??
        FeedbackData(
          facilityRating: 'Sangat Puas',
          serviceRating: 'Puas',
          cleanlinessRating: 'Cukup Puas',
          internetRating: 'Puas',
          suggestions: 'Terima kasih atas layanannya!',
        );

    final Map<String, String> ratingEmojis = {
      'Sangat Tidak Puas': '😠',
      'Tidak Puas': '😞',
      'Cukup Puas': '😐',
      'Puas': '😊',
      'Sangat Puas': '😍',
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil Feedback'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.pink[50]!,
              Colors.pink[100]!,
              const Color(0xFFF8BBD0),
            ],
          ),
        ),
        child: Column(
          children: [
            // Success Header
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.pink[300]!, Colors.pink[400]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.pink.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.celebration,
                    size: 50,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Terima Kasih!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    feedbackData == null
                        ? 'Contoh Hasil Feedback'
                        : 'Feedback Anda sangat berharga bagi kami',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.9),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            // Results Cards
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  _buildResultCard(
                    '🏛️',
                    'Fasilitas Kampus',
                    data.facilityRating,
                    ratingEmojis[data.facilityRating]!,
                  ),
                  const SizedBox(height: 12),
                  _buildResultCard(
                    '👨‍💼',
                    'Layanan Administrasi',
                    data.serviceRating,
                    ratingEmojis[data.serviceRating]!,
                  ),
                  const SizedBox(height: 12),
                  _buildResultCard(
                    '🧹',
                    'Kebersihan Kampus',
                    data.cleanlinessRating,
                    ratingEmojis[data.cleanlinessRating]!,
                  ),
                  const SizedBox(height: 12),
                  _buildResultCard(
                    '📶',
                    'Internet Kampus',
                    data.internetRating,
                    ratingEmojis[data.internetRating]!,
                  ),
                  if (data.suggestions.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.lightbulb, color: Colors.amber),
                                const SizedBox(width: 10),
                                const Text(
                                  'Saran Anda',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              data.suggestions,
                              style: const TextStyle(
                                fontSize: 14,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Action Buttons
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: BorderSide(color: Colors.pink[400]!),
                      ),
                      child: Text(
                        'KEMBALI',
                        style: TextStyle(
                          color: Colors.pink[400],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  if (feedbackData != null)
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FeedbackFormPage() // DIUBAH: hapus const
                          ),
                          (route) => false,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink[400],
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'ISI LAGI',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
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

  Widget _buildResultCard(String emoji, String category, String rating, String ratingEmoji) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Text(
              emoji,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    rating,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.pink[50],
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.pink[200]!),
              ),
              child: Row(
                children: [
                  Text(
                    ratingEmoji,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    rating,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink[600],
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
}

// HAPUS CLASS FeedbackData DARI SINI, SUDAH DIPINDAH KE FILE TERPISAH