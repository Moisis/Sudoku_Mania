import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CopyrightPage extends StatelessWidget {
  final Uri _urlappicon = Uri.parse('https://www.flaticon.com/free-icon/pastime_3364989/');
  final Uri _urlbackground = Uri.parse('https://app.haikei.app/');

  final Uri _urlFlutter = Uri.parse('https://flutter.dev');
  final Uri _urllauncher = Uri.parse('https://pub.dev/packages/url_launcher');
  final Uri _urlcarousel_slider = Uri.parse('https://pub.dev/packages/carousel_slider');
  final Uri _urlSoundSnap = Uri.parse('https://soundsnap.com');

  final Uri _urlFirebase = Uri.parse('https://firebase.google.com');
  final Uri _urlBloc = Uri.parse('https://bloclibrary.dev');


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
        title: Text('Copyright Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '© 2024 Miso Studio',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                'All rights reserved.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'This game and all its contents, including but not limited to text, graphics, logos, icons, images, audio clips, digital downloads, and software, are the property of Your Game Studio and are protected by international copyright laws.',
                style: TextStyle(fontSize: 16),
              ),

              SizedBox(height: 16),
              Text(
                'Contributing Assets:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                'Graphics:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () => _launchURL(_urlappicon),
                child: Text(
                  '• Sudoku (Pastime) - App Icon ',
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
              ),
              GestureDetector(
                onTap: () => _launchURL(_urlbackground),
                child: Text(
                  '• Blob Page (Haikei)  - Background Art',
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Code Libraries:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () => _launchURL(_urlFlutter),
                child: Text(
                  '• Flutter - UI Framework',
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
              ),
              GestureDetector(
                onTap: () => _launchURL(_urllauncher),
                child: Text(
                  '• Url Launcher  - Responsile of launching URL',
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
              ),
              GestureDetector(
                onTap: () => _launchURL(_urlcarousel_slider),
                child: Text(
                  '• Carousel Slider   - A carousel slider widget',
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
              ),
              // GestureDetector(
              //   onTap: () => _launchURL(_urlBloc),
              //   child: Text(
              //     '• Shared_preferences - State Management',
              //     style: TextStyle(fontSize: 16, color: Colors.blue),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
