import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:expense/static.dart' as Static;
import 'package:flutter/services.dart';

class AddExpenseNoGradient extends StatefulWidget {
  const AddExpenseNoGradient({Key? key}) : super(key: key);

  @override
  _AddExpenseNoGradientState createState() => _AddExpenseNoGradientState();
}

class _AddExpenseNoGradientState extends State<AddExpenseNoGradient> {
  DateTime selectedDate = DateTime.now();
  int? amount;

  String selected = "Income";

  List<String> months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      body: ListView(
        padding: EdgeInsets.all(
          12.0,
        ),
        children: [
          Text(
            "\nAdd Expense/Income",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          //
          TextField(
            decoration: InputDecoration(
              hintText: "0",
              border: InputBorder.none,
            ),
            style: TextStyle(
              fontSize: 24.0,
            ),
            onChanged: (val) {
              amount = int.parse(val);
            },
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 12.0,
          ),
          //
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                ChoiceChip(
                  label: Text(
                    "Income",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: selected == "Income" ? Colors.white : Colors.black,
                    ),
                  ),
                  selectedColor: Static.PrimaryColor,
                  onSelected: (val) {
                    if (val) {
                      setState(() {
                        selected = "Income";
                      });
                    }
                  },
                  selected: selected == "Income" ? true : false,
                ),
                SizedBox(
                  width: 8.0,
                ),
                ChoiceChip(
                  label: Text(
                    "Expense",
                    style: TextStyle(
                      fontSize: 18.0,
                      color:
                          selected == "Expense" ? Colors.white : Colors.black,
                    ),
                  ),
                  selectedColor: Static.PrimaryColor,
                  onSelected: (val) {
                    if (val) {
                      setState(() {
                        selected = "Expense";
                      });
                    }
                  },
                  selected: selected == "Expense" ? true : false,
                ),
              ],
            ),
          ),
          //
          SizedBox(
            height: 12.0,
          ),
          //
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextButton(
              onPressed: () {
                _selectDate(context);
                //
                // to make sure that no keyboard is shown after selecting Date
                FocusScope.of(context).unfocus();
              },
              child: Row(
                children: [
                  Icon(
                    Icons.date_range,
                    size: 24.0,
                    color: Colors.grey[700],
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                  Text(
                    "${selectedDate.day} ${months[selectedDate.month - 1]}",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          ),
          //
          SizedBox(
            height: 12.0,
          ),
          //
          SizedBox(
            height: 50.0,
            child: ElevatedButton(
              onPressed: () {
                print(amount);
                print(selected);
                print(selectedDate);
              },
              child: Text(
                "Add",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
