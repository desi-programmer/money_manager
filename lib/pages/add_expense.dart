import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:expense/static.dart' as Static;
import 'package:flutter/services.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({Key? key}) : super(key: key);

  @override
  _AddExpenseState createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
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
          Row(
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
                    color: selected == "Expense" ? Colors.white : Colors.black,
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
          //
          TextButton(
            onPressed: () {
              _selectDate(context);
              print(selectedDate);
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
          //
          SizedBox(
            height: 12.0,
          ),
          InkWell(
            onTap: () {
              //
              print(amount);
              print(selected);
              print(selectedDate);
            },
            child: Material(
              elevation: 6.0,
              borderRadius: BorderRadius.all(
                Radius.circular(
                  18.0,
                ),
              ),
              child: Ink(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      Color(0xFF24b0e3),
                      Color(0xFFce68fa),
                      Color(0xFFfc9471),
                    ],
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      18.0,
                    ),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(),
                  padding: EdgeInsets.symmetric(
                    vertical: 12.0,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Add",
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
