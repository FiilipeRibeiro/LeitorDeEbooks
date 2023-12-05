import 'package:flutter/material.dart';

abstract class EmitNotifier<T> extends ValueNotifier<T> {
  EmitNotifier(super.value);

  void notifier(T state) {
    value = state;
  }
}
