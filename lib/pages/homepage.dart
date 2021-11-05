import 'package:expense/pages/add_expense_no_gradient.dart';
import 'package:expense/pages/settings.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:expense/static.dart' as Static;
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageSingleColor extends StatefulWidget {
  const HomePageSingleColor({Key? key}) : super(key: key);

  @override
  _HomePageSingleColorState createState() => _HomePageSingleColorState();
}

class _HomePageSingleColorState extends State<HomePageSingleColor> {
  //
  late Box box;
  late SharedPreferences preferences;
  Map? data;
  int totalBalance = 0;
  int totalIncome = 0;
  int totalExpense = 0;
  List<FlSpot> dataSet = [];
  DateTime today = DateTime.now();

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

  @override
  void initState() {
    super.initState();
    getPreference();
    box = Hive.box('money');
  }

  getPreference() async {
    preferences = await SharedPreferences.getInstance();
  }

  Future<Map> fetch() {
    if (box.values.isEmpty) {
      return Future.value({});
    } else {
      return Future.value(box.toMap());
    }
  }
  //

  List<FlSpot> getPlotPoints(Map entireData) {
    dataSet = [];
    entireData.forEach((key, value) {
      print(
        (value['date'] as DateTime).day.toDouble(),
      );
      print((value['amount'] as int).toDouble());
      if (value['type'] == "Expense" &&
          (value['date'] as DateTime).month == today.month) {
        dataSet.add(
          FlSpot(
            (value['date'] as DateTime).day.toDouble(),
            (value['amount'] as int).toDouble(),
          ),
        );
      }
    });
    print(dataSet);
    return dataSet;
  }

  getTotalBalance(Map entireData) {
    totalBalance = 0;
    totalIncome = 0;
    totalExpense = 0;
    entireData.forEach((key, value) {
      // print(key);
      // print(value['type']);
      if (value['type'] == "Income") {
        totalBalance += (value['amount'] as int);
        totalIncome += (value['amount'] as int);
      } else {
        totalBalance -= (value['amount'] as int);
        totalExpense += (value['amount'] as int);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      backgroundColor: Colors.grey[200],
      //
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
            CupertinoPageRoute(
              builder: (context) => AddExpenseNoGradient(),
            ),
          )
              .then((value) {
            setState(() {});
          });
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            16.0,
          ),
        ),
        backgroundColor: Static.PrimaryColor,
        child: Icon(
          Icons.add_outlined,
          size: 32.0,
        ),
      ),
      //
      body: FutureBuilder<Map>(
        future: fetch(),
        builder: (context, snapshot) {
          // print(snapshot.data);
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Oopssss !!! There is some error !",
              ),
            );
          }
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return Center(
                child: Text(
                  "You haven't added Any Data !",
                ),
              );
            }
            //
            getTotalBalance(snapshot.data!);
            getPlotPoints(snapshot.data!);
            return ListView(
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
                              child: Image.asset(
                                "assets/face.png",
                                width: 64.0,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          SizedBox(
                            width: 200.0,
                            child: Text(
                              "Welcome ${preferences.getString('name')}",
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.w700,
                                color: Static.PrimaryMaterialColor[800],
                              ),
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            12.0,
                          ),
                          color: Colors.white70,
                        ),
                        padding: EdgeInsets.all(
                          12.0,
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(
                              MaterialPageRoute(
                                builder: (context) => Settings(),
                              ),
                            )
                                .then((value) {
                              setState(() {});
                            });
                          },
                          child: Icon(
                            Icons.settings,
                            size: 32.0,
                            color: Color(0xff3E454C),
                          ),
                        ),
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
                            'Rs $totalBalance',
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
                                  totalIncome.toString(),
                                ),
                                cardExpense(
                                  totalExpense.toString(),
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
                    "${months[today.month - 1]} ${today.year}",
                    style: TextStyle(
                      fontSize: 32.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                //
                dataSet.isEmpty
                    ? Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 40.0,
                          horizontal: 20.0,
                        ),
                        margin: EdgeInsets.all(
                          12.0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            8.0,
                          ),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Text(
                          "Not Enough Data to render Chart",
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      )
                    : Container(
                        height: 400.0,
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
                              offset:
                                  Offset(0, 3), // changes position of shadow
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
                                spots: getPlotPoints(snapshot.data!),
                                isCurved: false,
                                barWidth: 2.5,
                                colors: [
                                  Static.PrimaryColor,
                                ],
                                showingIndicators: [200, 200, 90, 10],
                                dotData: FlDotData(
                                  show: true,
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
                      fontSize: 32.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                //
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Map dataAtIndex = snapshot.data![index];
                    if (dataAtIndex['type'] == "Income") {
                      return incomeTile(
                          dataAtIndex['amount'], dataAtIndex['note']);
                    } else {
                      return expenseTile(
                          dataAtIndex['amount'], dataAtIndex['note']);
                    }
                  },
                ),
                //
                // incomeTile(
                //   12000,
                // ),
                // expenseTile(
                //   2000,
                // ),
                // expenseTile(
                //   4000,
                // ),
                // expenseTile(
                //   2200,
                // ),
                //
                SizedBox(
                  height: 40.0,
                ),
              ],
            );
          } else {
            return Text(
              "Loading...",
            );
          }
        },
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

Widget expenseTile(int value, String note) {
  return Container(
    padding: const EdgeInsets.all(18.0),
    margin: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
        color: Color(0xffced4eb),
        borderRadius: BorderRadius.circular(
          8.0,
        )),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.arrow_circle_up_outlined,
                  size: 28.0,
                  color: Colors.red[700],
                ),
                SizedBox(
                  width: 4.0,
                ),
                Text(
                  "Expense",
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
        //
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Text(
            note,
            style: TextStyle(
              color: Colors.grey[800],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget incomeTile(int value, String note) {
  return Container(
    padding: const EdgeInsets.all(18.0),
    margin: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
        color: Color(0xffced4eb),
        borderRadius: BorderRadius.circular(
          8.0,
        )),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.arrow_circle_down_outlined,
                  size: 28.0,
                  color: Colors.green[700],
                ),
                SizedBox(
                  width: 4.0,
                ),
                Text(
                  "Credit",
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
        //
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Text(
            note,
            style: TextStyle(
              color: Colors.grey[800],
            ),
          ),
        ),
      ],
    ),
  );
}
