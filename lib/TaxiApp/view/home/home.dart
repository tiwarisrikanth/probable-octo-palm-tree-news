import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Icon(Icons.wb_sunny, color: Colors.orange),
            SizedBox(width: 5),
            Text(
              '24° C',
              style: TextStyle(color: Colors.black87),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black87),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Get SafeTrip+ activated for \$1\nUp to \$5 vouchers for pickup delays.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.blue.shade900,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.search, color: Colors.grey),
                      border: InputBorder.none,
                      hintText: 'Find services, food, or places...',
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buildIcon(Icons.pedal_bike, 'Bike'),
                    buildIcon(Icons.directions_car, 'Car'),
                    buildIcon(Icons.fastfood, 'Food'),
                    buildIcon(Icons.send, 'Send'),
                    buildIcon(Icons.more_horiz, 'More'),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              children: [
                Container(
                  height: 200,
                  child: FlutterMap(
                    options: MapOptions(
                      center: LatLng(40.7128, -74.0060),
                      zoom: 13.0,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                        subdomains: ['a', 'b', 'c'],
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            width: 80.0,
                            height: 80.0,
                            point: LatLng(40.7128, -74.0060),
                            builder: (ctx) => Container(
                              child: Icon(Icons.location_pin,
                                  color: Colors.red, size: 40),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Ready to book this order?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Your Last Update at 15:53',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 20),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue.shade50,
                    child: Icon(Icons.pedal_bike, color: Colors.blue),
                    radius: 25,
                  ),
                  title: Text('Ren Bike',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('New Service\n3 - 5 mins   •   1'),
                  trailing: Text('\$10.99',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Container(
                  color: Colors.grey[300],
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Rara\'s apartment',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('568 Winding Way Northvale, NJ 07647'),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Ren Bike Now  \$10.99'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.access_time), label: 'Activity'),
          BottomNavigationBarItem(icon: Icon(Icons.payment), label: 'Payment'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: 'Account'),
        ],
      ),
    );
  }

  Widget buildIcon(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.blue.shade50,
          child: Icon(icon, color: Colors.blue),
          radius: 20,
        ),
        SizedBox(height: 5),
        Text(label, style: TextStyle(color: Colors.blue)),
      ],
    );
  }
}
