import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_coffee_app/component/card-menu.dart';
import 'package:flutter_coffee_app/component/page-loading.dart';
import 'package:flutter_coffee_app/component/top-navbar.dart';
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
  List<Map<String, dynamic>> _tabList = [];
  List<Map<String, dynamic>> _menuList = [];
  @override
  void initState() {
    // TODO: implement initState
    _getCategories();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (_tabController != null) {
      _tabController?.dispose();
    }
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
                  child: Column(
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
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                  child: LayoutBuilder(
                                    builder: (context, constraints) =>
                                        SingleChildScrollView(
                                      physics: AlwaysScrollableScrollPhysics(),
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
                                                      _showModalMenu();
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
  }

  void _showModalMenu() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Container(
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Container(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 10,
                  decoration: BoxDecoration(color: Colors.brown),
                ),
              ),
            ),
          );
        });
  }
}
