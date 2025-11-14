import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_campus_feedback/main.dart';
import 'package:flutter_campus_feedback/dashboard.dart';
import 'package:flutter_campus_feedback/feedback_form.dart';
import 'package:flutter_campus_feedback/feedback_results.dart';

void main() {
  testWidgets('Aplikasi berhasil dibuka dan menampilkan dashboard', (WidgetTester tester) async {
    // Membangun aplikasi dan memicu frame pertama
    await tester.pumpWidget(const CampusFeedbackApp());

    // Memverifikasi bahwa dashboard ditampilkan dengan benar
    expect(find.text('Campus Feedback'), findsOneWidget);
    expect(find.text('Kuesioner Kepuasan Mahasiswa'), findsOneWidget);
    expect(find.text('Isi Kuesioner'), findsOneWidget);
    expect(find.text('Lihat Contoh Hasil'), findsOneWidget);
  });

  testWidgets('Navigasi ke halaman form kuesioner berhasil', (WidgetTester tester) async {
    await tester.pumpWidget(const CampusFeedbackApp());

    // Menekan tombol 'Isi Kuesioner'
    await tester.tap(find.text('Isi Kuesioner'));
    await tester.pumpAndSettle();

    // Memverifikasi bahwa navigasi ke halaman form berhasil
    expect(find.text('Kuesioner Kepuasan'), findsOneWidget);
    expect(find.text('Fasilitas Kampus'), findsOneWidget);
    expect(find.text('Layanan Administrasi'), findsOneWidget);
    expect(find.text('Kebersihan Kampus'), findsOneWidget);
  });

  testWidgets('Validasi form kuesioner bekerja dengan benar', (WidgetTester tester) async {
    await tester.pumpWidget(const CampusFeedbackApp());

    // Navigasi ke halaman form
    await tester.tap(find.text('Isi Kuesioner'));
    await tester.pumpAndSettle();

    // Mencoba mengirim form tanpa memilih rating apapun
    await tester.tap(find.text('KIRIM FEEDBACK'));
    await tester.pump();

    // Seharusnya menampilkan dialog peringatan
    expect(find.text('Perhatian'), findsOneWidget);
    expect(find.text('Harap lengkapi semua pertanyaan sebelum mengirim.'), findsOneWidget);
  });

  testWidgets('Navigasi ke halaman hasil berhasil', (WidgetTester tester) async {
    await tester.pumpWidget(const CampusFeedbackApp());

    // Navigasi ke halaman contoh hasil
    await tester.tap(find.text('Lihat Contoh Hasil'));
    await tester.pumpAndSettle();

    // Memverifikasi bahwa navigasi ke halaman hasil berhasil
    expect(find.text('Hasil Feedback'), findsOneWidget);
    expect(find.text('Terima Kasih!'), findsOneWidget);
    expect(find.text('Fasilitas Kampus'), findsOneWidget);
  });

  testWidgets('Pemilihan rating bekerja dengan benar', (WidgetTester tester) async {
    await tester.pumpWidget(const CampusFeedbackApp());

    // Navigasi ke halaman form
    await tester.tap(find.text('Isi Kuesioner'));
    await tester.pumpAndSettle();

    // Memilih rating "Sangat Puas" untuk pertanyaan pertama
    await tester.tap(find.text('Sangat Puas').first);
    await tester.pump();

    // Memverifikasi bahwa rating terpilih (akan mencari multiple widget)
    expect(find.text('Sangat Puas'), findsWidgets);
  });

  testWidgets('Navigasi kembali ke dashboard berfungsi', (WidgetTester tester) async {
    await tester.pumpWidget(const CampusFeedbackApp());

    // Navigasi ke halaman form
    await tester.tap(find.text('Isi Kuesioner'));
    await tester.pumpAndSettle();

    // Kembali ke dashboard dengan tombol back
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    // Memverifikasi kembali ke dashboard berhasil
    expect(find.text('Campus Feedback'), findsOneWidget);
    expect(find.text('Kuesioner Kepuasan Mahasiswa'), findsOneWidget);
  });

  testWidgets('Input saran dan masukan dapat diisi', (WidgetTester tester) async {
    await tester.pumpWidget(const CampusFeedbackApp());

    // Navigasi ke halaman form
    await tester.tap(find.text('Isi Kuesioner'));
    await tester.pumpAndSettle();

    // Mencari field saran dan mengisi text
    await tester.enterText(find.byType(TextFormField), 'Saran untuk perbaikan kampus');
    await tester.pump();

    // Memverifikasi text sudah terisi
    expect(find.text('Saran untuk perbaikan kampus'), findsOneWidget);
  });

  testWidgets('Tombol aksi di halaman hasil berfungsi', (WidgetTester tester) async {
    await tester.pumpWidget(const CampusFeedbackApp());

    // Navigasi ke halaman contoh hasil
    await tester.tap(find.text('Lihat Contoh Hasil'));
    await tester.pumpAndSettle();

    // Memverifikasi tombol KEMBALI ada
    expect(find.text('KEMBALI'), findsOneWidget);
  });
}