import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class ShadowWithinBox extends StatelessWidget {
  const ShadowWithinBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                offset: Offset(-20, -20),
                blurRadius: 60,
                color: Colors.white,
                inset: true,
              ),
              BoxShadow(
                offset: Offset(20, 20),
                blurRadius: 60,
                color: Colors.white,
                inset: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
