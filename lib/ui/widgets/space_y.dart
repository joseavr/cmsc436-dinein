import 'package:flutter/widgets.dart';

class SpaceY extends StatelessWidget {
  const SpaceY(this.y, {super.key});

  final double y;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: y,
    );
  }
}
