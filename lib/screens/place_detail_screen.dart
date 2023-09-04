import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:snapp_mapp/models/place.dart';
import '../providers/great_places.dart';

import '../models/custom_appbar.dart';
import '../widgets/place_address_detail_section.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const routeName = '/place-detail';

  const PlaceDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final appBarHeight = AppBar().preferredSize.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final bodyHeight = deviceSize.height - appBarHeight - statusBarHeight;
    final bodyWidth = deviceSize.width;

    final id = ModalRoute.of(context)!.settings.arguments as String;
    final selectedPlace =
        Provider.of<GreatPlaces>(context, listen: false).findById(id);
    return Scaffold(
      appBar: CustomAppBar(
        title: selectedPlace.title,
      ),
      body: Column(
        children: [
          PlaceImageDetailSection(
              bodyHeight: bodyHeight,
              bodyWidth: bodyWidth,
              selectedPlace: selectedPlace),
          PlaceAddressDetailSection(
              bodyHeight: bodyHeight,
              bodyWidth: bodyWidth,
              selectedPlace: selectedPlace),
        ],
      ),
    );
  }
}

class PlaceImageDetailSection extends StatelessWidget {
  const PlaceImageDetailSection({
    super.key,
    required this.bodyHeight,
    required this.bodyWidth,
    required this.selectedPlace,
  });

  final double bodyHeight;
  final double bodyWidth;
  final Place selectedPlace;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: bodyHeight / 3,
      width: bodyWidth,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Image.file(
            selectedPlace.image!,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
