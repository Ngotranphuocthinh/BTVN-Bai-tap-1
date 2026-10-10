import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final TextEditingController _aController = TextEditingController();
  final TextEditingController _bController = TextEditingController();
  String _result = '';

  void _calculate(String op) {
    final double? x = double.tryParse(_aController.text);
    final double? y = double.tryParse(_bController.text);

    if (x == null || y == null) {
      setState(() => _result = 'Vui lòng nhập số hợp lệ');
      return;
    }

    double? r;
    switch (op) {
      case '+':
        r = x + y;
        break;
      case '-':
        r = x - y;
        break;
      case '*':
        r = x * y;
        break;
      case '/':
        r = y == 0 ? null : x / y;
        break;
    }

    setState(() {
      if (r == null) {
        _result = 'Không thể chia cho 0';
      } else if (r == r.truncateToDouble()) {
        _result = r.toInt().toString(); // 8.0 -> 8
      } else {
        _result = r.toString();
      }
    });
  }

  @override
  void dispose() {
    _aController.dispose();
    _bController.dispose();
    super.dispose();
  }

  Widget _opButton(String label, Color color) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: SizedBox(
          height: 56,
          child: ElevatedButton(
            onPressed: () => _calculate(label),
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(label),
          ),
        ),
      ),
    );
  }

  InputDecoration _decoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(child: Text('Thực hành 03')),
              const SizedBox(height: 48),
              TextField(
                controller: _aController,
                keyboardType: const TextInputType.numberWithOptions(
                    decimal: true, signed: true),
                decoration: _decoration('Số thứ nhất'),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _opButton('+', const Color(0xFFDD4B4B)),
                  _opButton('-', const Color(0xFFDDA83F)),
                  _opButton('*', const Color(0xFF5B3FDD)),
                  _opButton('/', const Color(0xFF1C1C1E)),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _bController,
                keyboardType: const TextInputType.numberWithOptions(
                    decimal: true, signed: true),
                decoration: _decoration('Số thứ hai'),
              ),
              const SizedBox(height: 16),
              Text('Kết quả: $_result'),
            ],
          ),
        ),
      ),
    );
  }
}