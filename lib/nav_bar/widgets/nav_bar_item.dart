import 'package:flutter/material.dart';
import 'package:navbar_animated_icons/nav_bar/rive_nav_bar_item.dart';
import 'package:rive/rive.dart';

class RiveNavBarItemWidget extends StatelessWidget{
  final RiveNavBarItem item;
  final Function(StateMachineController smController) onInit;
  const RiveNavBarItemWidget({super.key, required this.item, required this.onInit});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 36,
      height: 36,
      child: RiveAnimation.asset(item.controller.src,
        artboard: item.controller.artboard,
        onInit: (artboard){
          var smController = StateMachineController.fromArtboard(
            artboard, 
            item.controller.stateMachineName
          );
          if(smController != null){
            artboard.addController(smController);
            onInit(smController);
          }
          else {
            throw Exception('Can not find "${item.controller.stateMachineName}" rive state machine name in "${item.controller.artboard}" artboard!');
          }
        },
      ),
    );
  }

}