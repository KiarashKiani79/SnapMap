import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  const ImageInput(this.onSelectImage, {super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;
  bool _isLoading = false;

  Future<void> _takePicture() async {
    await _getImage(ImageSource.camera);
  }

  Future<void> _uploadPicture() async {
    await _getImage(ImageSource.gallery);
  }

  Future<void> _getImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(
      source: source,
      maxWidth: 600,
    );

    if (pickedImage == null) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(pickedImage.path);
    final savedImage = File(pickedImage.path);
    final newSavedImage = await savedImage.copy('${appDir.path}/$fileName');

    setState(() {
      _isLoading = false;
      _storedImage = newSavedImage;
    });

    widget.onSelectImage(newSavedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            width: 150,
            height: 100,
            color: Colors.white10,
            alignment: Alignment.center,
            child: Stack(
              children: [
                if (_storedImage != null)
                  Image.file(
                    _storedImage!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  )
                else
                  const Text(
                    'No Image Taken',
                    textAlign: TextAlign.center,
                  ),
                if (_isLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              OutlinedButton.icon(
                onPressed: _isLoading ? null : _takePicture,
                icon: const Icon(Icons.camera),
                label: const Text('Take Picture'),
              ),
              OutlinedButton.icon(
                onPressed: _isLoading ? null : _uploadPicture,
                icon: const Icon(Icons.add_photo_alternate_rounded),
                label: const Text('Browse Gallery'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
