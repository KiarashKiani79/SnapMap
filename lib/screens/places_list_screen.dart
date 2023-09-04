import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/custom_appbar.dart';
import '../providers/great_places.dart';
import '../widgets/place_item.dart';
import './add_place_screen.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  // Function to refresh the list of places
  Future<void> _refreshPlaces(BuildContext context) async {
    await Provider.of<GreatPlaces>(context, listen: false).fetchAndSetPlaces();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Memories',
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        // Fetch places when the screen loads
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading spinner while fetching data
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            // Show an error message if an error occurs
            return Center(
              child: Text(
                  'An error occurred while fetching data: ${snapshot.error}'),
            );
          } else {
            final greatPlaces = Provider.of<GreatPlaces>(context);

            if (greatPlaces.items.isEmpty) {
              // Display a message and an "Add" button if there are no places
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Got no places yet, start adding some!'),
                    const SizedBox(height: 20),
                    CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      radius: 30,
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(AddPlaceScreen.routeName);
                        },
                        icon: const Icon(Icons.add),
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              );
            }

            // Use PlaceItem widget to display the list of places
            return RefreshIndicator(
              onRefresh: () => _refreshPlaces(context),
              child: PlaceItem(greatPlaces: greatPlaces),
            );
          }
        },
      ),
    );
  }
}
