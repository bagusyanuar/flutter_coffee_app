import 'package:flutter/material.dart';
import 'package:flutter_coffee_app/component/cart-item.dart';
import 'package:flutter_coffee_app/controller/cart.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  List<dynamic> cartList = [];
  List<TextEditingController> textEditingController = [];
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    _getAvailableCart();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    textEditingController.asMap().forEach((index, element) {
      element.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 70,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.black54, width: 1),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: Container(
                      height: 50,
                      width: 50,
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.brown,
                        size: 24,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Keranjang Pembelian",
                      style: TextStyle(
                          color: Colors.brown,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                height: double.infinity,
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: cartList.map((e) {
                        int index = cartList.indexOf(e);
                        print(index);
                        return CartItem(
                          id: e["id"] as int,
                          url: e["menu"]["gambar"].toString(),
                          name: e["menu"]["nama"].toString(),
                          price: e["total"] as int,
                          qty: e["qty"] as int,
                          textEditingController: textEditingController[index],
                        );
                      }).toList(),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.brown),
                        child: Center(
                          child: Text(
                            "Checkout",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _getAvailableCart() async {
    List<dynamic> _data = await listAvailableCart();
    int _cartCount = _data.length;
    if (_cartCount > 0) {
      int _tmpSubTotal = 0;
      _data.forEach((element) {
        _tmpSubTotal += element["total"] as int;
        TextEditingController _tmpController = TextEditingController()
          ..text = element["qty"].toString();
        textEditingController.add(_tmpController);
      });
      setState(() {
        cartList = _data;
      });
    } else {
      cartList = [];
    }
    print(_data);
  }
}
