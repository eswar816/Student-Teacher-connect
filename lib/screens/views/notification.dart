import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class ViewNotification extends StatefulWidget {
  const ViewNotification({Key key}) : super(key: key);

  @override
  ViewNotificationState createState() => ViewNotificationState();
}


class ViewNotificationState extends State<ViewNotification> {


  String notification1 = "";
  String notification2 = "";
  String notification3 = "";
  String notification4 = "";
  final CollectionReference mainReference = Firestore.instance
      .collection('notification');


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    mainReference.document("notification").get().then((querySnapshot) {
      print("Data" + querySnapshot.data.toString());

      setState(() {
        notification1 = querySnapshot.data['first'];
        notification2 = querySnapshot.data['second'];
        notification3 = querySnapshot.data['third'];
       //notification4 = querySnapshot.data['fourth'];
        print(notification1 + notification2 + notification3 + notification4);

      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Student')),
      //body: SingleChildScrollView(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery
              .of(context)
              .size
              .height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 80,
              ),
              notification(),
            ],
          ),
        ),

      ),
    );
  }


  notification() {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
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
          SizedBox(
            height: 20,
          ),
          Text(
            notification3,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            notification4,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ],
      ),
    );
  }

}
