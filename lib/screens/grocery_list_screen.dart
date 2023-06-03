import 'package:flutter/material.dart';
import 'package:fooderlich/components/grocery_tile.dart';
import 'package:fooderlich/models/models.dart';
import 'package:fooderlich/screens/grocery_item_screen.dart';

class GroceryListScreen extends StatelessWidget {
  final GroceryManager manager;

  const GroceryListScreen({Key? key, required this.manager}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = manager.groceryItems;

    return Padding(
      padding: EdgeInsets.all(16),
      child: ListView.separated(
          itemBuilder: (con, index) {
            var item = items[index];
            return Dismissible(
              key: Key(item.id),
              direction: DismissDirection.endToStart,
              background: Container(
                color: Colors.red,
                child: Icon(Icons.delete_forever, color: Colors.white, size: 50,),
                alignment: Alignment.centerRight,
              ),
              onDismissed: (direction) {
                manager.deleteItem(index);
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("${item.name} dismissed")));
              },
              child: InkWell(
                child: GroceryTile(
                  key: Key(item.id),
                  item: item,
                  onComplete: (change) {
                    if (change != null) {
                      manager.completeItem(index, change);
                    }
                  },
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (con) => GroceryItemScreen(
                              originalGroceryItem: item,
                              onCreate: (it) {},
                              onUpdate: (it) {
                                manager.updateItem(index, it);
                                Navigator.pop(con);
                              })));
                },
              ),
            );
          },
          separatorBuilder: (con, index) {
            return const SizedBox(
              height: 16,
            );
          },
          itemCount: items.length),
    );
  }
}
