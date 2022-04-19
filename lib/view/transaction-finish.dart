import 'package:flutter/material.dart';
import 'package:flutter_coffee_app/component/page-loading.dart';
import 'package:flutter_coffee_app/component/transaction-item.dart';
import 'package:flutter_coffee_app/controller/transaction.dart';

class TransactionFinsihView extends StatefulWidget {
  const TransactionFinsihView({ Key? key }) : super(key: key);

  @override
  _TransactionFinsihViewState createState() => _TransactionFinsihViewState();
}

class _TransactionFinsihViewState extends State<TransactionFinsihView> {
  bool isLoading = true;
  List<dynamic> transactionList = [];

  @override
  void initState() {
    // TODO: implement initState
    _getListTransaction();
    super.initState();
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
                      "Pesanan Selesai",
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
              child: RefreshIndicator(
                onRefresh: () {
                  return refresh();
                },
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: isLoading
                      ? PageLoading()
                      : SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: transactionList
                                .map((e) => TransactionItem(
                                      customer: e["customer"].toString(),
                                      total: e["total"] as int,
                                      status: "Selesai",
                                      id: e["id"] as int,
                                    ))
                                .toList(),
                          ),
                        ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  refresh() async {
    _getListTransaction();
  }

  void _getListTransaction() async {
    setState(() {
      isLoading = true;
    });
    List<dynamic> _data = await listTransaction(1);
    print(_data);
    setState(() {
      transactionList = _data;
      isLoading = false;
    });
  }
}