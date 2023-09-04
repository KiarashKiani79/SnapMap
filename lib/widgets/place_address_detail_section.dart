import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../helpers/location_helper.dart';
import '../models/place.dart';
import '../providers/great_places.dart';
import '../screens/map_screen.dart';

class PlaceAddressDetailSection extends StatelessWidget {
  const PlaceAddressDetailSection({
    super.key,
    required this.bodyHeight,
    required this.bodyWidth,
    required this.selectedPlace,
  });

  final double bodyHeight;
  final double bodyWidth;
  final Place selectedPlace;

  Future<void> _deletePlace(BuildContext context, String placeId) async {
    final response = await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Place'),
        content: const Text('Are you sure you want to delete this place?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop(false); // Cancel
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(ctx).pop(true); // Confirm
              await Provider.of<GreatPlaces>(context, listen: false)
                  .deletePlace(placeId);
            },
            child: Text(
              'Delete',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );

    if (response == true) {
      // The place has been deleted, no need to pop here.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: bodyHeight * 2 / 3,
      width: bodyWidth,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Address: ',
                style: TextStyle(
                    fontSize: 20, color: Theme.of(context).colorScheme.primary),
              ),
              const SizedBox(height: 5),
              Text(
                selectedPlace.location!.address!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(25),
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white10,
                  ),
                  height: bodyHeight / 4,
                  width: bodyWidth,
                  child: Image.network(
                    LocationHelper.generateLocationPreviewImage(
                      latitude: selectedPlace.location!.latitude,
                      longitude: selectedPlace.location!.longitude,
                    ),
                  ),
                ),
              ),
              TextButton.icon(
                icon: const Icon(Icons.fullscreen_exit_rounded),
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (ctx) => MapScreen(
                        initialLocation: selectedPlace.location!,
                        isSelecting: false,
                      ),
                    ),
                  );
                },
                label: const Text('View on Map'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => _deletePlace(context, selectedPlace.id),
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.add_a_photo,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
