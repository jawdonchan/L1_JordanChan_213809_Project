import 'package:flutter/material.dart';
import 'package:proj_layout/services/user_card_service.dart';

class AddValuePage extends StatefulWidget {
  final String userEmail;
  AddValuePage({this.userEmail});

  @override
  _AddValuePageState createState() => _AddValuePageState();
}

class _AddValuePageState extends State<AddValuePage> {
  TextEditingController _valueController = TextEditingController();
  double _currentCardValue = 0.0;

  @override
  void initState() {
    super.initState();
    _loadCurrentCardValue();
  }

  Future<void> _loadCurrentCardValue() async {
    double value = await UserCardService().getCurrentCardValue(widget.userEmail);
    setState(() {
      _currentCardValue = value;
    });
  }

  void _addValueToCard() {
    double valueToAdd = double.tryParse(_valueController.text) ?? 0.0;
    print("Value to add: $valueToAdd");
    if (valueToAdd > 0) {
      // Use UserCardService to add value to the card
      UserCardService().addValueToCard(widget.userEmail, valueToAdd);

      // Update the current card value after adding value
      _loadCurrentCardValue();

      // Clear the value controller
      _valueController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Add Value to Card',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              // Align(
              //   alignment: Alignment.centerLeft,
              //   child: Text(
              //     'Current Card Value: $_currentCardValue', // Display current card value here
              //     style: TextStyle(fontSize: 18),
              //   ),
              // ),
              // SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Value to Add',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _valueController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    hintText: 'Enter value to add',
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: _addValueToCard,
                child: Text('Add Value'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.black,
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 10.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
