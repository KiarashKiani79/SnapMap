import 'package:flutter/material.dart';

import '../providers/great_places.dart';
import '../screens/place_detail_screen.dart';

class PlaceItem extends StatelessWidget {
  const PlaceItem({
    super.key,
    required this.greatPlaces,
  });

  final GreatPlaces greatPlaces;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
      ),
      itemCount: greatPlaces.items.length,
      itemBuilder: (ctx, i) {
        final place = greatPlaces.items[i];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                PlaceDetailScreen.routeName,
                arguments: place.id,
              );
            },
            child: Column(
              children: [
                Hero(
                  tag: place.id,
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2 - 50,
                    height: MediaQuery.of(context).size.width / 2 - 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(place.image!),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(place.title),
              ],
            ),
          ),
        );
      },
    );
  }
}
