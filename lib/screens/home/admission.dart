
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class Admission extends StatefulWidget {
  const Admission({Key key}) : super(key: key);

  @override
  _AdmissionState createState() => _AdmissionState();
}


final List<String> imgList = [
  'https://i.postimg.cc/P50JfnCj/csstaff.jpg',
  'https://i.postimg.cc/TPqcWBD8/ecstaff.jpg',
  'https://i.postimg.cc/FKMQJ9v9/DSC-1333.jpg',
  'https://i.postimg.cc/Hx4TJqX7/Whats-App-Image-2020-12-26-at-6-59-49-PM.jpg',
  'https://i.postimg.cc/Z5ksgC14/Whats-App-Image-2021-06-03-at-2-32-33-PM.jpg',
  'https://i.postimg.cc/yYWzBgQR/images.jpg'
];

class _AdmissionState extends State<Admission> {


  String notification1 = "";
  String notification2 = "";
  final CollectionReference mainReference = Firestore.instance
      .collection('notification');


  Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId('id-1'),
        position: LatLng(13.3004, 77.5232),
        infoWindow: InfoWindow(
            title: 'RL Jalappa Institute of Technology',
            snippet: 'Engineering College'
        ),
      ));
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    mainReference.document("notification").get().then((querySnapshot){

      print("Data"+querySnapshot.data.toString());

      setState(() {
        notification1 = querySnapshot.data['first'];
        notification2 = querySnapshot.data['second'];
        print(notification1+notification2);
      });


    });


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admission')),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  //#B5E0D3 #62CBE7
                  colors: [Color(0xffb5e0d3), Color(0xff62cbe7)])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              notification(),
              SizedBox(
                height: 20,
              ),
              carousal(),
              SizedBox(
                height: 20,
              ),
              maps(),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),

      ),
    );
  }

  notification() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 13),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            notification1,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            notification2,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ],
      ),
    );
  }

  maps() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height/2,
      child: GoogleMap(
        onMapCreated: _onMapCreated,
        markers: _markers,
        initialCameraPosition: CameraPosition(
          target: LatLng(13.3004, 77.5232),
          zoom: 17,
        ),
      ),
    );
  }

  carousal() {
    return Container(
        child: Column(children: <Widget>[
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 2.0,
              enlargeCenterPage: true,
            ),
            items: imageSliders,
          ),
        ],)
    );
  }
}

final List<Widget> imageSliders = imgList.map((item) => Container(
  child: Container(
    margin: EdgeInsets.all(5.0),
    child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(
          children: <Widget>[
            Image.network(item, fit: BoxFit.cover, width: 1000.0),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(200, 0, 0, 0),
                      Color.fromARGB(0, 0, 0, 0)
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),

              ),
            ),
          ],
        )
    ),
  ),
)).toList();
