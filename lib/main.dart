

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(
          primaryColor: Colors.purple,
          accentColor: Colors.amber,
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )
              )
          )
      ),

      home: MyHomePage(),


    );
  }
}

class MyHomePage extends StatefulWidget {


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final minimumPadding = 10.0;
  var isDouble = false;

  var num1=0.0;
  var num2=0.0;
  var operand='';

  TextEditingController displayController = TextEditingController();

  //-----------building a raised button-----------

  Widget buildButton(String text, Function handler)
  {
    return Expanded(
      child: ButtonTheme(
        height: 40,
        buttonColor: Colors.white70,
        child: RaisedButton(
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'Digital-7',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: handler,
        ),
      ),
    );
  }
  //----------------------------------------

  //Adding some logic into buttons
  void digitHandler(String char)
  {
    displayController.text=displayController.text+char;
  }

  void pointerHandler()
  {
    if(!isDouble)
    {
      displayController.text=displayController.text+'.';
      isDouble=true;
    }
  }

  void delHandler()
  {
    String result=displayController.text;
    if(result.length>0)
    {
      displayController.text= result.substring(0,result.length-1);
    } else if(result.length==0)
    {
      displayController.clear();
    }
  }

  void signHandler()
  {
    String result =displayController.text;
    double num = double.parse(result);
    if(num==0)
    {

      return;
    }
    num = num*(-1);

    if(num*10%10==0)
    {
      displayController.text=num.toStringAsFixed(0);
    } else
    {
      displayController.text=num.toString();
    }

  }

  void operandHandler(String text)
  {
    num1=double.parse(displayController.text);

    switch(text)
    {
      case '+':
        operand='+';
        break;
      case '-':
        operand='-';
        break;
      case '*':
        operand='*';
        break;
      case '/':
        operand='/';
        break;
    }
    displayController.clear();
//    print(num1);
//    print(operand);
  }

  void equalHandler()
  {
    if(operand!='')
    {
      num2=double.parse(displayController.text);
      double result;
      switch(operand)
      {
        case '+':
          result=num1+num2;
          break;
        case '-':
          result=num1-num2;
          break;
        case '*':
          result=num1*num2;
          break;
        case '/':
          result=num1/num2;
          break;
      }


      displayController.text= result.toString();
    }
  }

  void clearHandler()
  {
    num1=0.0;
    num2=0.0;
    operand='';
    displayController.clear();
  }
  //----------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Container(
        margin: EdgeInsets.all(minimumPadding*2),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: minimumPadding, bottom: minimumPadding),
              child: TextField(
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.title,
                controller: displayController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: minimumPadding, bottom: minimumPadding),
              child: Row(
                children: <Widget>[
                  buildButton('7',(){digitHandler('7');}),
                  SizedBox(width: minimumPadding,),
                  buildButton('8',(){digitHandler('8');}),
                  SizedBox(width: minimumPadding,),
                  buildButton('9',(){digitHandler('9');}),
                  SizedBox(width: minimumPadding,),
                  buildButton('-',(){operandHandler('-');}),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: minimumPadding, bottom: minimumPadding),
              child: Row(
                children: <Widget>[
                  buildButton('4',(){digitHandler('4');}),
                  SizedBox(width: minimumPadding,),
                  buildButton('5',(){digitHandler('5');}),
                  SizedBox(width: minimumPadding,),
                  buildButton('6',(){digitHandler('6');}),
                  SizedBox(width: minimumPadding,),
                  buildButton('+',(){operandHandler('+');}),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: minimumPadding, bottom: minimumPadding),
              child: Row(
                children: <Widget>[
                  buildButton('3',(){digitHandler('3');}),
                  SizedBox(width: minimumPadding,),
                  buildButton('2',(){digitHandler('2');}),
                  SizedBox(width: minimumPadding,),
                  buildButton('1',(){digitHandler('1');}),
                  SizedBox(width: minimumPadding,),
                  buildButton('*',(){operandHandler('*');}),
                ],
              ),

            ),
            Padding(
              padding: EdgeInsets.only(top: minimumPadding, bottom: minimumPadding),
              child: Row(
                children: <Widget>[
                  buildButton('.',(){pointerHandler();}),
                  SizedBox(width: minimumPadding,),
                  buildButton('0',(){digitHandler('0');}),
                  SizedBox(width: minimumPadding,),
                  buildButton('+/-',(){signHandler();}),
                  SizedBox(width: minimumPadding,),
                  buildButton('/',(){operandHandler('/');}),
                ],
              ),

            ),
            Padding(
              padding: EdgeInsets.only(top: minimumPadding, bottom: minimumPadding),
              child: Row(
                children: <Widget>[
                  buildButton('DEL',(){delHandler();}),
                  SizedBox(width: minimumPadding,),
                  buildButton('=',(){equalHandler();}),
                  SizedBox(width: minimumPadding,),
                  buildButton('CLEAR',(){}),
                ],
              ),

            )
          ],
        ),

      ),
    );
  }
}

