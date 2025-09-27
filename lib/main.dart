import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'department_list_screen.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MaterialApp(
        title: 'Departments App',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          scaffoldBackgroundColor: Colors.transparent, 
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: DepartmentListScreen(),
        builder: DevicePreview.appBuilder,
        locale: DevicePreview.locale(context),
        useInheritedMediaQuery: true,
      ),
    ),
  );
}
