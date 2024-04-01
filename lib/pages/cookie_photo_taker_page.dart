import 'dart:io';

import 'package:cookies_recognition_flutter_app/pages/result_classifier_page.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CookiePhotoTakerPage extends StatefulWidget {
  const CookiePhotoTakerPage({super.key});

  @override
  State<CookiePhotoTakerPage> createState() => _CookiePhotoTakerPageState();
}

class _CookiePhotoTakerPageState extends State<CookiePhotoTakerPage> {
  CameraLensDirection _cameraLensDirection = CameraLensDirection.back;

  static List<CameraDescription> _cameras = [];
  CameraController? _controller;
  int _cameraIndex = -1;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  void dispose() {
    super.dispose();
    _stopLiveFeed();
  }

  void _initialize() async {
    if (_cameras.isEmpty) {
      _cameras = await availableCameras();
    }
    for (var i = 0; i < _cameras.length; i++) {
      if (_cameras[i].lensDirection == _cameraLensDirection) {
        _cameraIndex = i;
        break;
      }
    }
    if (_cameraIndex != -1) {
      _startLiveFeed();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Take a photo of the cookie'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              _stopLiveFeed();
              Navigator.pop(context);
            },
          )),
      body: _cameraIndex == -1
          ? const Center(
              child: Text(
                'No camera found',
                style: TextStyle(color: Colors.white),
              ),
            )
          : Stack(children: <Widget>[
              if (_controller != null && _controller!.value.isInitialized)
                CameraPreview(_controller!),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(60),
                  child: FloatingActionButton(
                    onPressed: () {
                      _controller?.takePicture().then((XFile? file) {
                        if (file != null) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResultClassifierPage(
                                  imageFile: File(file.path)),
                            ),
                          );
                        }
                      });
                    },
                    child: const Icon(Icons.camera),
                  ),
                ),
              ),
            ]),
    );
  }

  Future _startLiveFeed() async {
    final camera = _cameras[_cameraIndex];
    _controller = CameraController(
      camera,
      // Set to ResolutionPreset.high. Do NOT set it to ResolutionPreset.max because for some phones does NOT work.
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: Platform.isAndroid
          ? ImageFormatGroup.nv21
          : ImageFormatGroup.bgra8888,
    );
    _controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  Future _stopLiveFeed() async {
    await _controller?.dispose();
    _controller = null;
  }

  void onCameraLensDirectionChanged(CameraLensDirection value) {
    _cameraLensDirection = value;
  }
}
