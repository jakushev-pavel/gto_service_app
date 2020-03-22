
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gtoserviceapp/common/nav_bar.dart';
import 'package:gtoserviceapp/screens/calculator/age_input.dart';
import 'package:gtoserviceapp/screens/calculator/gender_selector.dart';
import 'package:gtoserviceapp/screens/calculator/submit_button.dart';

class CalculatorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Калькулятор"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            GenderSelector(),
            AgeInput(),
            SubmitButton(),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ),
      bottomNavigationBar: NavigationBar(),
    );
  }
}