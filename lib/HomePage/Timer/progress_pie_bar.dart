import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Global.dart';
import 'progress_painter.dart';
import '../HomeMain.dart';
import 'package:provider/provider.dart';

class NeuProgressPieBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    child:
    return Container(
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
      child:  Center(child: NeuStartButton()),
//                            GoogleFonts.pacifico(fontSize: 30),
//                            TextStyle(
//                                fontSize: 30, fontWeight: FontWeight.bold),

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
  static bool isRunning = false;

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

      });
      },
      onPointerUp: _onPointerUp,
      child: Container(
            child:Text(
              isRunning ? "Pause" : "Start",textAlign: TextAlign.center,
              style: GoogleFonts.meriendaOne(fontSize: 30, fontWeight: FontWeight.bold),
            )),

    );
  }
}

extension ColorUtils on Color {
  Color mix(Color another, double amount) {
    return Color.lerp(this, another, amount);
  }
}