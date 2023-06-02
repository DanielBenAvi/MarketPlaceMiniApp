import 'package:flutter/material.dart';
import 'package:marketplace/api/command_api.dart';
import 'package:marketplace/api/user_api.dart';
import 'package:marketplace/boundaries/object_boundary.dart';
import 'package:marketplace/screens/screen_view_product.dart';

class ScreenMyProducts extends StatefulWidget {
  const ScreenMyProducts({Key? key}) : super(key: key);

  @override
  State<ScreenMyProducts> createState() => _ScreenMyProductsState();
}

class _ScreenMyProductsState extends State<ScreenMyProducts> {
  final List<ObjectBoundary> products = [];

  @override
  void initState() {
    super.initState();
    _updateRole();
    _getProducts();
  }

  Future _updateRole() async {
    await UserApi().updateRole('MINIAPP_USER');
  }



  Future _getProducts() async {
    await CommandApi().getMyProducts().then((value) {
      setState(() {
        products.clear();
        products.addAll(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Products'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add_product');
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              child: products.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: products.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: ListTile(
                            title: Text(products[index].objectDetails['name']),
                            subtitle: Text(
                                products[index].objectDetails['description']),
                            trailing: Text(
                                '${products[index].objectDetails['price']}\$'),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ScreenProductDetails(objectBoundary: products[index])));
                      },
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Text(
                        'No products to show',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
