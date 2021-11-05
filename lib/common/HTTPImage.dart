import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:posapp/logic/interfaces/IHTTP.dart';

class HTTPImage extends StatefulWidget {
  final String endpoint;
  final Map<String, dynamic>? queryArgs;
  final dynamic body;
  final double? width;
  final double? height;

  HTTPImage(this.endpoint,
      {Key? key, this.queryArgs, this.body, this.width, this.height})
      : super(key: key);

  @override
  HTTPImageState createState() => HTTPImageState();
}

class HTTPImageState extends State<HTTPImage> {
  final http = Injector.appInstance.get<IHTTP>();
  Uint8List? data;
  double? progress;

  void loadImage() async {
    var imgData = await http.getImage(widget.endpoint,
        queryArgs: widget.queryArgs,
        body: widget.body, progress: (newProgress) {
      if (newProgress >= 0.2) {
        setState(() {
          progress = newProgress;
        });
      }
    });
    setState(() {
      data = imgData;
    });
  }

  @override
  void initState() {
    super.initState();
    loadImage();
  }

  @override
  Widget build(BuildContext context) {
    return data == null
        ? Center(
            child: CircularProgressIndicator(
            value: progress,
          ))
        : Image.memory(
            data!,
            width: widget.width,
            height: widget.height,
          );
  }
}
