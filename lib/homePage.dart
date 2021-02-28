import 'package:camera/camera.dart';
import 'package:facemaskapp/main.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  CameraImage imgCamera;
  CameraController cameraController;
  bool isWorking = false;
  String result = '';


  initCamera(){
    cameraController = CameraController(cameras[0], ResolutionPreset.medium);

    cameraController.initialize().then((value) {
      if(!mounted){
        return;
      }
      setState((){
        cameraController.startImageStream((imageFromStream) => {
          if(!isWorking){
            isWorking = true,
            imgCamera = imageFromStream,
          }
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Padding(
              padding: EdgeInsets.only(top: 40.0),
              child: Center(
                child: Text(" "),
              ),

            ),
          ),
          body: Column(
            children: [Positioned(
              top: 0,
              left: 0,
              width: size.width,
              height: size.height - 100,
              child: Container(
                height: size.height -100,
                child: (!cameraController.value.isInitialized)
                    ?  Container()
                    : AspectRatio(
                      aspectRatio: cameraController.value.aspectRatio,
                      child: CameraPreview(cameraController),
                ),
              ),
            )],
          ),
        ),
      ),
    );
  }
}
