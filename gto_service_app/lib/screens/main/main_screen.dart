import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/navigation/nav_bar.dart';
import 'package:gtoserviceapp/components/navigation/tabs.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GTO Service"),
        automaticallyImplyLeading: false,
      ),
      body: Center(child: CircularProgressIndicator()),
      bottomNavigationBar: NavigationBar(Tabs.Main),
    );
  }
}
