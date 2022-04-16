
import 'package:flutter/material.dart';
import 'package:flutter_coffee_app/helper/static_variable.dart';

typedef FunctionStringCallback =  Function(String params);
class DetailOrderComponent extends StatelessWidget {
  final String url;
  final String name;
  final int price;
  final int qty;
  final String description;
  final VoidCallback? onAdd;
  final VoidCallback? onMin;
  final FunctionStringCallback? onAdditon;
  final TextEditingController? textEditingController;
  final TextEditingController? textAdditionController;

  const DetailOrderComponent({
    Key? key,
    this.url = '',
    this.name = 'Menu 1',
    this.price = 0,
    this.qty = 0,
    this.description = '',
    this.onAdd,
    this.onMin,
    this.textEditingController,
    this.textAdditionController,
    this.onAdditon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 130,
          padding: EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 120,
                width: 120,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: Text(
                        name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "IDR " + price.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.brown,
                        ),
                      ),
                    ),
                    Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: onMin,
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
                        onTap: onAdd,
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
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Keterangan",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        description,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Colors.black45,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Catatan Tambahan",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      TextField(
                        onChanged: onAdditon,
                        controller: textAdditionController,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          contentPadding: EdgeInsets.all(5),
                        ),
                        maxLines: 5,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
