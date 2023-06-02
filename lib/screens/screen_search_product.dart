import 'package:flutter/material.dart';
import 'package:marketplace/api/command_api.dart';
import 'package:marketplace/boundaries/object_boundary.dart';
import 'package:marketplace/other/item_object.dart';
import 'package:marketplace/other/preferences.dart';
import 'package:marketplace/screens/screen_view_product.dart';
import 'package:marketplace/widgets/multi_select_dialog.dart';
enum Sreach { name, price, preference }

class ScreenSearchProducts extends StatefulWidget {
  const ScreenSearchProducts({super.key});

  @override
  State<ScreenSearchProducts> createState() => _ScreenSearchProductsState();
}

class _ScreenSearchProductsState extends State<ScreenSearchProducts> {
  final _textFieldControllerSearch = TextEditingController();
  final List<ObjectBoundary> products = <ObjectBoundary>[];
  List<ItemObject> _selectedPreferences = [];
  RangeValues _ageRangeValues = const RangeValues(0, 10000);


  Sreach searchView = Sreach.name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Products'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            multiSelect(),
            const SizedBox(height: 30),
            optionSearch(),
            const SizedBox(height: 30),
            listview(),

          ],
        )
      ),);
  }

    Widget optionSearch() {
    return searchView == Sreach.name
        ? TextField(
            controller: _textFieldControllerSearch,
            onChanged: (value) {
              if (_textFieldControllerSearch.text.isNotEmpty) {
                _search(_textFieldControllerSearch.text);
              } else {
                setState(() {
                  products.clear();
                });
              }
            },
            decoration: const InputDecoration(
              hintText: 'Search',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
          )
        : searchView == Sreach.price
            ? Column(
              children: [
                Text('Price Range: ${_ageRangeValues.start.toInt().toString()} - ${_ageRangeValues.end.toInt().toString()}\$'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 350,
                      child: RangeSlider(
                            values: _ageRangeValues,
                            min: 0,
                            max: 10000,
                            divisions: 100,
                            labels: RangeLabels(
                              _ageRangeValues.start.toInt().toString(),
                              _ageRangeValues.end.toInt().toString(),
                            ),
                            onChanged: (values) {
                              setState(() {
                                _ageRangeValues = values;
                              });
                            }),
                    ),
                          SizedBox(
                            width: 100,
                            child: OutlinedButton(onPressed: (){
                              _search('');
                            }, child:  const Text('Search '),
                            
                            ),
                          ),
                  ],
                ),
              ],
            )
            : MultiSelect(
                "Preferences",
                "Preferences",
                Preferences().getPreferences(),
                onMultiSelectConfirm: (List<ItemObject> results) {
                  _selectedPreferences = results;
                },
              );
  }

  Widget listview() {
    return products.isNotEmpty
        ? ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: const EdgeInsets.all(8),
            itemCount: products.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: ListTile(
                  title: Text(products[index].objectDetails['name'] as String),
                  subtitle: Text(
                      products[index].objectDetails['description'] as String),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ScreenProductDetails(objectBoundary: products[index])));
                  },
                ),
              );
            },
          )
        : const Center(child: Text('No new events found'));
  }

  Widget multiSelect() {
    return SizedBox(
      width: double.infinity,
      child: SegmentedButton<Sreach>(
        segments: const <ButtonSegment<Sreach>>[
          ButtonSegment<Sreach>(
              value: Sreach.name, label: Text('Name'), icon: Icon(Icons.event)),
          ButtonSegment<Sreach>(
              value: Sreach.price,
              label: Text('Price'),
              icon: Icon(Icons.date_range)),
          ButtonSegment<Sreach>(
              value: Sreach.preference,
              label: Text('Preference'),
              icon: Icon(Icons.favorite)),
        ],
        selected: <Sreach>{searchView},
        onSelectionChanged: (Set<Sreach> newSelection) {
          setState(() {
            searchView = newSelection.first;
          });
        },
      ),
    );
  }

  Future _search(String value) async {
    products.clear();
    switch (searchView) {
      case Sreach.name:
        await _searchByName(value);
        break;
      case Sreach.price:
        await _searchByPrice(_ageRangeValues.start.toDouble(), _ageRangeValues.end.toDouble());
        break;
      case Sreach.preference:
        await _searchByPreference(_selectedPreferences.map((e) => e.name).toList());
        break;
    }
  }
  
  Future _searchByName(String name) async{
    await CommandApi().searchProductsByName(name).then((value) => 
    setState(() {
      products.clear();
      products.addAll(value);
    }));
  }

  Future _searchByPrice(double minPrice, double maxPrice) async{
    await CommandApi().searchProductsByPrice(minPrice, maxPrice).then((value) => 
    setState(() {
      products.clear();
      products.addAll(value);
    }));
  }

  Future _searchByPreference(List<String> preference) async{
    await CommandApi().searchProductsByPreferences(preference).then((value) => 
    setState(() {
      products.clear();
      products.addAll(value);
    }));
  }



}