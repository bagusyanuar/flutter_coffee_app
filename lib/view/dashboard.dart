import 'package:flutter/material.dart';
import 'package:flutter_coffee_app/component/button-menu.dart';
import 'package:flutter_coffee_app/component/top-navbar.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ButtonMenu(
                  url: "assets/order.png",
                  name: "Pesanan Baru",
                  redirect: "/order",
                ),
                SizedBox(
                  width: 20,
                ),
                ButtonMenu(
                  url: "assets/invoice.png",
                  name: "Tagihan",
                  redirect: "/transaction",
                ),
              ],
            )),
          ),
        ],
      ),
    );
  }
}
