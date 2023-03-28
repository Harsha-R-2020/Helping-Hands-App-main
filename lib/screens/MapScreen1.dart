import 'dart:async';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:monkey_app_demo/const/colors.dart';

import 'loginScreen.dart';

class MapData {

  double lat,long;
  MapData({this.lat,this.long});
}

class MapScreen1 extends StatefulWidget {
  const MapScreen1({Key key,this.mapdata}) : super(key: key);
  final MapData mapdata;

  @override
  _MapScreenState1 createState() => _MapScreenState1();
}

class _MapScreenState1 extends State<MapScreen1> {
  Completer<GoogleMapController> _controller = Completer();

// on below line we have specified camera position
  static final CameraPosition _kGoogle = const CameraPosition(
    target: LatLng(11.1271, 78.6569),
    zoom: 7,
  );

// on below line we have created the list of markers
  final List<Marker> _markers = <Marker>[
    // Marker(
    //     // markerId: MarkerId('1'),
    //     // position: LatLng(11.1271, 78.6569),
    //     // infoWindow: InfoWindow(
    //     //   title: 'Donor Position',
    //     // )
    // ),
  ];

// created method for getting user current location
//   Future<Position> getUserCurrentLocation() async {
//     await Geolocator.requestPermission().then((value){
//     }).onError((error, stackTrace) async {
//       await Geolocator.requestPermission();
//       print("ERROR"+error.toString());
//     });
//     return await Geolocator.getCurrentPosition();
//   }

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: AppColor.orange,
        elevation: 0,
        // on below line we have given title of app
        title: Text("View Donor Location",style: TextStyle(
          fontSize: _w / 17,
          color: Colors.black.withOpacity(.7),
          fontWeight: FontWeight.w400,
        ),),
        actions: [
          IconButton(
            tooltip: 'Sign out',
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: Icon(Icons.arrow_forward_ios, color: Colors.black.withOpacity(.7)),
            onPressed: () async {
              HapticFeedback.lightImpact();
              // await FirebaseAuth.instance.signOut();

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
                  },
                ),
              );
            },
          ),
          Text(' '),
        ],
      ),
      body: Container(
        child: SafeArea(
          // on below line creating google maps
          child: GoogleMap(
            // on below line setting camera position
            initialCameraPosition: _kGoogle,
            // on below line we are setting markers on the map
            markers: Set<Marker>.of(_markers),
            // on below line specifying map type.
            mapType: MapType.hybrid,
            // on below line setting user location enabled.
            myLocationEnabled: true,
            // on below line setting compass enabled.
            compassEnabled: true,
            // on below line specifying controller on map complete.
            onMapCreated: (GoogleMapController controller){
              _controller.complete(controller);
            },
          ),
        ),
      ),
      // on pressing floating action button the camera will take to user current location
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async{
            // double lat = , long = ;
            print(widget.mapdata.lat);
            print(widget.mapdata.long);

            // marker added for current users location
            _markers.add(
                Marker(
                  markerId: MarkerId("2"),
                  position: LatLng(widget.mapdata.lat ,widget.mapdata.long ),
                  infoWindow: InfoWindow(
                    title: 'Donor Location',
                  ),
                )
            );

            // specified current users location
            CameraPosition cameraPosition = new CameraPosition(
              target: LatLng(widget.mapdata.lat , widget.mapdata.long),
              zoom: 17,
            );

            final GoogleMapController controller = await _controller.future;
            controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
            setState(() {
            });

        },
        label: Text('Mark Location'),
        icon: Icon(Icons.location_on_outlined),

      ),
    );
  }
}
