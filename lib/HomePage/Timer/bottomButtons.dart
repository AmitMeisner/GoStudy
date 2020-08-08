import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../Global.dart';
import '../HomeMain.dart';
import 'package:provider/provider.dart';

import 'dialog_helper.dart';


class NeuResetButton extends StatefulWidget {
  final double bevel;
  final Offset blurOffset;
  static bool reset=false;

  NeuResetButton({
    Key key,
    this.bevel = 10.0,
  })  : this.blurOffset = Offset(bevel / 2, bevel / 2),
        super(key: key);

  @override
  _NeuResetButtonState createState() => _NeuResetButtonState();
}

class _NeuResetButtonState extends State<NeuResetButton> {
  bool _isPressed = false;

  void _onPointerDown() {
    setState(() {
      TimerService.SendTime = TimerService.currentDurationTime;
      _isPressed = true;
    });
  }

  void _onPointerUp(PointerUpEvent event) {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) async{
        if(TimerService.currentDurationTime != Duration.zero){
          await DialogHelperResetAssertion.showError(context);
          if(NeuResetButton.reset) {
            _onPointerDown();
            final isRunning =
                Provider
                    .of<TimerService>(context, listen: false)
                    .isRunning;
            Provider.of<TimerService>(context, listen: false).reset();
            // If user press reset button when timer is running, start for them
            if (isRunning)
              Provider.of<TimerService>(context, listen: false).stop();
          }}
      },
      onPointerUp: _onPointerUp,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: MediaQuery.of(context).size.height/10,
//        width: 150,
        //padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
//          color: Color.fromRGBO(227, 237, 247, 1),
          color: Global.getBackgroundColor(0),
//          borderRadius: BorderRadius.circular(15),
          shape: BoxShape.circle,
          boxShadow: _isPressed
              ? null
              : [
            BoxShadow(
              blurRadius: 30,
              offset: -widget.blurOffset,
              color: Colors.white,
            ),
            BoxShadow(
              blurRadius: 30,
              offset: Offset(10.5, 10.5),
              color: Color.fromRGBO(214, 223, 230, 1),
            )
          ],
        ),
        child: Container(
          height: 50.0,
          width: 50.0,
          child: Icon(Icons.clear,size: 45.0,),
//          Text(
//            "Reset",
//            style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
//          ),

        ),
      ),
    );
  }
}


extension ColorUtils on Color {
  Color mix(Color another, double amount) {
    return Color.lerp(this, another, amount);
  }
}
