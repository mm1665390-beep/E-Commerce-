import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
   mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              border: Border(
                bottom: BorderSide(width: 1.w, color: Colors.teal),
              ),
            ),
            height: 60.h,
            width: 60.h,
            child: Center(child: Text("data")),
          ),
        ],
      ),
    );
  }
}
