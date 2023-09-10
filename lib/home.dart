import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var marker = HashSet<Marker>();
  BitmapDescriptor? customMarker;
  getimagecustom() async {
    customMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, 'assets/images/google_maps_image.jpg');
  }

  Set<Polygon> myPolygon() {
    List<LatLng>? polygonCoords;
    polygonCoords!.add(LatLng(37.43296265331129, -122.08832357078792));
    polygonCoords.add(LatLng(37.43006265331129, -122.08832357078792));
    polygonCoords.add(LatLng(37.43006265331129, -122.08332357078792));
    polygonCoords.add(LatLng(37.43296265331129, -122.08832357078792));

    Set<Polygon> polygonSet = new Set();
    polygonSet.add(Polygon(
        polygonId: PolygonId('test'),
        points: polygonCoords,
        strokeColor: Colors.red));

    return polygonSet;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getimagecustom();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter google map'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition:
                CameraPosition(target: LatLng(34.746667, 38.546667), zoom: 14),
            onMapCreated: (GoogleMapController googlemapcontroller) {
              setState(() {
                marker.add(Marker(
                    markerId: MarkerId('1'),
                    position: LatLng(34.746667, 38.546667),
                    infoWindow: InfoWindow(
                        title: 'location', snippet: 'this is nice place'),
                    onTap: () {
                      print('marker');
                    },
                    icon: customMarker!));
              });
            },
            markers: marker,
            polygons: myPolygon(),
          ),
          Container(
            child: Image.asset(
              "assets/images/google_maps_image.jpg",
              height: 50,
              width: double.infinity,
              alignment: Alignment.topRight,
            ),
          )
        ],
      ),
    );
  }
}
