import 'package:flutter/material.dart';
import 'package:fooderlich/models/models.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class GroceryTile extends StatelessWidget {
  final GroceryItem item;
  final Function(bool?)? onComplete;
  final TextDecoration decoration;

  GroceryTile({super.key, required this.item, this.onComplete})
      : decoration =
            item.isComplete ? TextDecoration.lineThrough : TextDecoration.none;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 5,
                color: item.color,
              ),
              const SizedBox(
                width: 16,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name,
                      style: GoogleFonts.lato(
                        decoration: decoration,
                        fontSize: 21.0,
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(
                    height: 4,
                  ),
                  buildDate(),
                  buildImportance()
                ],
              )
            ],
          ),
          Row(
            children: [
              Text(
                item.quantity.toString(),
                style: GoogleFonts.lato(fontSize: 21, decoration: decoration),
              ),
              buildCheckbox()
            ],
          )
        ],
      ),
    );
  }

  Widget buildImportance() {
    switch (item.importance) {
      case Importance.low:
        {
          return Text(
            "Low",
            style: GoogleFonts.lato(decoration: decoration),
          );
        }
      case Importance.medium:
        {
          return Text(
            "Medium",
            style: GoogleFonts.lato(
                decoration: decoration, fontWeight: FontWeight.w800),
          );
        }
      case Importance.high:
        {
          return Text(
            "High",
            style: GoogleFonts.lato(
                color: Colors.red,
                decoration: decoration,
                fontWeight: FontWeight.w900),
          );
        }
      default:
        {
          throw Exception("No Found Widget");
        }
    }
  }

  Widget buildDate() {
    final formatDate = DateFormat("MMMM dd hh:mm a");
    final formatString = formatDate.format(item.date);
    return Text(
      formatString,
      style: TextStyle(decoration: decoration),
    );
  }

  Widget buildCheckbox() {
    return Checkbox(value: item.isComplete, onChanged: onComplete);
  }
}
