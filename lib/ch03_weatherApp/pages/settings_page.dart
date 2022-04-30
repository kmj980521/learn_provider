// 날씨 정보를 화씨,섭씨로 표현하는 파트

import 'package:flutter/material.dart';
import 'package:learn_provider/ch03_weatherApp/providers/temp_settings_provider.dart';
import 'package:provider/provider.dart';
class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
        child: ListTile(
          title: Text('Temperature Unit'),
          subtitle: Text('Celsius/Fahrenheit (Default: Celsius)'),
          trailing: Switch(
            value: context.watch<TempSettingsProvider>().state.tempUnit == TempUnit.celsius,
            onChanged: (_) {
              context.read<TempSettingsProvider>().toggleTempUnit();
            },
          ),
        ),
      ),
    );
  }
}




