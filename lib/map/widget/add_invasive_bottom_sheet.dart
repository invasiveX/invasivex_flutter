import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddInvasiveBottomSheet extends StatefulWidget {
  final double lat;
  final double lon;

  const AddInvasiveBottomSheet({super.key, required this.lat, required this.lon});

  @override
  State<AddInvasiveBottomSheet> createState() => _AddInvasiveBottomSheetState();
}

class _AddInvasiveBottomSheetState extends State<AddInvasiveBottomSheet> {
  XFile? _photo;
  
  @override
  Widget build(BuildContext context) {
    List<Widget> imageWidgets = [];
    if(_photo != null){
      imageWidgets.add(Image.file(File(_photo!.path), width: 128, height: 128,));
      debugPrintSynchronously("_photo got, added widget!");
    }
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  style: TextStyle(fontSize: 28),
                  decoration: InputDecoration(labelText: "Invasive Species Name"),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              onPressed: () async {
                final ImagePicker _picker = ImagePicker();
                var photo = await _picker.pickImage(source: ImageSource.camera);
                setState((){
                 _photo = photo;
                });
              },
              icon: Icon(Icons.add_a_photo),
              iconSize: 48,
              color: Colors.orange,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  expands: false,
                  decoration: InputDecoration(labelText: "Notes:"),
                ),
              ),
            ),
          ],
        ),

      ] + imageWidgets,
    );
  }
}
