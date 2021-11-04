import 'package:expense/pages/add_expense.dart';
import 'package:expense/pages/add_expense_no_gradient.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:expense/static.dart' as Static;

class HomePageSingleColor extends StatefulWidget {
  const HomePageSingleColor({Key? key}) : super(key: key);

  @override
  _HomePageSingleColorState createState() => _HomePageSingleColorState();
}

class _HomePageSingleColorState extends State<HomePageSingleColor> {
  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      backgroundColor: Color(0xffede9f0),
      //
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (context) => AddExpenseNoGradient(),
            ),
          );
        },
        backgroundColor: Static.PrimaryColor,
        child: Icon(
          Icons.add_outlined,
          size: 32.0,
        ),
      ),
      //
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                //
                Padding(
                  padding: const EdgeInsets.all(
                    12.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                32.0,
                              ),
                              gradient: LinearGradient(
                                colors: <Color>[
                                  Static.PrimaryColor,
                                  Colors.blueAccent,
                                ],
                              ),
                            ),
                            child: CircleAvatar(
                              maxRadius: 28.0,
                              backgroundColor: Colors.transparent,
                              child: Image.network(
                                "http://clipart-library.com/images_k/transparent-happy-emoji/transparent-happy-emoji-15.png",
                                width: 64.0,
                              ),
                            ),
                          ),
                          Text(
                            "\tWelcome Prince",
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w700,
                              color: Static.PrimaryMaterialColor[800],
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.settings,
                        size: 32.0,
                        color: Color(0xff3E454C),
                      ),
                    ],
                  ),
                ),
                //
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  margin: EdgeInsets.all(
                    12.0,
                  ),
                  child: Ink(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          Static.PrimaryColor,
                          Colors.blueAccent,
                        ],
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          24.0,
                        ),
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            24.0,
                          ),
                        ),
                        // color: Static.PrimaryColor,
                      ),
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                        vertical: 18.0,
                        horizontal: 8.0,
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Total Balance',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22.0,
                              // fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 12.0,
                          ),
                          Text(
                            'Rs 32000',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 36.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 12.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                cardIncome(
                                  "1600",
                                ),
                                cardExpense(
                                  "1200",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //
                Padding(
                  padding: const EdgeInsets.all(
                    12.0,
                  ),
                  child: Text(
                    "Nov 2021",
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                //
                Container(
                  height: 300.0,
                  padding: EdgeInsets.symmetric(
                    vertical: 40.0,
                    horizontal: 12.0,
                  ),
                  margin: EdgeInsets.all(
                    12.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: LineChart(
                    LineChartData(
                      borderData: FlBorderData(
                        show: false,
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          spots: [
                            FlSpot(2, 1000),
                            FlSpot(3, 1200),
                            FlSpot(4, 3000),
                            FlSpot(5, 2000),
                            FlSpot(8, 1400),
                            FlSpot(10, 1320),
                            FlSpot(12, 900),
                            FlSpot(17, 1900),
                          ],
                          isCurved: false,
                          barWidth: 2.5,
                          colors: [
                            Static.PrimaryColor,
                          ],
                          showingIndicators: [200, 200, 90, 10],
                          dotData: FlDotData(
                            show: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "Recent Expenses",
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                //
                creditTile(
                  12000,
                ),
                expenseTile(
                  2000,
                ),
                expenseTile(
                  4000,
                ),
                expenseTile(
                  2200,
                ),
                //
                SizedBox(
                  height: 40.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//
//
//
// Widget
//
//

Widget cardIncome(String value) {
  return Row(
    children: [
      Container(
        decoration: BoxDecoration(
          color: Colors.white60,
          borderRadius: BorderRadius.circular(
            20.0,
          ),
        ),
        padding: EdgeInsets.all(
          6.0,
        ),
        child: Icon(
          Icons.arrow_downward,
          size: 28.0,
          color: Colors.green[700],
        ),
        margin: EdgeInsets.only(
          right: 8.0,
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Income",
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.white70,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ],
  );
}

Widget cardExpense(String value) {
  return Row(
    children: [
      Container(
        decoration: BoxDecoration(
          color: Colors.white60,
          borderRadius: BorderRadius.circular(
            20.0,
          ),
        ),
        padding: EdgeInsets.all(
          6.0,
        ),
        child: Icon(
          Icons.arrow_upward,
          size: 28.0,
          color: Colors.red[700],
        ),
        margin: EdgeInsets.only(
          right: 8.0,
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Expense",
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.white70,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ],
  );
}

Widget expenseTile(int value) {
  return Container(
    padding: const EdgeInsets.all(18.0),
    margin: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
        color: Color(0xffced4eb),
        borderRadius: BorderRadius.circular(
          8.0,
        )),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              Icons.arrow_circle_up_outlined,
              size: 28.0,
              color: Colors.red[700],
            ),
            Text(
              "\tExpense",
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ],
        ),
        Text(
          "- $value",
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}

Widget creditTile(int value) {
  return Container(
    padding: const EdgeInsets.all(18.0),
    margin: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
        color: Color(0xffced4eb),
        borderRadius: BorderRadius.circular(
          8.0,
        )),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              Icons.arrow_circle_down_outlined,
              size: 28.0,
              color: Colors.green[700],
            ),
            Text(
              "\tCredit",
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ],
        ),
        Text(
          "+ $value",
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}
