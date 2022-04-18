import 'package:flutter/material.dart';
import 'package:flutter_coffee_app/helper/static_variable.dart';

typedef FunctionStringCallback = Function(String params);

class CartItem extends StatelessWidget {
  final String url;
  final String name;
  final int price;
  final int qty;
  final int id;
  final TextEditingController? textEditingController;
  final FunctionStringCallback? onAdd;

  const CartItem({
    Key? key,
    this.url = '',
    this.name = 'Menu 1',
    this.price = 0,
    this.qty = 0,
    this.id = 0,
    this.textEditingController,
    this.onAdd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 90,
            width: 90,
            margin: EdgeInsets.only(right: 5),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.grey.withOpacity(0.5),
              ),
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage('$BaseHostImage$url'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          String qtyString = textEditingController?.text ?? '0';
                          int qty = int.parse(qtyString);
                          int currentQty = qty - 1;
                          if (currentQty >= 0) {
                            textEditingController?.text = currentQty.toString();
                            print(textEditingController?.text);
                          }
                        },
                        child: Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                              border:
                                  Border.all(width: 1, color: Colors.brown)),
                          child: Icon(
                            Icons.remove,
                            color: Colors.brown,
                            size: 10,
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        width: 40,
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        child: TextField(
                          controller: textEditingController,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              contentPadding: EdgeInsets.all(1)),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          String qtyString = textEditingController?.text ?? '0';
                          int qty = int.parse(qtyString);
                          int currentQty = qty + 1;
                          textEditingController?.text = currentQty.toString();
                          print(textEditingController?.text);
                        },
                        child: Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.brown),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 10,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        child: Text(
                          "IDR " + price.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.brown,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 25,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                            border: Border.all(width: 1, color: Colors.brown)),
                        child: Center(
                          child: Text(
                            "Hapus",
                            style: TextStyle(color: Colors.brown),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
