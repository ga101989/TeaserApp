import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teaser/profil.dart';
import 'dart:async';

class RecordingPage extends StatefulWidget {
  @override
  _RecordingPageState createState() => _RecordingPageState();
}

class _RecordingPageState extends State<RecordingPage>
    with SingleTickerProviderStateMixin {
  bool isRecording = false;
  double _progressValue = 0.0;
  Timer? _timer;
  int _duration = 15;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Teaser',
          style: GoogleFonts.shrikhand(color: Colors.teaserO, fontSize: 40),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.teaserO, size: 40),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, size: 40, color: Colors.teaserO),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  isRecording = !isRecording;
                  if (isRecording) {
                    _startTimer();
                  } else {
                    _stopTimer();
                    _stopRecording();
                  }
                });
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: isRecording ? 100 : 200,
                width: isRecording ? 100 : 200,
                decoration: BoxDecoration(
                  color: isRecording ? Colors.red : Colors.OrangeC,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.mic,
                  size: isRecording ? 40 : 80,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              isRecording ? 'Enregistrement en cours...' : 'Appuyez pour enregistrer',
              style: GoogleFonts.shrikhand(color: Colors.teaserO, fontSize: 20),
            ),
            SizedBox(height: 20),
            Visibility(
              visible: isRecording,
              child: CircularProgressIndicator(
                value: _progressValue,
                backgroundColor: Colors.grey,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.teaserO),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _startTimer() {
    _progressValue = 0.0;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _progressValue += 1 / _duration;
        if (_progressValue >= 1.0) {
          _stopTimer();
          _stopRecording();
        }
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _progressValue = 0.0;
    isRecording = false;
  }

  void _stopRecording() {
    // Mettre ici le code pour arrêter l'enregistrement
    // Par exemple :
    // enregistreur.stop();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
