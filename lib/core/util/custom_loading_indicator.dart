import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:reservasi/theme.dart';

class CustomLoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SpinKitDoubleBounce(
              color: MyTheme.primary, // Change color as needed
              size: 50.0, // Change size as needed
            ),
            SizedBox(height: 16),
            // Text(
            //   'Loading...',
            //   style: TextStyle(color: Colors.blue),
            // ),
          ],
        ),
      ),
    );
  }
}
