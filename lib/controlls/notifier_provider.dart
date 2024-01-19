import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_expressions/math_expressions.dart';

class CalcNotifier extends Notifier<String> {
  @override
  String build() {
    return '0';
  }

  List sybols = ['%', '÷', '×', '−', '+'];
// add values
  void addValue({required String str}) {
    List currentState = state.split('');
    if (currentState.length == 1 && currentState[0] == '0') {
      state = str;
    } else if (sybols.contains(currentState[currentState.length - 1]) &&
        sybols.contains(str)) {
      state = state.substring(0, state.length - 1) + str;
      // state = state + str;
    } else {
      state = state + str;
    }
  }

// clear the last value
  void removeLastValue() {
    state.isNotEmpty
        ? state = state.substring(0, state.length - 1)
        : state = '0';
  }

// clear Values
  void clearAllValue() {
    state = '0';
  }

// convert negative to positive and positive to negative
  void negativeOrNot() {
    try {
      if (int.parse(state).isNegative) {
        state = state.substring(1);
      } else {
        int value = -int.parse(state);
        state = value.toString();
      }
    } catch (e) {
      log(e.toString());
    }
  }

  // evaluation method
  void evaluateState() {
    List newList = state.split('');
    if (sybols.contains(newList[newList.length - 1])) {
      removeLastValue();
    } else {
      // replace symbols with correct operators
      state = state.replaceAll('−', '-');
      state = state.replaceAll('÷', '/');
      state = state.replaceAll('×', '*');
      // Createing the expression via the parser
      Parser p = Parser();
      Expression exp = p.parse(state);
      // Bind variables:
      ContextModel cm = ContextModel();
      double value = exp.evaluate(EvaluationType.REAL, cm);
      state = value.toStringAsFixed(3);
    }
  }

// specify the method upto the button
  buttonEvent({required String str}) {
    switch (str) {
      case 'AC':
        clearAllValue();
        break;
      case '+/-':
        negativeOrNot();
        break;
      // case '−':
      //   addValue(str: '-');
      //   break;
      // case '÷':
      //   addValue(str: "/");
      //   break;
      // case '×':
      //   addValue(str: "*");
      //   break;
      case 'C':
        removeLastValue();
        break;
      case '=':
        evaluateState();
        break;
      default:
        addValue(str: str);
        break;
    }
  }
}

// The provider
final notifyProvider =
    NotifierProvider<CalcNotifier, String>(() => CalcNotifier());
