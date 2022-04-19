import 'package:flutter/material.dart';

class TransactionItem extends StatelessWidget {
  final String customer;
  final String noOrder;
  final String status;
  final int total;
  final id;
  const TransactionItem({
    Key? key,
    this.customer = 'Customer',
    this.noOrder = '#000000',
    this.status = 'Menunggu',
    this.total = 0,
    this.id = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.brown,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            customer,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(
            noOrder,
            style: TextStyle(
              color: Colors.black38,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      "IDR " + total.toString(),
                      style: TextStyle(
                          color: Colors.brown,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 80,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.brown),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        status,
                        style: TextStyle(
                          color: Colors.brown,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
