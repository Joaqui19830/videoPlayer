import 'dart:async';
import 'dart:io';

//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        platform: TargetPlatform.android,
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Media Picker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({Key key, this.title}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File imageFile;
  File videoFile;
  @required
  ImageSource source;
  _camera() async {
    File theImage = await ImagePicker.pickImage(
      source: ImageSource.camera,
    );

    if (theImage != null) {
      setState(() {
        imageFile = theImage;
      });
    }
  }

  _picture() async {
    File theImage = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (theImage != null) {
      setState(() {
        imageFile = theImage;
      });
    }
  }

  _videoPic() async {
    File theVid = await ImagePicker.pickVideo(source: ImageSource.gallery);

    if (theVid != null) {
      setState(() {
        videoFile = theVid;
        print('set');
      });
    }
  }

  _record() async {
    File theVid = await ImagePicker.pickVideo(source: ImageSource.camera);

    if (theVid != null) {
      setState(() {
        videoFile = theVid;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
            child: ListView(children: [
          Column(
            children: [
              SizedBox(
                height: 50.0,
              ),

              //Video
              Container(
                  color: Colors.brown,
                  height: MediaQuery.of(context).size.height * (30 / 100),
                  width: MediaQuery.of(context).size.width * (100 / 100),
                  child: videoFile == null
                      ? Center(
                          child: Icon(
                            Icons.videocam,
                            color: Colors.red,
                            size: 50.0,
                          ),
                        )
                      : FittedBox(
                          fit: BoxFit.contain,
                          child: mounted
                              ? Chewie(
                                  controller: ChewieController(
                                    videoPlayerController:
                                        VideoPlayerController.file(videoFile),
                                    aspectRatio: 3 / 2,
                                    autoPlay: true,
                                    looping: true,
                                  ),
                                )
                              : Container(),
                        )),

              Container(
                  color: Colors.lightGreen,
                  height: MediaQuery.of(context).size.height * (30 / 100),
                  width: MediaQuery.of(context).size.width * (100 / 100),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: imageFile == null
                        ? Center(
                            child: Icon(
                              Icons.photo,
                              color: Colors.blueAccent,
                            ),
                          )
                        : Image.file(imageFile),
                  )),

              RaisedButton(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Camara'),
                      Icon(Icons.camera),
                    ],
                  ),
                  onPressed: () {
                    _camera();
                  }),
              RaisedButton(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Picture'),
                      Icon(Icons.add_a_photo),
                    ],
                  ),
                  onPressed: () {
                    _picture();
                  }),
              RaisedButton(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Video'),
                      Icon(Icons.video_library),
                    ],
                  ),
                  onPressed: () {
                    _videoPic();
                  }),
              RaisedButton(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Record'),
                      Icon(Icons.videocam),
                    ],
                  ),
                  onPressed: () {
                    _record();
                  }),
            ],
          )
        ])));
  }
}
