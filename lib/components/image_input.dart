import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  //Capturando Imagem
  File? _storedImage;

  _takePicture(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    XFile imageFile = await _picker.pickImage(
      source: source,
      maxWidth: 600,
    ) as XFile;

    if (imageFile == null) return;

    setState(() {
      _storedImage = File(imageFile.path);
    });

    //pegar pasta que posso salvar documentos
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    String fileName = path.basename(_storedImage!.path);
    final savedImage = await _storedImage!.copy(
      '${appDir.path}/$fileName',
    );
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 150,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  'Nenhuma imagem!',
                  style: TextStyle(color: Colors.black),
                ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              icon: Icon(
                Icons.camera_alt,
                color: Colors.black,
              ),
              label: Text(
                'Tirar foto',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                _takePicture(ImageSource.camera);
              },
            ),
            TextButton.icon(
              icon: Icon(
                Icons.image,
                color: Colors.black,
              ),
              label: Text(
                'Selecionar da galeria',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                _takePicture(ImageSource.gallery);
              } /* _selectFromGallery */,
            ),
          ],
        ),
      ],
    );
  }
}
