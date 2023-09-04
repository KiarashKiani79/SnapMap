# SnapMap

SnapMap is a Flutter project that allows users to take pictures, upload images from the gallery, and select and view locations on a map. It includes features such as image capture, image upload, current location retrieval, map selection, and more.

## Screenshots
For a full list of screenshots, refer to the **[ScreenShot](https://github.com/KiarashKiani79/SnapMap/tree/main/ScreenShots)** folder.

<div align="center">
    <img src="https://github.com/KiarashKiani79/SnapMap/blob/main/ScreenShots/home.jpg" width="200"/>
    <img src="https://github.com/KiarashKiani79/SnapMap/blob/main/ScreenShots/selectOnMap.jpg" width="200"/>
  <img src="https://github.com/KiarashKiani79/SnapMap/blob/main/ScreenShots/viewOnMap.jpg" width="200"/>
    <img src="https://github.com/KiarashKiani79/SnapMap/blob/main/ScreenShots/addComplete.jpg" width="200"/>
    <img src="https://github.com/KiarashKiani79/SnapMap/blob/main/ScreenShots/detail1.jpg" width="200"/>
  <img src="https://github.com/KiarashKiani79/SnapMap/blob/main/ScreenShots/adderror.jpg" width="200"/>
  <img src="https://github.com/KiarashKiani79/SnapMap/blob/main/ScreenShots/detail2.jpg" width="200"/>
    <img src="https://github.com/KiarashKiani79/SnapMap/blob/main/ScreenShots/add.jpg" width="200"/>
    <img src="https://github.com/KiarashKiani79/SnapMap/blob/main/ScreenShots/deletePlace.jpg" width="200"/>
</div>

## Features

### ImageInput

- **Take Picture:** Allows users to capture an image using the device's camera.
- **Browse Gallery:** Enables users to select an image from their device's gallery.
- Displays the selected image or a placeholder if no image is chosen.
- Shows a loading indicator when processing images.

### LocationInput

- **Current Location:** Retrieves the user's current location and displays it on the map as a preview.
- **Select on Map:** Opens a map screen for users to select a location by tapping on the map.
- Displays a loading indicator when fetching the current location.
- Shows the selected location on the map or a placeholder if no location is chosen.

### PlaceAddressDetailSection

- Displays the selected place's address and a preview image.
- Provides options to delete the place and add a photo.
- Allows users to view the selected place on the map.

### AddPlaceScreen

- Allows users to add a new place.
- Includes a form for entering a place title.
- Utilizes `ImageInput` and `LocationInput` widgets for image and location selection.
- Validates that both image and location are selected before adding a place.
- Shows an alert dialog if image or location is missing.

### DBHelper

- Manages the SQLite database for storing place data.
- Includes methods for inserting, deleting, and retrieving data from the database.

### LocationHelper

- Provides helper functions for working with location data.
- Generates a static map image based on latitude and longitude.
- Retrieves the address of a location based on latitude and longitude using the Google Maps Geocoding API.

### MapScreen

- Displays a Google Map with options to select a location.
- Allows users to search for places using the Google Places Autocomplete API.
- Handles location selection and passes the selected location back to the calling screen.

## Usage

To use SnapMap in your Flutter project, follow these steps:

1. Clone the SnapMap project repository.
2. Add the necessary dependencies to your `pubspec.yaml` file.
3. Include the relevant widgets (`ImageInput`, `LocationInput`, `PlaceAddressDetailSection`, `AddPlaceScreen`, etc.) in your project as needed.
4. Customize the project to fit your specific requirements and UI design.
5. Ensure you have the required API keys, such as the Google Maps API key, set up in your project.

## Dependencies

SnapMap uses several Flutter packages to implement its features:

- `image_picker`: For capturing and selecting images.
- `google_maps_flutter`: For displaying maps and handling location selection.
- `location`: For retrieving the device's current location.
- `provider`: For state management.

Make sure to include these dependencies in your project's `pubspec.yaml` file.
