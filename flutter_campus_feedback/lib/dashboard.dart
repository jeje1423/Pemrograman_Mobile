import 'package:flutter/material.dart';
import 'feedback_form.dart';
import 'feedback_results.dart';
import 'models/feedback_data.dart'; // IMPORT MODEL

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Campus Feedback'),
        centerTitle: true,
        automaticallyImplyLeading: false,
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
            // Header Section
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.pink[300]!, Colors.pink[400]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(25),
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
                    Icons.school,
                    size: 60,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Kuesioner Kepuasan Mahasiswa',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 10,
                          color: Colors.pink[800]!,
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Bantu kami meningkatkan kualitas fasilitas dan layanan kampus',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.9),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            // Stats Cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      Icons.people,
                      '500+',
                      'Responden',
                      Colors.pink[300]!,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: _buildStatCard(
                      Icons.star,
                      '4.5/5',
                      'Rating Avg',
                      Colors.pink[400]!,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Quick Actions
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quick Actions',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink[800],
                      ),
                    ),
                    const SizedBox(height: 15),
                    _buildActionButton(
                      context,
                      'Isi Kuesioner',
                      Icons.assignment,
                      Colors.pink[400]!,
                    ),
                    const SizedBox(height: 15),
                    _buildActionButton(
                      context,
                      'Lihat Contoh Hasil',
                      Icons.analytics,
                      Colors.pink[500]!,
                      isExample: true,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(IconData icon, String value, String label, Color color) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.pink.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
      BuildContext context, String text, IconData icon, Color color,
      {bool isExample = false}) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (isExample) {
            // Navigate to results with example data
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FeedbackResultsPage(
                  feedbackData: FeedbackData( // GUNAKAN MODEL
                    facilityRating: 'Sangat Puas',
                    serviceRating: 'Puas',
                    cleanlinessRating: 'Cukup Puas',
                    internetRating: 'Puas',
                    suggestions: 'Contoh saran untuk perbaikan kampus',
                  ),
                ),
              ),
            );
          } else {
            // Navigate to form
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const FeedbackFormPage(),
              ),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.all(18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
          shadowColor: color.withOpacity(0.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}