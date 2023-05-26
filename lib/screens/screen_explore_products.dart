import 'package:flutter/material.dart';
import 'package:marketplace/boundaries/object_boundary.dart';

class ScreenExploreProducts extends StatefulWidget {
  const ScreenExploreProducts({Key? key}) : super(key: key);

  @override
  State<ScreenExploreProducts> createState() => _ScreenExploreProductsState();
}

class _ScreenExploreProductsState extends State<ScreenExploreProducts> {
  final List<ObjectBoundary> products = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore Products'),
        // automaticallyImplyLeading: false,
      ),
      drawer: const AppDrawer(),
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
                                '${products[index].objectDetails['price']}'
                                '${products[index].objectDetails['currency']}'),
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

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green,
            ),
            child: Text(
              'Social Hive',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: const Text('My Products'),
            onTap: () {
              Navigator.pushNamed(context, '/my_products');
            },
          ),
          ListTile(
            title: const Text('My Profile'),
            onTap: () {
              Navigator.pushNamed(context, '/my_profile');
            },
          ),
          ListTile(
            title: const Text('Logout'),
            onTap: () {
              Navigator.pushNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}
