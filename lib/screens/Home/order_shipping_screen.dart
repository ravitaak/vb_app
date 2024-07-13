import 'package:flutter/material.dart';

class OrderShippingScreen extends StatefulWidget {
  const OrderShippingScreen({super.key});

  @override
  State<OrderShippingScreen> createState() => _OrderShippingScreenState();
}

class _OrderShippingScreenState extends State<OrderShippingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        title: Text("Shipping Address"),
        centerTitle: true,
        backgroundColor:  Theme.of(context).cardColor,
      ),
      body: ShippingAddressForm(),
    );
  }
}

class ShippingAddressForm extends StatefulWidget {
  @override
  _ShippingAddressFormState createState() => _ShippingAddressFormState();
}

class _ShippingAddressFormState extends State<ShippingAddressForm> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _streetAddressController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _zipCodeController = TextEditingController();
  TextEditingController _referralCodeController = TextEditingController();
  TextEditingController _schoolNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'User Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _streetAddressController,
                decoration: InputDecoration(labelText: 'Street Address'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your street address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _cityController,
                decoration: InputDecoration(labelText: 'City'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your city';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _stateController,
                decoration: InputDecoration(labelText: 'State'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your state';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _zipCodeController,
                decoration: InputDecoration(labelText: 'Zip Code'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your zip code';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _referralCodeController,
                decoration: InputDecoration(labelText: 'Referral Code (Optional)'),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _schoolNameController,
                decoration: InputDecoration(labelText: 'School Name (Optional)'),
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  _submitForm();

                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
    );
  }

  void _submitForm() {

    String username = _usernameController.text;
    String streetAddress = _streetAddressController.text;
    String city = _cityController.text;
    String state = _stateController.text;
    String zipCode = _zipCodeController.text;
    String referralCode = _referralCodeController.text;
    String schoolName = _schoolNameController.text;

    print('Username: $username');
    print('Street Address: $streetAddress');
    print('City: $city');
    print('State: $state');
    print('Zip Code: $zipCode');
    print('Referral Code: $referralCode');
    print('School Name: $schoolName');

    _usernameController.clear();
    _streetAddressController.clear();
    _cityController.clear();
    _stateController.clear();
    _zipCodeController.clear();
    _referralCodeController.clear();
    _schoolNameController.clear();
  }
}