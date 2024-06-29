import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CopyrightPage extends StatelessWidget {
  final Uri _urlappicon = Uri.parse('https://www.flaticon.com/free-icon/pastime_3364989/');
  final Uri _urlbackground = Uri.parse('https://app.haikei.app/');

  final Uri _urlFlutter = Uri.parse('https://flutter.dev');
  final Uri _urllauncher = Uri.parse('https://pub.dev/packages/url_launcher');
  final Uri _urlcarousel_slider = Uri.parse('https://pub.dev/packages/carousel_slider');
  final Uri _urlsharedPreferences = Uri.parse('https://pub.dev/packages/shared_preferences');

  Future<void> _launchURL(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Copyright Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '© 2024 Miso Studio',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                'All rights reserved.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              const Text(
                'This game and all its contents, including but not limited to text, graphics, logos, icons, images, audio clips, digital downloads, and software, are the property of Your Game Studio and are protected by international copyright laws.',
                style: TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 16),
              const Text(
                'Contributing Assets:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                'Graphics:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () => _launchURL(_urlappicon),
                child: const Text(
                  '• Sudoku (Pastime) - App Icon ',
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
              ),
              GestureDetector(
                onTap: () => _launchURL(_urlbackground),
                child: const Text(
                  '• Blob Page (Haikei)  - Background Art',
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Code Libraries:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () => _launchURL(_urlFlutter),
                child: const Text(
                  '• Flutter - UI Framework',
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
              ),
              GestureDetector(
                onTap: () => _launchURL(_urllauncher),
                child: const Text(
                  '• Url Launcher  - Responsile of launching URL',
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
              ),
              GestureDetector(
                onTap: () => _launchURL(_urlcarousel_slider),
                child: const Text(
                  '• Carousel Slider   - A carousel slider widget',
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
              ),
              GestureDetector(
                onTap: () => _launchURL(_urlsharedPreferences),
                child: const Text(
                  '• Shared Preferences    -  platform-specific persistent storage  ',
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
