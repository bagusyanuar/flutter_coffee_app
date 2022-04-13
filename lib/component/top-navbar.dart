import 'package:flutter/material.dart';

class TopNavbar extends StatelessWidget {
  final double height;
  final Color backgroundColor;
  final Color color;
  final String username;

  const TopNavbar({
    Key? key,
    this.height = 40,
    this.backgroundColor = Colors.lightBlue,
    this.color = Colors.white,
    this.username = "Waiter",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.height,
      padding: EdgeInsets.only(right: 20, left: 20),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Welcome Back!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(username)
                ],
              ),
            ),
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://blogunik.com/wp-content/uploads/2018/01/Tatjana-Saphira-1.jpg'),
                      fit: BoxFit.cover)),
            )
          ],
        ),
      ),
    );
  }
}
