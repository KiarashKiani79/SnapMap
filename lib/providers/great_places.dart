import 'dart:io';
import 'package:flutter/material.dart';
import '../models/place.dart';
import '../helpers/db_helper.dart';
import '../helpers/location_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<Place>? _items = [];

  List<Place> get items {
    return [..._items!];
  }

  Place findById(String id) {
    return _items!.firstWhere((place) => place.id == id);
  }

  // Future<void> addPlace(
  //   String pickedTitle,
  //   File pickedImage,
  //   PlaceLocation? pickedLocation,
  // ) async {
  //   final address = await LocationHelper.getPlaceAddress(
  //     latitude: pickedLocation!.latitude,
  //     longitude: pickedLocation.longitude,
  //   );
  //   final updatedLocation = PlaceLocation(
  //     latitude: pickedLocation.latitude,
  //     longitude: pickedLocation.longitude,
  //     address: address,
  //   );
  //   final newPlace = Place(
  //     id: DateTime.now().toString(),
  //     title: pickedTitle,
  //     image: pickedImage,
  //     location: updatedLocation,
  //   );

  //   _items.add(newPlace);
  //   notifyListeners();
  //   DBHelper.insert('user_places', {
  //     'id': newPlace.id,
  //     'title': newPlace.title,
  //     'image': newPlace.image!.path,
  //     'loc_lat': newPlace.location!.latitude,
  //     'loc_lng': newPlace.location!.longitude,
  //     'address': newPlace.location!.address as String,
  //   });
  // }
  Future<void> addPlace(
    String pickedTitle,
    File? pickedImage,
    PlaceLocation? pickedLocation,
  ) async {
    if (pickedImage == null || pickedLocation == null) {
      // Handle the case where either image or location is null.
      return;
    }

    final address = await LocationHelper.getPlaceAddress(
      latitude: pickedLocation.latitude,
      longitude: pickedLocation.longitude,
    );
    final updatedLocation = PlaceLocation(
      latitude: pickedLocation.latitude,
      longitude: pickedLocation.longitude,
      address: address,
    );
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: pickedTitle,
      image: pickedImage,
      location: updatedLocation,
    );

    _items!.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image!.path,
      'loc_lat': newPlace.location!.latitude,
      'loc_lng': newPlace.location!.longitude,
      'address': newPlace.location!.address as String,
    });
  }

  // Future<void> deletePlace(String id) async {
  //   final existingPlaceIndex = _items.indexWhere((place) => place.id == id);
  //   if (existingPlaceIndex >= 0) {
  //     final existingPlace = _items[existingPlaceIndex];
  //     _items.removeAt(existingPlaceIndex);
  //     notifyListeners();

  //     try {
  //       // Delete from SQLite database
  //       await DBHelper.delete('user_places', id);

  //       // If you want to delete the image file from storage as well, you can do so here
  //       final imageFile = existingPlace.image;
  //       if (imageFile != null && imageFile.existsSync()) {
  //         await imageFile.delete();
  //       }
  //     } catch (error) {
  //       // Handle any errors that might occur during database or file operations
  //       print('Error deleting place: $error');
  //     }
  //   }
  // }

  Future<void> deletePlace(String id) async {
    final existingPlaceIndex = _items!.indexWhere((place) => place.id == id);
    if (existingPlaceIndex >= 0) {
      final existingPlace = _items?[existingPlaceIndex];
      _items?.removeAt(existingPlaceIndex);
      notifyListeners();

      try {
        // Delete from SQLite database
        await DBHelper.delete('user_places', id);

        // If you want to delete the image file from storage as well, you can do so here
        final imageFile = existingPlace?.image;
        if (imageFile != null && imageFile.existsSync()) {
          await imageFile.delete();
        }
      } catch (error) {
        // Handle any errors that might occur during database or file operations
        print('Error deleting place: $error');
      }
    }
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map(
          (item) => Place(
            id: item['id'],
            title: item['title'],
            image: File(
              item['image'],
            ),
            location: PlaceLocation(
              latitude: item['loc_lat'],
              longitude: item['loc_lng'],
              address: item['address'],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }
}
