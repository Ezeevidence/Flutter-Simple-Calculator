import 'package:flutter/material.dart';
import "package:math_expressions/math_expressions.dart";

void main() {
  runApp(MaterialApp(
    home: Calculator(),
  ));
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String equation = '0';
  String result = '0';
  String expression = '';


  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C'){
        equation = '0';
        result = '0';
      }else if (buttonText == '⌫'){
        equation = equation.substring(0, equation.length -1);
      }else if (buttonText == ""){
        equation = '0';
      }else if (buttonText == "="){
        expression = equation;
        expression = expression.replaceAll('÷', "/");
        try{
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = "${(exp.evaluate(EvaluationType.REAL, cm))}";
        }catch(e){
          result = "Error";
        }

      }else {
        if (equation == '0') {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }


    });
  }


  Widget buildbutton(String buttonText, double buttonHeight, Color buttonColor){
    return Container(
      height: MediaQuery.of(context).size.height * 0.1* buttonHeight,
      color: buttonColor,
      child:
      FlatButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
            side: BorderSide(
                color: Colors.white,
                width: 1,
                style: BorderStyle.solid
            ),
          ),
          padding: EdgeInsets.all(16.0),
          onPressed:  () =>
            buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.normal,
                color: Colors.white
            ),
          )
      ),

    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Calculator',),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),

      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text('$equation', style: TextStyle(fontSize: 38.0),),
          ),

          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text('$result', style: TextStyle(fontSize: 48.0),),
          ),

          Expanded(
              child: Divider()
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width* .75,
                child: Table(
                  children: [

                    TableRow(
                      children: [
                        buildbutton('C', 1.0, Colors.redAccent),
                        buildbutton('⌫', 1.0, Colors.blue),
                        buildbutton('÷', 1.0, Colors.blue),
                      ],
                    ),

                    TableRow(
                      children: [
                        buildbutton('7', 1.0, Colors.black54),
                        buildbutton('8', 1.0, Colors.black54),
                        buildbutton('9', 1.0, Colors.black54),
                      ],
                    ),


                    TableRow(
                      children: [
                        buildbutton('4', 1.0, Colors.black54),
                        buildbutton('5', 1.0, Colors.black54),
                        buildbutton('6', 1.0, Colors.black54),
                      ],
                    ),


                    TableRow(
                      children: [
                        buildbutton('1', 1.0, Colors.black54),
                        buildbutton('2', 1.0, Colors.black54),
                        buildbutton('3', 1.0, Colors.black54),
                      ],
                    ),


                    TableRow(
                      children: [
                        buildbutton('.', 1.0, Colors.black54),
                        buildbutton('0', 1.0, Colors.black54),
                        buildbutton('00', 1.0, Colors.black54),
                      ],
                    ),


                  ],
                ),
              ),

              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildbutton('*', 1.0, Colors.blue),
                      ],
                    ),

                    TableRow(
                      children: [
                        buildbutton('-', 1.0, Colors.blue),
                      ],
                    ),

                    TableRow(
                      children: [
                        buildbutton('+', 1.0, Colors.blue),
                      ],
                    ),

                    TableRow(
                      children: [
                        buildbutton('=', 2.0, Colors.redAccent),
                      ],
                    ),
                  ],
                ),
              ),


            ],
          )

        ],

      ),
    );
  }
}
