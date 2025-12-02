import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  static const String routeName = '/settings';
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _dark = false;
  String _lang = 'English';

  @override
  Widget build(BuildContext context) {
    print('SettingsScreen: dark=$_dark, lang=$_lang');
    final themePreview = _dark ? ThemeData.dark() : ThemeData.light();

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Dark theme (local preview)'),
            subtitle: const Text('This preview affects only this screen'),
            value: _dark,
            onChanged: (v) => setState(() => _dark = v),
          ),
          ListTile(
            title: const Text('Language'),
            subtitle: Text(_lang),
            trailing: const Icon(Icons.language),
            onTap: () async {
              final selected = await showModalBottomSheet<String>(
                context: context,
                builder: (_) => _LanguageSheet(current: _lang),
              );
              if (selected != null) {
                setState(() => _lang = selected);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Language set to $selected')),
                );
              }
            },
          ),
          const Divider(),
          Theme(
            data: themePreview,
            child: Card(
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: const [
                    Text('Theme preview'),
                    SizedBox(height: 8),
                    TextField(
                      decoration: InputDecoration(labelText: 'Sample input'),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: null,
                      child: Text('Sample button'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LanguageSheet extends StatelessWidget {
  final String current;
  const _LanguageSheet({Key? key, required this.current}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final options = const ['English', 'Arabic', 'French'];
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const ListTile(title: Text('Choose language')),
          for (final opt in options)
            RadioListTile<String>(
              title: Text(opt),
              value: opt,
              groupValue: current,
              onChanged: (v) => Navigator.pop(context, v),
            ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
