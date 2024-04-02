import 'package:flutter/material.dart';
import 'package:navbar_animated_icons/nav_bar/app_nav_bar.dart';
import 'package:navbar_animated_icons/nav_bar/rive_nav_bar_item.dart';
import 'package:navbar_animated_icons/nav_bar/rive_controller.dart';
import 'package:navbar_animated_icons/nav_bar/widgets/nav_bar_item.dart';
import 'package:rive/rive.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var selectedPageTitle = "";

  final navBarItems = const [
    RiveNavBarItem(
      title: "Chat", 
      controller: RiveController(
        src: "assets/nav_bar_icons.riv", 
        artboard: "CHAT", 
        stateMachineName: "CHAT_Interactivity"
      )
    ),
    RiveNavBarItem(
      title: "Search", 
      controller: RiveController(
        src: "assets/nav_bar_icons.riv", 
        artboard: "SEARCH", 
        stateMachineName: "SEARCH_Interactivity"
      )
    ),
    RiveNavBarItem(
      title: "Timer", 
      controller: RiveController(
        src: "assets/nav_bar_icons.riv", 
        artboard: "TIMER", 
        stateMachineName: "TIMER_Interactivity"
      )
    ),
    RiveNavBarItem(
      title: "Bell", 
      controller: RiveController(
        src: "assets/nav_bar_icons.riv", 
        artboard: "BELL", 
        stateMachineName: "BELL_Interactivity"
      )
    ),
    RiveNavBarItem(
      title: "Gallery", 
      controller: RiveController(
        src: "assets/nav_bar_icons.riv", 
        artboard: "GALLERY", 
        stateMachineName: "GALLERY_Interactivity"
      )
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NavBarAnimatedIcons',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: Scaffold(
        bottomNavigationBar: MainNavBar(
          items: navBarItems,
          onSelect: (index){
            setState(() {
              selectedPageTitle = navBarItems[index].title;
            });
          },
        ),
        body: Center(
          child: Text(selectedPageTitle, 
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30
            ),
          )
        ),
      ),
    );
  }
}

class MainNavBar extends StatefulWidget{
  final List<RiveNavBarItem> items;
  final Function( int)? onSelect;
  final int? selectedIndex;
  const MainNavBar({ 
    super.key, 
    this.onSelect, 
    required 
    this.items, 
    this.selectedIndex
  });

  @override
  State<MainNavBar> createState() => _MainNavBarState();
}

class _MainNavBarState extends State<MainNavBar> {
  int? selectedIndex;
  final navBarInputs = <SMIBool>[];
  static const animationDuration = Duration(seconds: 1);
  static const selectDuration = Duration(milliseconds: 150);

  @override
  void initState(){
    super.initState();
    selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return AppNavBar(
      children: List.generate(widget.items.length, (index) =>
        Column(
          children: [
            AnimatedLine(
              width: index==selectedIndex?20:0,
              animationDuration: selectDuration
            ),
            GestureDetector(
              onTap: ()=> select(index),
              child: AnimatedOpacity(
                opacity: index==selectedIndex?1:0.4,
                duration: selectDuration,
                child: RiveNavBarItemWidget(
                  item: widget.items[index], 
                  onInit: (smController) {
                    navBarInputs.add(smController.findInput<bool>('active') as SMIBool);
                  },
                ),
              ),
            ),
          ],
        )).toList(),
    );
  }
  void select(int index){
    if(selectedIndex == index) return;
    setState(() {
      selectedIndex = index;
    });
    animateIcon(index, animationDuration);
    widget.onSelect?.call(index);
  }
  void animateIcon(int index, Duration duration) async {
    final input = navBarInputs[index];
    input.change(true);
    await Future.delayed(duration);
    input.change(false);
  }
  @override
  void dispose(){
    for (var input in navBarInputs) {
      input.controller.dispose();
    }
    super.dispose();
  }
}

class AnimatedLine extends StatelessWidget {
  final double? width;
  const AnimatedLine({
    super.key,
    this.animationDuration = const Duration(seconds: 1),
    this.width,
  });

  final Duration animationDuration;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: animationDuration,
      width: width,
      height: 4,
      decoration: const BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.all(Radius.circular(4))
      ),
    );
  }
}