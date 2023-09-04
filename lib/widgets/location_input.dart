import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../helpers/location_helper.dart';
import '../screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;

  const LocationInput(this.onSelectPlace, {super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;
  bool _isUploading = false;

  void _showPreview(double lat, double lng) {
    try {
      final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
        latitude: lat,
        longitude: lng,
      );
      setState(() {
        _previewImageUrl = staticMapImageUrl;
      });
    } catch (error) {
      setState(() {
        _previewImageUrl = "Location not found! Try again.";
      });
      print("Error loading map image: $error");
    }
  }

  Future<void> _getCurrentUserLocation() async {
    setState(() {
      _isUploading = true;
    });

    try {
      final locData = await Location().getLocation();
      if (locData == null) {
        // Handle the case where location data is not available.
        setState(() {
          _isUploading = false;
        });
        return;
      }

      _showPreview(locData.latitude!, locData.longitude!);
      widget.onSelectPlace(locData.latitude!, locData.longitude!);
    } catch (error) {
      // Handle errors gracefully, e.g., show an error message to the user.
      print('Error getting location: $error');
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => const MapScreen(
          isSelecting: true,
        ),
      ),
    );
    if (selectedLocation == null) {
      return;
    }
    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            color: Colors.white10,
            height: 170,
            width: double.infinity,
            alignment: Alignment.center,
            child: _isUploading
                ? const CircularProgressIndicator()
                : (_previewImageUrl == null
                    ? const Text(
                        "No Location Chosen",
                        textAlign: TextAlign.center,
                      )
                    : Image.network(
                        _previewImageUrl!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      )),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: _isUploading ? null : _getCurrentUserLocation,
              icon: const Icon(Icons.location_on),
              label: const Text('Current Location'),
            ),
            TextButton.icon(
              onPressed: _isUploading ? null : _selectOnMap,
              icon: const Icon(Icons.map),
              label: const Text('Select on Map'),
            ),
          ],
        )
      ],
    );
  }
}
