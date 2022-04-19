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
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ButtonMenu(
                    url: "assets/order.png",
                    name: "Pesanan Baru",
                    redirect: "/order",
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ButtonMenu(
                    url: "assets/waiting-order.png",
                    name: "Pesanan Menunggu",
                    redirect: "/waiting-order",
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ButtonMenu(
                    url: "assets/invoice.png",
                    name: "Pesanan Selesai",
                    redirect: "/finish-order",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
