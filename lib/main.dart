import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'Jetpack UI Chalenge'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double price = 0;
  bool isVisible = false;
  double people = 1;
  double tipsmoney = 0;
  double money = 100;
  double tipspercent = 0;
  TextEditingController textEditingController = TextEditingController();
  void changeMoney() {
    setState(() {
      isVisible = true;
      money = double.parse(textEditingController.text);
      price = (money + tipsmoney) / people;
    });
  }

  void changeTips() {
    setState(() {
      tipsmoney = money * tipspercent / 100;
      changeMoney();
    });
  }

  void changePeople() {
    setState(() {
      price = (money + tipsmoney) / people;
      changeMoney();
    });
  }

  @override
  Widget build(BuildContext context) {
    textEditingController.addListener(changeMoney);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          TextPerson(),
          EnterMoney(),
        ],
      ),
    );
  }

  Container EnterMoney() {
    return Container(
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          border: Border.all(width: 2, color: Colors.purple.shade100)),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(14),
          child: TextField(
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: 28, color: Colors.purple),
              controller: textEditingController,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.attach_money),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  focusColor: Colors.purple.shade100,
                  hoverColor: Colors.green,
                  // focusedBorder: OutlineInputBorder(
                  //   borderSide:
                  //       BorderSide(color: Colors.purple.shade100, width: 2),
                  // ),
                  // enabledBorder: OutlineInputBorder(
                  //   borderSide:
                  //       BorderSide(color: Colors.purple.shade100, width: 2),
                  // ),
                  hintText: 'Enter total Money',
                  labelText: "Money",
                  labelStyle: TextStyle(fontSize: 18, color: Colors.black))),
        ),
        Visibility(
          visible: isVisible,
          maintainAnimation: true,
          maintainState: true,
          maintainSize: true,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Text(
                    "Split",
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  RawMaterialButton(
                    onPressed: () {
                      setState(() {
                        if (people != 1) {
                          people--;
                          changeMoney();
                        }
                      });
                    },
                    fillColor: Colors.white,
                    child: Icon(
                      Icons.remove,
                      size: 16,
                    ),
                    padding: EdgeInsets.all(15.0),
                    shape: CircleBorder(),
                  ),
                  Text(
                    "$people",
                    style: TextStyle(fontSize: 20),
                  ),
                  RawMaterialButton(
                    onPressed: () {
                      setState(() {
                        people++;
                        changeMoney();
                      });
                    },
                    fillColor: Colors.white,
                    child: Icon(
                      Icons.add,
                      size: 16,
                    ),
                    padding: EdgeInsets.all(15.0),
                    shape: CircleBorder(),
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(children: [
                Text(
                  "Tips",
                  style: TextStyle(fontSize: 20),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    "\$ $tipsmoney",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "$tipspercent %",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Slider(
                value: tipspercent,
                label: tipspercent.toString(),
                min: 0,
                thumbColor: Colors.purple.shade100,
                inactiveColor: Colors.purple.shade100,
                max: 100,
                divisions: 10,
                onChanged: (newRating) {
                  setState(() {
                    tipspercent = newRating;
                    changeTips();
                  });
                })
          ]),
        ),
      ]),
    );
  }

  Container TextPerson() {
    return Container(
      height: 150,
      margin: EdgeInsets.all(20),
      // decoration: BoxDecoration(border: Border.all(width: 5)),
      decoration: BoxDecoration(
        border: Border.all(
          width: 3,
          color: Color.fromARGB(100, 235, 215, 248),
        ),
        color: Color.fromARGB(100, 235, 215, 248),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      // color: Color.fromARGB(0, 235, 215, 248),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Total Per Person",
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            "\$ ${price.toStringAsPrecision(3)}",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          )
        ],
      )),
    );
  }
}
