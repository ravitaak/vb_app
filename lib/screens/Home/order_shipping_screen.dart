import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vb_app/bloc/vb/vidya_box_cubit.dart';

import '../../routes/index.gr.dart';

class OrderShippingScreen extends StatefulWidget {

  final String message;
  final int userId;
  final String paymentId;

  const OrderShippingScreen({super.key, required this.userId, required this.message,required this.paymentId,});

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
        backgroundColor: Theme.of(context).cardColor,
      ),
      body: ShippingAddressForm(userId: widget.userId,message: widget.message,paymentId: widget.paymentId,),
    );
  }
}

class ShippingAddressForm extends StatefulWidget {
  final int userId;
  final String message;
  final String paymentId;

  const ShippingAddressForm({super.key, required this.userId, required this.message, required this.paymentId});


  @override
  _ShippingAddressFormState createState() => _ShippingAddressFormState();
}

class _ShippingAddressFormState extends State<ShippingAddressForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _streetAddressController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _zipCodeController = TextEditingController();
  TextEditingController _referralCodeController = TextEditingController();
  TextEditingController _schoolNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
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
                decoration:
                InputDecoration(labelText: 'Referral Code (Optional)'),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _schoolNameController,
                decoration:
                InputDecoration(labelText: 'School Name (Optional)'),
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _submitForm();
                    // go to thank you page...
                    AutoRouter.of(context).push(ThankYouPageRoute());
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _submitForm() async{
    String username = _usernameController.text;
    String streetAddress = _streetAddressController.text;
    String city = _cityController.text;
    String state = _stateController.text;
    String zipCode = _zipCodeController.text;
    String referralCode = _referralCodeController.text;
    String schoolName = _schoolNameController.text;


    var data = {
      "userId": widget.userId,
      "street_address": streetAddress,
      "city": city,
      "state": state,
      "referral_code": referralCode,
      "school_name": schoolName,
      "zip_code": zipCode,
      "payment_id": widget.paymentId,
      "message": widget.message,
    };

    var res = await context.read<VidyaBoxCubit>().orderShippingAddress(data);

    print(res);

    _usernameController.clear();
    _streetAddressController.clear();
    _cityController.clear();
    _stateController.clear();
    _zipCodeController.clear();
    _referralCodeController.clear();
    _schoolNameController.clear();
  }
}