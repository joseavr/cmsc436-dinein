import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:group_project/providers/theme.provider.dart';

class SwitchThemeTab extends StatefulWidget {
  const SwitchThemeTab({super.key});
  @override
  State<SwitchThemeTab> createState() => _SwitchThemeTab();
}

class _SwitchThemeTab extends State<SwitchThemeTab> {
  bool isDark = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    return ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
          ),
          child: Icon(isDark ? Icons.light_mode : Icons.dark_mode,
              color: theme.isDarkTheme
                  ? const Color.fromARGB(255, 101, 97, 118)
                  : const Color.fromARGB(255, 70, 63, 58)),
        ),
        title: Text(
          isDark ? "Light Mode" : "Dark Mode",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        trailing: Switch(
          value: isDark,
          activeColor: Colors.blue,
          inactiveTrackColor: Colors.grey,
          inactiveThumbColor: const Color.fromARGB(255, 202, 210, 197),
          onChanged: (value) {
            setState(() {
              isDark = value;
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            });
          },
        ));
  }
}
