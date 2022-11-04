import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mirry/src/config/theme/colors.dart';
import 'package:mirry/src/modules/upload_face_screen/widgets/face_mask.dart';

class UploadFaceScreenView extends StatefulWidget {
  const UploadFaceScreenView({Key? key}) : super(key: key);

  @override
  State<UploadFaceScreenView> createState() => _UploadFaceScreenViewState();
}

class _UploadFaceScreenViewState extends State<UploadFaceScreenView> {
  CameraController? _cameraController;
  late List<CameraDescription> _cameras;

  @override
  void initState() {
    _initCamera();
    super.initState();
  }

  Future<void> _initCamera() async {
    _cameras = await availableCameras();
    _cameraController = CameraController(_cameras[1], ResolutionPreset.max);
    await _cameraController!.initialize();
    setState(() {});
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  Future<void> _onPhotoTake() async {
    final image = await _cameraController!.takePicture();
    final file = File(image.path);

    context.router.pop(file);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 600),
        child: _cameraController == null
            ? Container()
            : Stack(
                children: [
                  SizedBox(
                    width: size.width,
                    height: size.height,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: 100,
                        child: CameraPreview(_cameraController!),
                      ),
                    ),
                  ),
                  const FaceMask(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      margin: const EdgeInsets.only(bottom: 24),
                      decoration: const BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        boxShadow: [BoxShadow(blurRadius: 4)],
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.camera_alt_rounded,
                          size: 32,
                        ),
                        onPressed: _onPhotoTake,
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
