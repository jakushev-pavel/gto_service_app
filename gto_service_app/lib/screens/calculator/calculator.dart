import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/navigation/nav_bar.dart';
import 'package:gtoserviceapp/components/navigation/tabs.dart';
import 'package:gtoserviceapp/screens/calculator/age_input.dart';
import 'package:gtoserviceapp/screens/calculator/gender_selector.dart';
import 'package:gtoserviceapp/screens/calculator/submit_button.dart';

class CalculatorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Калькулятор"),
          automaticallyImplyLeading: false,
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
        bottomNavigationBar: NavigationBar(Tabs.Calculator),
      ),
    );
  }
}
