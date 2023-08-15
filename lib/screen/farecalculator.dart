import 'package:flutter/material.dart';

class FareCalculatorPage extends StatefulWidget {
  @override
  _FareCalculatorPageState createState() => _FareCalculatorPageState();
}

class _FareCalculatorPageState extends State<FareCalculatorPage> {
  double distance = 0.0;
  double fare = 0.0;
  String selectedPassengerType = 'Adult';

  Map<String, double> passengerFares = {
    'Student': 0.63,
    'Senior Citizen': 0.92,
    'Adult': 1.76,
  };

  void calculateFare() {
    setState(() {
      fare = passengerFares[selectedPassengerType] + (distance * 0.1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fare Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Calculate Your Fare',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: selectedPassengerType,
              onChanged: (String newValue) {
                setState(() {
                  selectedPassengerType = newValue;
                });
              },
              items: passengerFares.keys.map<DropdownMenuItem<String>>(
                (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                },
              ).toList(),
            ),
            SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Distance (in kilometers)',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  distance = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateFare,
              child: Text('Calculate Fare'),
            ),
            SizedBox(height: 20),
            Text(
              'Estimated Fare: \$${fare.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}



