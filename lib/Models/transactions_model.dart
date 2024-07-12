import 'package:flutter/material.dart';

class Transaction {
  final String title;
  final String subtitle;
  final String amount;
  final String time;
  final IconData icon;
  final Color color;

  Transaction(this.title, this.subtitle, this.amount, this.time, this.icon, this.color);
}