import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:proj_layout/bus/BusStopSearch.dart';
import 'user_favourite_bus.dart';
import 'package:proj_layout/busStops/fav_busstop.dart';

class FavouritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
       appBar: AppBar(
        toolbarHeight:50,
            automaticallyImplyLeading: false,
            // title: Text('Favorite Bus Services'),
            bottom: TabBar(
              tabs: [
                Tab(text: 'Favorites'), // First tab
                Tab(text: 'Bus Stop'), // Second tab
              ],
            ),
          ),
        body: 
        TabBarView(
          children: [
            // First tab's content
            FavouriteServicesTab(),
            // Second tab's content
            BusSearch(), // Empty tab
          ],
        ),
      ),
    );
  }
}

class BlankTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('This is a blank tab'),
    );
  }
}
