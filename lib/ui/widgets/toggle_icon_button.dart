import 'package:flutter/material.dart';

class ToggleHeartIconButton extends StatefulWidget {
  final Function(bool) onChanged;
  final bool initialValue;

  const ToggleHeartIconButton({
    Key? key,
    required this.onChanged,
    this.initialValue = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ToggleHeartIconButtonState();
}

class _ToggleHeartIconButtonState extends State<ToggleHeartIconButton> {
  late bool _isToggled;

  @override
  void initState() {
    super.initState();
    _isToggled = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      width: 30,
      height: 30,
      child: Center(
        child: IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(
              _isToggled ? Icons.favorite_outlined : Icons.favorite_border,
              color: _isToggled ? Colors.red : Colors.black),
          onPressed: () {
            setState(() {
              _isToggled = !_isToggled;
              widget.onChanged(_isToggled);
            });
          },
          color: _isToggled ? Colors.blue : Colors.grey,
        ),
      ),
    );
  }
}
