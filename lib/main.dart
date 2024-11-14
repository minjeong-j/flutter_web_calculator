import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Flutter Web Calculator')),
        body: CalculatorScreen(),
      ),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();

  void _calculateSum() {
    String value1 = _controller1.text;
    String value2 = _controller2.text;

    if (value1.isEmpty || value2.isEmpty) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Error"),
          content: Text("숫자를 입력하세요!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                if (value1.isEmpty) {
                  FocusScope.of(context).requestFocus(_focusNode1);
                } else {
                  FocusScope.of(context).requestFocus(_focusNode2);
                }
              },
              child: Text("확인"),
            ),
          ],
        ),
      );
    } else {
      int num1 = int.tryParse(value1) ?? 0;
      int num2 = int.tryParse(value2) ?? 0;
      int sum = num1 + num2;

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("결과"),
          content: Text("두 값의 합은 $sum 입니다."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("확인"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _controller1,
            focusNode: _focusNode1,
            decoration: InputDecoration(
              labelText: '첫 번째 숫자',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 16),
          TextField(
            controller: _controller2,
            focusNode: _focusNode2,
            decoration: InputDecoration(
              labelText: '두 번째 숫자',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: _calculateSum,
            child: Text("더하기"),
          ),
        ],
      ),
    );
  }
}
