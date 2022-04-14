import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_coffee_app/component/page-loading.dart';
import 'package:flutter_coffee_app/component/top-navbar.dart';
import 'package:flutter_coffee_app/controller/categories.dart';

class OrderView extends StatefulWidget {
  const OrderView({Key? key}) : super(key: key);

  @override
  _OrderViewState createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  bool isLoading = true;
  List<Map<String, dynamic>> _tabList = [];
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
              : TabBar(
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
          // Expanded(
          //   child: Container(),
          // child: TabBarView(
          //   children: [
          //     Container(child: Center(child: Text('people'))),
          //     Text('Person'),
          //     Text('Person'),
          //     Text('Person'),
          //     Container(child: Center(child: Text('people'))),
          //     Text('Person'),
          //     Text('Person'),
          //     Text('Person'),
          //   ],
          //   controller: _tabController,
          // ),
          // ),
        ],
      ),
    );
  }

  void _getCategories() async {
    List<dynamic> _list = await listCategories();
    setState(() {
      isLoading = false;
    });
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
    }
    print(_tabList);
  }

  void _handleTab() {
    if (_tabController?.indexIsChanging == true) {
      int index = _tabController?.index ?? 0;
      print(_tabList[index]);
    }
  }
}
