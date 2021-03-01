import 'package:camera/camera.dart';
import 'package:facemaskapp/main.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

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
            runModelOnFrame(),
          }
        });
      });
    });
  }

  loadModel ( ) async {
    await Tflite.loadModel(model: 'assets/model.tflite', labels: "assets/labels.txt");
  }

  runModelOnFrame() async {
    if(imgCamera != null){
      var recognitions = await Tflite.runModelOnFrame(
          bytesList: imgCamera.planes.map((plane){
            return plane.bytes;
          }).toList(),
        imageHeight: imgCamera.height,
        imageWidth: imgCamera.width,
        imageMean: 127.5,
        imageStd: 127.5,
        rotation: 90,
        numResults: 1,
        threshold: 0.1,
        asynch: true,
      );
      result = "";
      recognitions.forEach((res) {
        result += res['label'] + "\n";
      });
      setState(() {
        result;
      });
      isWorking = false;
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    Tflite.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initCamera();
    loadModel();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blueAccent,
            title: Padding(
              padding: EdgeInsets.only(top: 40.0),
              child: Center(
                child: Text(
                  result,
                  style: TextStyle(
                    backgroundColor: Colors.black54,
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ),

            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.info, color: Colors.white, size: 30, ),
                padding: const EdgeInsets.only(right: 15),
                onPressed: (){
                  _myModelBottomSheet(context);
                },
              )
            ],

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

  void _myModelBottomSheet(context){
    showModalBottomSheet(context: context, builder: (BuildContext bc){
      return Container(
        height: MediaQuery.of(context).size.height * .60,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text('Authors:'),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.cancel, color: Colors.orange, size: 25,),
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Text(
                    "Kaly Bah",
                    style: TextStyle( fontSize: 30, color: Colors.blueAccent),
                  ),
                ],
              )
            ],
          ),
        )
      );
    });
  }
}
