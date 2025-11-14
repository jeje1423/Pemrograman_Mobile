import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profil App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 252, 198, 198),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Header section
            SliverToBoxAdapter(
              child: Container(
                width: double.infinity,
                height: 220, // Ditambah sedikit tinggi
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color.fromARGB(255, 240, 31, 146), Color.fromARGB(255, 243, 36, 122)],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Foto profil
                    Container(
                      width: 100, // Diperkecil sedikit
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color.fromARGB(255, 248, 66, 151), width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/putri.jpg',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.person,
                              size: 60,
                              color: Color(0xFF6A11CB),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Putri yani Anjali',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22, // Diperkecil sedikit
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'NIM:701230052',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14, // Diperkecil sedikit
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Content section
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(height: 20),

                // Informasi profil
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 125, 186),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Email
                      _buildInfoRow(
                        icon: Icons.email,
                        title: 'Email',
                        value: 'putriyanianjali4@gmail.com',
                      ),
                      SizedBox(height: 16),

                      // Telepon
                      _buildInfoRow(
                        icon: Icons.phone,
                        title: 'Telepon',
                        value: '+62 808674557',
                      ),
                      SizedBox(height: 16),

                      // Lokasi
                      _buildInfoRow(
                        icon: Icons.location_on,
                        title: 'Lokasi',
                        value: 'Jambi',
                      ),
                      SizedBox(height: 16),

                      // Tentang
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: Icon(
                              Icons.info,
                              color: Color(0xFF667EEA),
                              size: 20,
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Tentang Saya',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  'hobi saya menonton',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                // Tombol-tombol aksi
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      _buildActionButton(
                        icon: Icons.logout,
                        text: 'Logout',
                        color: Color.fromARGB(255, 245, 115, 106),
                        onPressed: () {
                          // Aksi logout
                        },
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 30),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk baris informasi
  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 2),
          child: Icon(icon, color: Color(0xFF667EEA), size: 20),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Widget untuk tombol aksi
  Widget _buildActionButton({
    required IconData icon,
    required String text,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 3,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18),
          SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}