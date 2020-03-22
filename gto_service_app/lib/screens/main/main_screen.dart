
import 'package:flutter/material.dart';
import 'package:gtoserviceapp/common/nav_bar.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("GTO Service")),
      body: Center(child: CircularProgressIndicator()),
      bottomNavigationBar: NavigationBar(),
    );
  }
}