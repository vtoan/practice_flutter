import 'package:flutter/material.dart';
import 'package:my_app/apiService.dart';
import 'package:my_app/pages/form-edit.dart';
import 'package:my_app/productModel.dart';

class ListItemPage extends StatefulWidget {
  @override
  _ListItem createState() => _ListItem();
}

class _ListItem extends State<ListItemPage> {
  late Future<List<Product>> _product;
  @override
  void initState() {
    super.initState();
    _product = ApiService.fetchProduct();
  }

  void onRefresh() {
    setState(() {
      _product = ApiService.fetchProduct();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff9f9f9),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black54),
          backgroundColor: Color(0xfff9f9f9),
          elevation: 0.0,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Manage Products",
                style: Theme.of(context).textTheme.headline5?.apply(
                      fontWeightDelta: 2,
                    ),
              ),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () => onRefresh(),
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => Navigator.pushNamed(context, '/form'),
            ),
          ],
        ),
        body: FutureBuilder<List<Product>>(
          future: _product,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data;
              if (data == null) return Text("No data");
              return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    Product product = data[index];
                    return Container(
                      height: 100,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.transparent,
                              child: ClipOval(
                                child: Image.network(
                                  product.p6,
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child:
                                Text(product.p1, textAlign: TextAlign.center),
                            flex: 2,
                          ),
                          Expanded(
                            child:
                                Text(product.p2, textAlign: TextAlign.center),
                            flex: 2,
                          ),
                          Expanded(
                            child: IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            FormEditPage(product: product),
                                      ),
                                    )),
                            flex: 2,
                          ),
                          Expanded(
                            child: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () =>
                                    ApiService.deleteProduct(product.id)
                                        .then((value) => onRefresh())),
                            flex: 1,
                          )
                        ],
                      ),
                    );
                  });
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ));
  }
}
