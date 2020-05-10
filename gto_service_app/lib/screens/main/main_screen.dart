import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/widgets/navigation/nav_bar.dart';
import 'package:gtoserviceapp/components/widgets/navigation/tabs.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GTO Service"),
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: NavigationBar(Tabs.Main),
    );
  }
}
