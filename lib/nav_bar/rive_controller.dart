import 'package:rive/rive.dart';

class RiveController{
  final String src, artboard, stateMachineName;
  final SMIBool? state;

  const RiveController({ 
    required this.src,
    required this.artboard,
    required this.stateMachineName,
    this.state
  });
}