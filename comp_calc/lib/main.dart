import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _currentInput = '';
  double? _leftOperand;
  String? _operator;
  bool _shouldClear = false;

  String get _display {
    if (_leftOperand != null && _operator != null && !_shouldClear) {
      String leftStr = _formatNumber(_leftOperand!);
      if (_currentInput.isEmpty) {
        return '$leftStr $_operator ';
      } else {
        return '$leftStr $_operator $_currentInput';
      }
    }
    if (_currentInput.isEmpty) return '0';
    return _currentInput;
  }

  String _formatNumber(num value) {
    if (value is double && value % 1 == 0) {
      return value.toInt().toString();
    }
    String str = value.toString();
    if (str.contains('.') && str.length > 10) {
      return value.toStringAsFixed(5);
    }
    return str;
  }

  void _onDigit(String digit) {
    setState(() {
      if (_shouldClear) {
        _currentInput = digit;
        _shouldClear = false;
      } else {
        // Avoid multiple leading zeros, but allow "0." etc.
        if (digit == '0' && _currentInput == '0') return;
        _currentInput += digit;
      }
    });
  }

  void _onDecimal() {
    setState(() {
      if (_shouldClear) {
        _currentInput = '0.';
        _shouldClear = false;
        return;
      }
      if (!_currentInput.contains('.')) {
        if (_currentInput.isEmpty) {
          _currentInput = '0.';
        } else {
          _currentInput += '.';
        }
      }
    });
  }

  void _onOperator(String op) {
    setState(() {
      double current = double.tryParse(_currentInput) ?? 0.0;

      if (_leftOperand == null) {
        // First operand
        _leftOperand = current;
        _operator = op;
        _shouldClear = true;
      } else if (_operator != null) {
        // Perform pending operation
        double result = _compute(_leftOperand!, current, _operator!);
        _leftOperand = result;
        _operator = op;
        _currentInput = _formatNumber(result);
        _shouldClear = true;
      }
    });
  }

  void _onEquals() {
    setState(() {
      if (_leftOperand == null || _operator == null) return;
      double current = double.tryParse(_currentInput) ?? 0.0;
      double result = _compute(_leftOperand!, current, _operator!);
      _leftOperand = null;
      _operator = null;
      _currentInput = _formatNumber(result);
      _shouldClear = true;
    });
  }

  double _compute(double left, double right, String op) {
    switch (op) {
      case '+':
        return left + right;
      case '-':
        return left - right;
      case 'x':
        return left * right;
      case '÷':
        if (right == 0) {
          _currentInput = 'Error';
          _leftOperand = null;
          _operator = null;
          _shouldClear = true;
          return double.nan;
        }
        return left / right;
      default:
        return right;
    }
  }

  void _onClearAll() {
    setState(() {
      _currentInput = '';
      _leftOperand = null;
      _operator = null;
      _shouldClear = false;
    });
  }

  void _onDelete() {
    setState(() {
      if (_currentInput.isNotEmpty) {
        _currentInput = _currentInput.substring(0, _currentInput.length - 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Calculator",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(24),
              child: Text(
                _display,
                style: TextStyle(fontSize: 60, fontWeight: FontWeight.w400),
                maxLines: 1,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                _buildRow(['AC', 'del', '÷'], [1, 2, 1]),
                _buildRow(['7', '8', '9', 'x']),
                _buildRow(['1', '2', '3', '+']),
                _buildRow(['4', '5', '6', '-']),
                _buildRow(['0', '.', '%', '=']),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildRow(List<String> labels, [List<int>? flexValues]) {
    List<Widget> children = [];
    for (int i = 0; i < labels.length; i++) {
      int flex = (flexValues != null && i < flexValues.length)
          ? flexValues[i]
          : 1;
      children.add(
        Expanded(
          flex: flex,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: _buildButton(labels[i]),
          ),
        ),
      );
    }
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }

  Widget _buildButton(String label) {
    return ElevatedButton(
      onPressed: () => _onButtonPressed(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: _getButtonColor(label),
        foregroundColor: Colors.white,
        textStyle: TextStyle(fontSize: 28),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      child: Text(label),
    );
  }

  Color _getButtonColor(String label) {
    if (label == 'AC' || label == 'del') return Colors.purpleAccent.shade700;
    if (label == '÷' || label == 'x' || label == '-' || label == '+') {
      return Colors.lightBlue;
    }

    if (label == '=') return Colors.green.shade400;

    return Colors.blue.shade800;
  }

  void _onButtonPressed(String label) {
    if (RegExp(r'[0-9]').hasMatch(label)) {
      _onDigit(label);
    } else if (label == '.') {
      _onDecimal();
    } else if (label == 'AC') {
      _onClearAll();
    } else if (label == 'del') {
      _onDelete();
    } else if (label == '=') {
      _onEquals();
    } else {
      _onOperator(label);
    }
  }
}

