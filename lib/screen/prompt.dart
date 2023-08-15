import 'package:flutter/material.dart';
import 'package:proj_layout/main.dart';
import 'nextpage.dart';
import 'login.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';


class PromptPage extends StatelessWidget {

 final List<String> imageUrls = [
    'https://firebasestorage.googleapis.com/v0/b/findmyline-c419e.appspot.com/o/banner%2Fmrt.jpg?alt=media&token=2c34b966-4dab-4d1e-9445-df6289b4b56b',
    'https://firebasestorage.googleapis.com/v0/b/findmyline-c419e.appspot.com/o/banner%2Fneline.png?alt=media&token=51691724-d59b-4c7c-b6d2-a366a11af672',
    'https://firebasestorage.googleapis.com/v0/b/findmyline-c419e.appspot.com/o/banner%2Fsbstransit_bus.jpg?alt=media&token=3ec145a8-4215-4106-a9b1-818e6ff5ee3b',
    'https://firebasestorage.googleapis.com/v0/b/findmyline-c419e.appspot.com/o/banner%2Fsbs_long.jpg?alt=media&token=dd87935b-6082-430e-84fd-47099301e8bc',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null, // Remove the app bar only for the PromptPage
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: Text(
                  'FetchMyLine',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
            CarouselSlider(
            items: imageUrls.map((imageUrl) {
              return Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  padding: EdgeInsets.all(8.5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                 child: ClipRRect( // Add ClipRRect to apply border radius
                  borderRadius: BorderRadius.circular(6.0), // Set border radius here
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                ),
              );
            }).toList(),
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 0.98,
              height: 350, 
              
            ),
          ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Flexible(
                  child: Text(
                    'Find your way around Singapore with precise bus timings and MRT routes for easy planning',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to the login page when the button is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white, // Background color
                    onPrimary: Colors.black, // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // Rounded corners
                      side: BorderSide(
                          color: Colors.black, width: 2), // to change border color
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Button padding
                  ),
                  child: Text('Login/Sign Up'),
                ),
              ),
              Container(
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to the guest page when the button is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NextPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white, // Background color
                    onPrimary: Colors.black, // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // Rounded corners
                      side: BorderSide(
                          color: Colors.black, width: 2), // to change border color
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Button padding
                  ),
                  child: Text('Continue as Guest'),
                ),
              ),
            ],
          ),
          
        ],
      ),
    );
  }
}
