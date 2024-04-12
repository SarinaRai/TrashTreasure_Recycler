// import 'package:flutter/material.dart';
// import 'package:leaflet_map/leaflet_map.dart';
// import 'package:location/location.dart'; // Import the correct location package

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Recycler Location Tracker',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MapScreen(),
//     );
//   }
// }

// class MapScreen extends StatefulWidget {
//   @override
//   _MapScreenState createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   LocationData? _currentLocation;
//   Location location = Location();

//   @override
//   void initState() {
//     super.initState();
//     _getLocation();
//   }

//   Future<void> _getLocation() async {
//     try {
//       var currentLocation = await location.getLocation();
//       setState(() {
//         _currentLocation = currentLocation;
//       });
//     } catch (e) {
//       print('Failed to get location: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Recycler Location Tracker'),
//       ),
//       body: _currentLocation != null
//           ? LeafletMap(
//               center: LatLng(
//                 _currentLocation!.latitude!,
//                 _currentLocation!.longitude!,
//               ),
//               markers: [
//                 Marker(
//                   width: 80.0,
//                   height: 80.0,
//                   point: LatLng(
//                     _currentLocation!.latitude!,
//                     _currentLocation!.longitude!,
//                   ),
//                   builder: (ctx) => Container(
//                     child: Icon(
//                       Icons.location_pin,
//                       color: Colors.green,
//                       size: 50.0,
//                     ),
//                   ),
//                 ),
//               ],
//             )
//           : Center(
//               child: CircularProgressIndicator(),
//             ),
//     );
//   }
// }
