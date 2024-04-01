import 'dart:io';

import 'package:cookies_recognition_flutter_app/services/cookie_classifier_service.dart';
import 'package:flutter/material.dart';

class ResultClassifierPage extends StatefulWidget {
  const ResultClassifierPage({super.key, required this.imageFile});

  final File imageFile;

  @override
  State<ResultClassifierPage> createState() => _ResultClassifierPageState();
}

class _ResultClassifierPageState extends State<ResultClassifierPage> {
  bool _isLoaded = false;
  bool _isClassified = false;
  String _result = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/cookie_photo_taker');
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 250,
              child: Image.file(widget.imageFile),
            ),
            const SizedBox(height: 50),
            if (_isLoaded)
              const CircularProgressIndicator()
            else if (_isClassified)
              Text(
                'La galleta es: $_result',
                style: const TextStyle(fontSize: 20),
              )
            else
              ElevatedButton(
                onPressed: _classify,
                child: const Text('Clasificar'),
              ),
          ],
        ),
      ),
    );
  }

  void _classify() {
    classifyCookie(widget.imageFile).then((String result) {
      setState(() {
        _isLoaded = false;
        _isClassified = true;
        _result = result;
      });
    });

  }
}
