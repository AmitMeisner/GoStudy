import 'package:flutter/material.dart';
import '../../Global.dart';
import 'enterTime.dart';
import '../HomeMain.dart';
import 'package:provider/provider.dart';

class NeuProgressPieBar extends StatefulWidget {
  @override
  _NeuProgressPieBarState createState() => _NeuProgressPieBarState();
}

class _NeuProgressPieBarState extends State<NeuProgressPieBar> {

  void reload(){
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white24,
            boxShadow: [
              BoxShadow(
                blurRadius: 15,
                spreadRadius: 5,
//                                  offset: Offset(10.5,10.5),
                color: Global.getBackgroundColor(50),
              ),
              BoxShadow(
                blurRadius: 15,
                offset: Offset(10.5, 10.5),
                color: Colors.blueAccent,
              )
            ],
          ),
          height: 150,
          width: 150,
          child:  NeuStartButton(),
        ),
        EnterTimeButton(reload)
      ],
    );
  }}

class NeuStartButton extends StatefulWidget {
  final double bevel;
  final Offset blurOffset;

  NeuStartButton({
    Key key,
    this.bevel = 10.0,
  })  : this.blurOffset = Offset(bevel / 2, bevel / 2),
        super(key: key);

  @override
  NeuStartButtonState createState() => NeuStartButtonState();
}

class NeuStartButtonState extends State<NeuStartButton> {
  bool _isPressed = false;
  static bool isRunning = true;

  void reloadNeuStartButtonState(){
    setState(() {});
  }

  void _onPointerDown() {
    setState(() {
      _isPressed = true;
    });
  }

  void _onPointerUp(PointerUpEvent event) {
    setState(() {
      _isPressed = false;
    });
  }


  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => Provider.of<TimerService>(context, listen: false).start());
  }

  @override
  void dispose() {
    isRunning=true;
    Provider.of<TimerService>(context, listen: false).stop();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) {
        _onPointerDown();
        isRunning
            ? Provider.of<TimerService>(context, listen: false).stop()
            : Provider.of<TimerService>(context, listen: false).start();
        setState((){
          isRunning = !isRunning;
        }
      );
      },
      onPointerUp: _onPointerUp,
      child:Container(
          child: isRunning? Icon(Icons.pause,size: 50,):Icon(Icons.play_arrow,size: 50,)
      ),
    );
  }

}
