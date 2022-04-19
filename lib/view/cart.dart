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
  String customer = '';
  int total = 0;

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
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 1,
                              color: Colors.black38.withOpacity(0.5),
                            ),
                          ),
                        ),
                        child: Column(
                          children: cartList.map((e) {
                            int index = cartList.indexOf(e);
                            print(index);
                            return CartItem(
                              id: e["id"] as int,
                              url: e["menu"]["gambar"].toString(),
                              name: e["menu"]["nama"].toString(),
                              price: e["total"] as int,
                              qty: e["qty"] as int,
                              textEditingController:
                                  textEditingController[index],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            height: 60,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Colors.brown,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    "Total Pembelian",
                                    style: TextStyle(
                                      color: Colors.brown,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "IDR " + total.toString(),
                                    style: TextStyle(
                                        color: Colors.brown,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              _showModalCheckout(context);
                            },
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(color: Colors.brown),
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
                        ),
                      ],
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
        total = _tmpSubTotal;
      });
    } else {
      cartList = [];
    }
    print(_data);
  }

  void _checkoutCart(BuildContext rootContext) {
    Map<String, dynamic> _data = {
      "customer": customer,
      "discount": 0,
    };
    
    checkoutCart(_data, (message) {
      Navigator.pushNamedAndRemoveUntil(
        rootContext, "/waiting-order", ModalRoute.withName("/dashboard"));
      print(message);
    }, (message) {
      print(message);
    });
  }

  void _showModalCheckout(BuildContext rootContext) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (builder) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.3,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 5),
                        child: Text(
                          "Atas Nama Pemesan",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 5),
                        child: TextField(
                          onChanged: (text) {
                            setState(() {
                              customer = text;
                            });
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              hintText: "Atas Nama"),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              "Total Pembelian",
                              style: TextStyle(
                                color: Colors.brown,
                              ),
                            ),
                          ),
                          Text(
                            "IDR " + total.toString(),
                            style: TextStyle(
                                color: Colors.brown,
                                fontWeight: FontWeight.bold,
                                fontSize: 24),
                          )
                        ],
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: GestureDetector(
                            onTap: () {
                              _checkoutCart(context);
                            },
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.brown,
                              ),
                              child: Center(
                                child: Text(
                                  "Checkout",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
