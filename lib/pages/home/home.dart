import 'package:flutter/material.dart';
import 'package:project/pages/home/widgets/AppBarWidget.dart';
import 'package:project/pages/home/widgets/DrawerWidget.dart';
import 'package:project/pages/home/widgets/MenuWidget.dart';
import 'package:project/pages/home/widgets/SliderWidget.dart';

import 'Widgets/FindProduct.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const AppBarWidget(),
              const Findproduct(),
              const SliderWidget(),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 10),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    "Sản phẩm",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
              const MenuWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
