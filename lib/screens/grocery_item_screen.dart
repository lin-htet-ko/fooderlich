import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:fooderlich/components/grocery_tile.dart';
import 'package:fooderlich/models/grocery_item.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class GroceryItemScreen extends StatefulWidget {
  final Function(GroceryItem) onCreate;
  final Function(GroceryItem) onUpdate;
  final GroceryItem? originalGroceryItem;
  final bool isUpdating;

  const GroceryItemScreen(
      {Key? key,
      required this.onCreate,
      required this.onUpdate,
      this.originalGroceryItem})
      : isUpdating = (originalGroceryItem != null);

  @override
  State<GroceryItemScreen> createState() => _GroceryItemScreenState();
}

class _GroceryItemScreenState extends State<GroceryItemScreen> {
  final TextEditingController _nameController = TextEditingController();
  String _name = "";
  Importance _importance = Importance.low;
  DateTime _dueDate = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();
  Color _currentColor = Colors.green;
  int _currentSliderValue = 0;

  @override
  void initState() {
    super.initState();

    final originalItem = widget.originalGroceryItem;
    if (originalItem != null) {
      _nameController.text = originalItem.name;
      _name = originalItem.name;
      _importance = originalItem.importance;
      var date = originalItem.date;
      _timeOfDay = TimeOfDay(hour: date.hour, minute: date.minute);
      _dueDate = date;
      _currentColor = originalItem.color;
      _currentSliderValue = originalItem.quantity;
    }

    _nameController.addListener(() {
      setState(() {
        _name = _nameController.text;
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              final item = GroceryItem(
                id: widget.originalGroceryItem?.id ?? const Uuid().v1(),
                name: _name,
                importance: _importance,
                color: _currentColor,
                quantity: _currentSliderValue,
                date: DateTime(_dueDate.year, _dueDate.month, _dueDate.day,
                    _timeOfDay.hour, _timeOfDay.minute),
              );
              if (widget.isUpdating) {
                widget.onUpdate(item);
              } else {
                widget.onCreate(item);
              }
            },
          )
        ],
        elevation: 0.0,
        title: Text(
          "Grocery Item",
          style: GoogleFonts.lato(fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            buildNameField(),
            buildImportantField(),
            buildDatePicker(context),
            buildTimePicker(context),
            const SizedBox(
              height: 10,
            ),
            buildColorPicker(context),
            const SizedBox(
              height: 10,
            ),
            buildQuantity(),
            const SizedBox(
              height: 10,
            ),
            GroceryTile(
                item: GroceryItem(
              id: "previewMode",
              name: _name,
              importance: _importance,
              color: _currentColor,
              quantity: _currentSliderValue,
              date: DateTime(_dueDate.year, _dueDate.month, _dueDate.day,
                  _timeOfDay.hour, _timeOfDay.minute),
            ))
          ],
        ),
      ),
    );
  }

  Widget buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Item's Name",
          style: GoogleFonts.lato(fontSize: 28.0),
        ),
        TextField(
          controller: _nameController,
          cursorColor: _currentColor,
          decoration: InputDecoration(
              hintText: "Eg. Apples, Banana, 1 Bag Of Salt",
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: _currentColor),
              ),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: _currentColor))),
        )
      ],
    );
  }

  Widget buildImportantField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Importance",
          style: GoogleFonts.lato(fontSize: 28.0),
        ),
        Wrap(
          spacing: 10,
          children: [
            ChoiceChip(
              label: Text(
                "low",
                style: TextStyle(color: Colors.white),
              ),
              selected: _importance == Importance.low,
              selectedColor: Colors.black,
              onSelected: (selected) {
                setState(() {
                  _importance = Importance.low;
                });
              },
            ),
            ChoiceChip(
              label: Text(
                "medium",
                style: TextStyle(color: Colors.white),
              ),
              selected: _importance == Importance.medium,
              selectedColor: Colors.black,
              onSelected: (selected) {
                setState(() {
                  _importance = Importance.medium;
                });
              },
            ),
            ChoiceChip(
              label: Text(
                "high",
                style: TextStyle(color: Colors.white),
              ),
              selected: _importance == Importance.high,
              selectedColor: Colors.black,
              onSelected: (selected) {
                setState(() {
                  _importance = Importance.high;
                });
              },
            ),
          ],
        )
      ],
    );
  }

  Widget buildDatePicker(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Date",
              style: GoogleFonts.lato(fontSize: 28),
            ),
            TextButton(
                onPressed: () async {
                  DateTime currentDate = DateTime.now();
                  final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: currentDate,
                      firstDate: currentDate,
                      lastDate: DateTime(currentDate.year + 5));

                  setState(() {
                    if (selectedDate != null) {
                      _dueDate = selectedDate;
                    }
                  });
                },
                child: Text("Select"))
          ],
        ),
        Text(DateFormat("yyyy-MM-dd").format(_dueDate))
      ],
    );
  }

  Widget buildTimePicker(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Time",
              style: GoogleFonts.lato(fontSize: 28),
            ),
            TextButton(
                onPressed: () async {
                  TimeOfDay currentTime = TimeOfDay.now();
                  final selectedTime = await showTimePicker(
                      context: context, initialTime: currentTime);
                  setState(() {
                    if (selectedTime != null) {
                      _timeOfDay = selectedTime;
                    }
                  });
                },
                child: Text("Select"))
          ],
        ),
        Text(_timeOfDay.format(context))
      ],
    );
  }

  Widget buildColorPicker(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              height: 50,
              width: 10,
              color: _currentColor,
            ),
            const SizedBox(
              width: 8.0,
            ),
            Text(
              "Color",
              style: GoogleFonts.lato(fontSize: 28.0),
            )
          ],
        ),
        TextButton(
          child: Text("Select"),
          onPressed: () {
            showDialog(
                context: context,
                builder: (con) {
                  return AlertDialog(
                    content: BlockPicker(
                        pickerColor: Colors.white,
                        onColorChanged: (col) {
                          setState(() {
                            _currentColor = col;
                          });
                        }),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Save"))
                    ],
                  );
                });
          },
        )
      ],
    );
  }

  Widget buildQuantity() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "Quantity",
              style: GoogleFonts.lato(fontSize: 28),
            ),
            SizedBox(
              width: 28,
            ),
            Text(
              _currentSliderValue.toString(),
              style: GoogleFonts.lato(fontSize: 18),
            )
          ],
        ),
        Slider(
            min: 0,
            max: 100,
            label: _currentSliderValue.toInt().toString(),
            activeColor: _currentColor,
            inactiveColor: _currentColor.withOpacity(0.5),
            value: _currentSliderValue.toDouble(),
            onChanged: (val) {
              setState(() {
                _currentSliderValue = val.toInt();
              });
            })
      ],
    );
  }
}
