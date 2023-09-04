import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/image_input.dart';
import '../providers/great_places.dart';
import '../models/place.dart';
import '../widgets/location_input.dart';
import '../models/custom_appbar.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({super.key});
  static const routeName = '/add-place';

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _form = GlobalKey<FormState>();

  String? _newTitle;
  File? _newImage;
  PlaceLocation? _newLocation;

  void _selectImage(File pickedImage) {
    _newImage = pickedImage;
  }

  void _selectPlace(double lat, double lng) {
    _newLocation = PlaceLocation(latitude: lat, longitude: lng);
  }

  void _savePlace() {
    final isValid = _form.currentState?.validate();
    if (!isValid! || _newImage == null || _newLocation == null) {
      _addPlaceAlertDialog();
      return;
    }

    _form.currentState?.save();

    Provider.of<GreatPlaces>(context, listen: false).addPlace(
      _newTitle!,
      _newImage!,
      _newLocation!,
    );
    Navigator.of(context).pop();
  }

  Future<dynamic> _addPlaceAlertDialog() {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Missing Items'),
        content: RichText(
          text: TextSpan(
            text: 'Please select both ',
            children: [
              TextSpan(
                text: 'location',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
              const TextSpan(text: ' and '),
              TextSpan(
                text: 'image',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
              const TextSpan(text: ' for the place.'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Add a New Place',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Form(
                      key: _form,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Place Title',
                              prefixIcon: Icon(Icons.location_on_outlined),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                            ),
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Fill in the title';
                              }
                              return null;
                            },
                            onSaved: (newTitle) {
                              _newTitle = newTitle;
                            },
                          ),
                          const SizedBox(height: 30),
                          ImageInput(_selectImage),
                          const SizedBox(height: 30),
                          LocationInput(_selectPlace),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: _savePlace,
            icon: const Icon(Icons.add),
            label: const Text('Add Place'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }
}
