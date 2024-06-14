import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:group_project/providers/theme.provider.dart';

class MenuTab extends StatelessWidget {
  const MenuTab(
      {super.key,
      required this.title,
      required this.icon,
      required this.onPressed,
      this.textColor});
  final String title;
  final IconData icon;
  final VoidCallback onPressed;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    return ListTile(
      onTap: onPressed,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
        ),
        child: Icon(icon, color: theme.isDarkTheme ? const Color.fromARGB(255, 101, 97, 118) : const Color.fromARGB(255, 70, 63, 58),),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      trailing: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: const Color.fromARGB(255,222,111,209).withOpacity(0.2)),
        child: const Icon(
          Icons.arrow_forward_ios_rounded,
          // color: Color.fromARGB(255, 188, 165, 231),
          size: 20,
        ),
      ),
    );
  }
}
