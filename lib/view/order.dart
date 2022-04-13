import 'package:flutter/material.dart';
import 'package:flutter_coffee_app/component/top-navbar.dart';

class OrderView extends StatefulWidget {
  const OrderView({Key? key}) : super(key: key);

  @override
  _OrderViewState createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopNavbar(
            height: 70,
            backgroundColor: Colors.white,
            color: Colors.black,
          ),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }
}
