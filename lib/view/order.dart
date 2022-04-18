import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_coffee_app/component/card-menu.dart';
import 'package:flutter_coffee_app/component/detail-order.dart';
import 'package:flutter_coffee_app/component/page-loading.dart';
import 'package:flutter_coffee_app/component/top-navbar.dart';
import 'package:flutter_coffee_app/controller/cart.dart';
import 'package:flutter_coffee_app/controller/categories.dart';
import 'package:flutter_coffee_app/controller/menu.dart';

class OrderView extends StatefulWidget {
  const OrderView({Key? key}) : super(key: key);

  @override
  _OrderViewState createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  bool isLoading = true;
  bool isLoadingMenu = false;
  bool isCartAvailable = false;
  List<Map<String, dynamic>> _tabList = [];
  List<Map<String, dynamic>> _menuList = [];
  int qty = 0;
  int subTotal = 0;
  TextEditingController _textEditingController = TextEditingController()
    ..text = '0';
  TextEditingController _textAdditionController = TextEditingController()
    ..text = '';
  String addition = '';
  @override
  void initState() {
    // TODO: implement initState
    _getCategories();
    _getAvailableCart();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (_tabController != null) {
      _tabController?.dispose();
    }
    _textEditingController.dispose();
    _textAdditionController.dispose();
    super.dispose();
  }

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
          isLoading
              ? Expanded(child: PageLoading())
              : Expanded(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          TabBar(
                            unselectedLabelColor: Colors.black,
                            labelColor: Colors.red,
                            controller: _tabController,
                            indicatorSize: TabBarIndicatorSize.tab,
                            isScrollable: true,
                            tabs: _tabList.length <= 0
                                ? []
                                : _tabList
                                    .map((e) => Tab(
                                          text: e["name"].toString(),
                                        ))
                                    .toList(),
                          ),
                          isLoadingMenu
                              ? Expanded(
                                  child: PageLoading(
                                  text: "Mengambil Data Menu...",
                                ))
                              : Expanded(
                                  child: RefreshIndicator(
                                    onRefresh: () {
                                      return refresh();
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: double.infinity,
                                      padding: EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 10,
                                        bottom: isCartAvailable ? 130 : 10,
                                      ),
                                      child: LayoutBuilder(
                                        builder: (context, constraints) =>
                                            SingleChildScrollView(
                                          physics:
                                              AlwaysScrollableScrollPhysics(),
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: _menuList
                                                  .map((e) => CardMenu(
                                                        name: e["name"],
                                                        price: e["price"],
                                                        url: e["url"],
                                                        description:
                                                            e["description"],
                                                        callback: () {
                                                          int id = e["id"];
                                                          print("pressed" +
                                                              id.toString());
                                                          _showModalMenu(id);
                                                        },
                                                      ))
                                                  .toList()),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                        ],
                      ),
                      isCartAvailable
                          ? GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, "/cart");
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),
                                    height: 100,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.brown),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 90,
                                          width: 90,
                                          margin: EdgeInsets.only(right: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.white54,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                              image:
                                                  AssetImage("assets/logo.png"),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Sub Total Pembelian :",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "IDR " + subTotal.toString(),
                                                style: TextStyle(
                                                    color: Colors.orange,
                                                    fontSize: 24,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  void _getCategories() async {
    List<dynamic> _list = await listCategories();

    _tabList.clear();
    _list.forEach((value) {
      String name = value["nama"] as String;
      int id = value["id"] as int;
      Map<String, dynamic> _tmp = {"name": name, "id": id};
      _tabList.add(_tmp);
      print(name);
    });
    _tabController = new TabController(length: _tabList.length, vsync: this);
    if (_tabController != null) {
      _tabController?.addListener(_handleTab);
      _getMenuByCategory();
    }
    setState(() {
      isLoading = false;
    });
    print(_tabList);
  }

  void _handleTab() {
    if (_tabController?.indexIsChanging == true) {
      _getMenuByCategory();
    }
  }

  void _getMenuByCategory() async {
    setState(() {
      isLoadingMenu = true;
    });
    int _tabIndex = _tabController?.index ?? 0;
    Map<String, dynamic> _selectedTab = _tabList[_tabIndex];
    int _categoryID = _selectedTab["id"] as int;
    List<dynamic> _data = await getMenuByCategory(_categoryID);

    List<Map<String, dynamic>> _tmpMenuList = [];
    _data.forEach((value) {
      int _tmpID = value["id"] as int;
      String _tmpName = value["nama"].toString();
      String _tmpDescription =
          value["deskripsi"] != null ? value["deskripsi"].toString() : '';
      String _tmpUrl = value["gambar"] != null
          ? (value["gambar"] != ''
              ? value["gambar"].toString()
              : "/assets/icon/logo.png")
          : "/assets/icon/logo.png";
      int _tmpPrice = value["harga"] as int;
      Map<String, dynamic> _tmp = {
        "id": _tmpID,
        "name": _tmpName,
        "description": _tmpDescription,
        "url": _tmpUrl,
        "price": _tmpPrice
      };

      _tmpMenuList.add(_tmp);
    });

    setState(() {
      _menuList = _tmpMenuList;
      isLoadingMenu = false;
    });
    print(_menuList);
  }

  refresh() async {
    _getMenuByCategory();
    _getAvailableCart();
  }

  void _addToCart(int id, BuildContext modalContext) {
    Map<String, dynamic> _data = {
      "menu": id,
      "qty": qty,
      "description": addition
    };
    addToCart(_data, (message) {
      print(message);
      Navigator.pop(modalContext);
      _getAvailableCart();
    }, (message) {
      print(message);
    });
  }

  void _getAvailableCart() async {
    List<dynamic> _data = await listAvailableCart();
    int _cartCount = _data.length;
    if (_cartCount > 0) {
      int _tmpSubTotal = 0;
      _data.forEach((element) {
        _tmpSubTotal += element["total"] as int;
      });
      setState(() {
        isCartAvailable = true;
        subTotal = _tmpSubTotal;
      });
    } else {
      isCartAvailable = false;
    }
    print(_data);
  }

  void _showModalMenu(int id) async {
    Map<String, dynamic> _data = await getMenyById(id);
    String url = _data["gambar"] != null
        ? (_data["gambar"] != ''
            ? _data["gambar"].toString()
            : "/assets/icon/logo.png")
        : "/assets/icon/logo.png";
    String name = _data["nama"].toString();
    int price = _data["harga"] as int;
    String description =
        _data["deskripsi"] != null ? _data["deskripsi"].toString() : '';
    print(_data);
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.6,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Stack(
              children: [
                DetailOrderComponent(
                  url: url,
                  name: name,
                  price: price,
                  description: description,
                  textEditingController: _textEditingController,
                  onAdd: () {
                    setState(() {
                      qty += 1;
                    });
                    _textEditingController.text = qty.toString();
                  },
                  onMin: () {
                    if (qty > 0) {
                      setState(() {
                        qty -= 1;
                      });
                      _textEditingController.text = qty.toString();
                    }
                  },
                  textAdditionController: _textAdditionController,
                  onAdditon: (text) {
                    setState(() {
                      addition = text;
                    });
                    print(addition);
                  },
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () {
                      _addToCart(id, context);
                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.brown),
                      child: Center(
                        child: Text(
                          "Tambah Keranjang",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
