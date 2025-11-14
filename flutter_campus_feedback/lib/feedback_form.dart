import 'package:flutter/material.dart';
import 'models/feedback_data.dart';
import 'feedback_results.dart'; // TAMBAHKAN IMPORT INI

class FeedbackFormPage extends StatefulWidget {
  const FeedbackFormPage({super.key});

  @override
  _FeedbackFormPageState createState() => _FeedbackFormPageState();
}

class _FeedbackFormPageState extends State<FeedbackFormPage> {
  final _formKey = GlobalKey<FormState>();
  
  String? _facilityRating;
  String? _serviceRating;
  String? _cleanlinessRating;
  String? _internetRating;
  final TextEditingController _suggestionController = TextEditingController();

  final List<Map<String, dynamic>> _ratingOptions = [
    {'value': 'Sangat Tidak Puas', 'emoji': '😠', 'color': Colors.red},
    {'value': 'Tidak Puas', 'emoji': '😞', 'color': Colors.orange},
    {'value': 'Cukup Puas', 'emoji': '😐', 'color': Colors.yellow[700]!},
    {'value': 'Puas', 'emoji': '😊', 'color': Colors.lightGreen},
    {'value': 'Sangat Puas', 'emoji': '😍', 'color': Colors.green},
  ];

  void _submitFeedback() {
    if (_formKey.currentState!.validate()) {
      if (_facilityRating == null ||
          _serviceRating == null ||
          _cleanlinessRating == null ||
          _internetRating == null) {
        _showIncompleteDialog();
        return;
      }
      _showConfirmationDialog();
    }
  }

  void _showIncompleteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Icon(Icons.warning, color: Colors.orange[400]),
              const SizedBox(width: 10),
              const Text('Perhatian'),
            ],
          ),
          content: const Text('Harap lengkapi semua pertanyaan sebelum mengirim.'),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink[400],
              ),
              child: const Text('Mengerti'),
            ),
          ],
        );
      },
    );
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.pink[400]),
              const SizedBox(width: 10),
              const Text('Konfirmasi'),
            ],
          ),
          content: const Text('Apakah Anda yakin ingin mengirim feedback?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _navigateToResults();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink[400],
              ),
              child: const Text('Ya, Kirim'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToResults() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FeedbackResultsPage(
          feedbackData: FeedbackData(
            facilityRating: _facilityRating!,
            serviceRating: _serviceRating!,
            cleanlinessRating: _cleanlinessRating!,
            internetRating: _internetRating!,
            suggestions: _suggestionController.text,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kuesioner Kepuasan'),
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
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildQuestionCard(
                Icons.business,
                'Fasilitas Kampus',
                'Seberapa puas Anda dengan fasilitas kampus?',
                'facility',
              ),
              const SizedBox(height: 16),
              _buildQuestionCard(
                Icons.support_agent,
                'Layanan Administrasi',
                'Seberapa puas Anda dengan layanan administrasi?',
                'service',
              ),
              const SizedBox(height: 16),
              _buildQuestionCard(
                Icons.clean_hands,
                'Kebersihan Kampus',
                'Seberapa puas Anda dengan kebersihan kampus?',
                'cleanliness',
              ),
              const SizedBox(height: 16),
              _buildQuestionCard(
                Icons.wifi,
                'Internet Kampus',
                'Seberapa puas Anda dengan koneksi internet kampus?',
                'internet',
              ),
              const SizedBox(height: 16),
              _buildSuggestionCard(),
              const SizedBox(height: 24),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionCard(IconData icon, String title, String question, String type) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.pink[400], size: 24),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              question,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            _buildRatingOptions(type),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingOptions(String type) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _ratingOptions.map((option) {
        bool isSelected = _getGroupValue(type) == option['value'];
        return GestureDetector(
          onTap: () {
            setState(() {
              _setGroupValue(type, option['value']);
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? option['color'] : Colors.grey[100],
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: isSelected ? option['color'] : Colors.grey[300]!,
                width: 2,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: option['color'].withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ]
                  : [],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  option['emoji'],
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 6),
                Text(
                  option['value'],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? Colors.white : Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSuggestionCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.lightbulb, color: Colors.pink[400]),
                const SizedBox(width: 10),
                const Text(
                  'Saran dan Masukan',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _suggestionController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Masukkan saran dan masukan Anda untuk perbaikan kampus...',
                filled: true,
                fillColor: Colors.grey[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _submitFeedback,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.pink[400],
        padding: const EdgeInsets.symmetric(vertical: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 8,
        shadowColor: Colors.pink.withOpacity(0.5),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.send, color: Colors.white),
          SizedBox(width: 10),
          Text(
            'KIRIM FEEDBACK',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  String? _getGroupValue(String type) {
    switch (type) {
      case 'facility':
        return _facilityRating;
      case 'service':
        return _serviceRating;
      case 'cleanliness':
        return _cleanlinessRating;
      case 'internet':
        return _internetRating;
      default:
        return null;
    }
  }

  void _setGroupValue(String type, String value) {
    switch (type) {
      case 'facility':
        _facilityRating = value;
        break;
      case 'service':
        _serviceRating = value;
        break;
      case 'cleanliness':
        _cleanlinessRating = value;
        break;
      case 'internet':
        _internetRating = value;
        break;
    }
  }
}