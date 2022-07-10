import 'package:flutter/material.dart';
import 'package:turistando/app/modules/home/home_page.dart';

class EntryPage extends StatefulWidget {
  const EntryPage({Key? key}) : super(key: key);

  @override
  State<EntryPage> createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  int currentIndex = 1;
  final pageController = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          Container(color: Colors.red),
          const HomePage(),
          Container(color: Colors.green),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (int newIndex) {
          setState(() {
            currentIndex = newIndex;
          });
          pageController.jumpToPage(newIndex);
        },
        items: const [
          BottomNavigationBarItem(
            label: "TOURS",
            icon: Icon(Icons.list),
          ),
          BottomNavigationBarItem(
            label: "MAPA",
            icon: Icon(Icons.location_on_sharp),
          ),
          BottomNavigationBarItem(
            label: "PERFIL",
            icon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
